/*
 * Copyright (C) 2015 SDN-WISE
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package com.github.sdnwiselab.sdnwise.mote.standalone;

import com.github.sdnwiselab.sdnwise.mote.core.AbstractCore;
import static com.github.sdnwiselab.sdnwise.mote.core.AbstractCore.MAX_RSSI;
import com.github.sdnwiselab.sdnwise.mote.core.Pair;
import com.github.sdnwiselab.sdnwise.mote.logger.MoteFormatter;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.DATA;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import com.github.sdnwiselab.sdnwise.util.SimplerFormatter;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetSocketAddress;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;
import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.FileHandler;
import java.util.logging.Formatter;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.stream.Collectors;
import java.util.stream.Stream;

/**
 * @author Sebastiano Milardo
 */
public abstract class AbstractMote implements Runnable {

    /**
     * A second in milliseconds.
     */
    private static final int SECOND_IN_MILLIS = 1000;
    /**
     * Buffer for incoming packets.
     */
    private final byte[] buf = new byte[NetworkPacket.MAX_PACKET_LENGTH];
    /**
     * Logging level.
     */
    private final Level level;
    /**
     * Loggers.
     */
    private Logger logger, measureLogger;
    /**
     * The path to the file containing info on the neighbors.
     */
    private final String neighborFilePath;
    /**
     * The list of neighbors.
     */
    private Map<NodeAddress, FakeInfo> neighbourList;
    /**
     * Listening UDP port.
     */
    private final int port;
    /**
     * Statistics.
     */
    private int receivedBytes, receivedDataBytes, sentBytes, sentDataBytes;
    /**
     * Node Socket. Models the wireless connection.
     */
    private DatagramSocket socket;
    /**
     * The Core of the Node.
     */
    private AbstractCore core;

    /**
     * Creates a new AbstractMote.
     *
     * @param p the UDP listening port
     * @param nfp the path to the neighbor file
     * @param lvl the logging level of the node
     */
    public AbstractMote(
            final int p,
            final String nfp,
            final String lvl) {
        this.neighborFilePath = nfp;
        this.neighbourList = new HashMap<>();
        this.port = p;
        this.level = Level.parse(lvl);
    }

    /**
     * Logs information regarding the address, the battery level, number of
     * FlowTable entries, byte sent/received.
     */
    public final void logger() {
        measureLogger.log(Level.FINEST,
                "{0};{1};{2};{3};{4};{5};{6};{7};",
                new Object[]{core.getMyAddress(),
                    String.valueOf(core.getBattery().getLevel()),
                    String.valueOf(core.getBattery().getByteLevel()),
                    core.getFlowTableSize(),
                    sentBytes, receivedBytes,
                    sentDataBytes, receivedDataBytes});
    }

    /**
     * Sends a NetworkPacket.
     *
     * @param np the NetworkPacket to be sent
     */
    public final void radioTX(final NetworkPacket np) {

        if (np.isSdnWise()) {
            sentBytes += np.getLen();
            if (DATA == np.getTyp()) {
                sentDataBytes += np.getPayloadSize();
            }
        }

        core.getBattery().transmitRadio(np.getLen());

        logger.log(Level.FINE, "RTX {0}", np);

        NodeAddress tmpNxHop = np.getNxh();
        NodeAddress tmpDst = np.getDst();

        if (tmpDst.isBroadcast() || tmpNxHop.isBroadcast()) {

            neighbourList.entrySet().stream()
                    .map((isa) -> new DatagramPacket(np.toByteArray(),
                    np.getLen(), isa.getValue().inetAddress)).forEach((pck) -> {
                try {
                    socket.send(pck);
                } catch (IOException ex) {
                    logger.log(Level.SEVERE, null, ex);
                }
            });
        } else {
            FakeInfo isa = neighbourList.get(tmpNxHop);
            if (isa != null) {
                try {
                    DatagramPacket pck = new DatagramPacket(np.toByteArray(),
                            np.getLen(), isa.inetAddress);
                    socket.send(pck);

                } catch (IOException ex) {
                    logger.log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    @Override
    public final void run() {
        try {

            measureLogger = initLogger(Level.FINEST, "M_" + core.getMyAddress()
                + ".log", new MoteFormatter());

            logger = initLogger(level, core.getMyAddress()
                + ".log", new SimplerFormatter(core.getMyAddress().toString()));

            Path path = Paths.get(neighborFilePath);
            BufferedReader reader;

            if (!Files.exists(path)) {
                logger.log(Level.INFO, "External Config file not found. "
                        + "Loading default values.");
                InputStream in = getClass()
                        .getResourceAsStream("/" + neighborFilePath);
                reader = new BufferedReader(new InputStreamReader(in));
            } else {
                reader = new BufferedReader(new FileReader(neighborFilePath));
            }

            try (Stream<String> lines = reader.lines()) {
                neighbourList = lines.parallel()
                        .map(line -> line.trim())
                        .filter(line -> !line.isEmpty())
                        .map(line -> line.split(","))
                        .map(e -> new Object() {
                            private final NodeAddress addr =
                                    new NodeAddress(e[0]);
                            private final FakeInfo fk = new FakeInfo(
                                    new InetSocketAddress(e[1],
                                            Integer.parseInt(e[2])
                                    ), Integer.parseInt(e[3])
                            );
                        }
                        ).collect(Collectors
                                .toConcurrentMap(e -> e.addr, e -> e.fk));
            }

            DatagramPacket packet = new DatagramPacket(buf, buf.length);
            socket = new DatagramSocket(port);

            new Timer().schedule(new TaskTimer(), SECOND_IN_MILLIS,
                    SECOND_IN_MILLIS);
            startThreads();

            while (core.getBattery().getByteLevel() > 0) {
                socket.receive(packet);
                NetworkPacket np = new NetworkPacket(packet.getData());
                int rssi = MAX_RSSI;
                if (np.isSdnWise()) {
                    logger.log(Level.FINE, "RRX {0}", np);
                    FakeInfo fk = neighbourList.get(np.getSrc());
                    if (fk != null) {
                        rssi = fk.rssi;
                    } else {
                        rssi = MAX_RSSI;
                    }

                    if (DATA == np.getTyp()) {
                        receivedDataBytes += np.getPayloadSize();
                    }
                }
                core.rxRadioPacket(np, rssi);
            }
        } catch (IOException | RuntimeException ex) {
            logger.log(Level.SEVERE, ex.toString());
        }
    }

    /**
     * Initialize the loggers.
     *
     * @param lvl logging level
     * @param file file name for the logs
     * @param formatter log formatter
     * @return the logger itself
     */
    private Logger initLogger(
            final Level lvl,
            final String file,
            final Formatter formatter) {
        Logger log = Logger.getLogger(file);
        log.setLevel(lvl);
        try {
            FileHandler fh;
            File dir = new File("logs");
            dir.mkdir();
            fh = new FileHandler("logs/" + file);
            fh.setFormatter(formatter);
            log.addHandler(fh);
            log.setUseParentHandlers(false);
        } catch (IOException | SecurityException ex) {
            log.log(Level.SEVERE, null, ex);
        }
        return log;
    }

    /**
     * Starts the threads of the Node.
     */
    protected void startThreads() {
        new Thread(new SenderRunnable()).start();
        new Thread(new LoggerRunnable()).start();
    }

    /**
     * Simulates neighbors info.
     */
    private class FakeInfo {

        /**
         * The socket address of the neighbor.
         */
        private InetSocketAddress inetAddress;
        /**
         * The rssi of the neighbor.
         */
        private int rssi;

        /**
         * Creates a new FakeInfo object.
         *
         * @param ia the InetAddress of the neighbor
         * @param fakeRssi the rssi of the neighbor
         */
        FakeInfo(final InetSocketAddress ia, final int fakeRssi) {
            this.inetAddress = ia;
            this.rssi = fakeRssi;
        }
    }

    /**
     * Models a thread that logs the messages coming from the core.
     */
    private class LoggerRunnable implements Runnable {

        @Override
        public void run() {
            try {
                while (true) {
                    Pair<Level, String> tmp = core.getLogToBePrinted();
                    logger.log(tmp.getKey(), tmp.getValue());
                }
            } catch (Exception ex) {
                logger.log(Level.SEVERE, ex.toString());
            }
        }
    }

    /**
     * Models a thread that sends the messages coming from the core.
     */
    private class SenderRunnable implements Runnable {

        @Override
        public void run() {
            try {
                while (true) {
                    radioTX(core.getNetworkPacketToBeSend());
                }
            } catch (InterruptedException ex) {
                logger.log(Level.SEVERE, ex.toString());
            }
        }
    }

    /**
     * Model a thread that simulates the clock of the node.
     */
    private class TaskTimer extends TimerTask {

        @Override
        public void run() {
            if (core.getBattery().getByteLevel() > 0) {
                core.timer();
                core.getBattery().keepAlive(1);
            }
            logger();
        }
    }

    /**
     * Gets the core of the node.
     * @return the core of the node
     */
    public final AbstractCore getCore() {
        return core;
    }

    /**
     * Sets the core of the node.
     * @param cr the core of the node
     * @return the core itself
     */
    public final AbstractCore setCore(final AbstractCore cr) {
        core = cr;
        return core;
    }
}
