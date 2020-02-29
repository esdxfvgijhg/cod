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
package com.github.sdnwiselab.sdnwise.adapter;

import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import gnu.io.CommPortIdentifier;
import gnu.io.PortInUseException;
import gnu.io.SerialPort;
import gnu.io.SerialPortEvent;
import gnu.io.SerialPortEventListener;
import gnu.io.UnsupportedCommOperationException;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.Map;
import java.util.Observable;
import java.util.TooManyListenersException;

import java.util.logging.Level;

/**
 * Representation of the serial port communication. Configuration data are
 * passed using a {@code Map<String,String>} which contains all the options
 * needed in the constructor of the class.
 *
 * @author Sebastiano Milardo
 */
public class AdapterCom extends AbstractAdapter {

    /**
     * Name of the COM port.
     */
    private final String portName;

    /**
     * Configuration parameters of the COM port.
     */
    private final int baudRate,
            dataBits,
            stopBits,
            parity;
    /**
     * Time in milliseconds to block waiting for port open.
     */
    private static final int TIMEOUT = 2000;

    /**
     * Each packet sent over the COM port has to start with the start byte and
     * it has end with the stopByte.
     */
    private final byte startByte, stopByte;

    /**
     * Serial Port.
     */
    private SerialPort comPort;

    /**
     * InputStream coming from the Serial Port.
     */
    private InputStream in;

    /**
     * OutputStream to the Serial Port.
     */
    private BufferedOutputStream out;

    /**
     * Creates an AdapterCom object. The conf map is used to pass the
     * configuration settings for the serial port as strings. Specifically
     * needed parameters are:
     * <ol>
     * <li>parity</li>
     * <li>stopBits</li>
     * <li>dataBits</li>
     * <li>baudRate</li>
     * <li>port</li>
     * <li>stopByte</li>
     * <li>startByte</li>
     * </ol>
     *
     * @param conf contains the serial port configuration data.
     */
    public AdapterCom(final Map<String, String> conf) {
        parity = Integer.parseInt(conf.get("PARITY"));
        stopBits = Integer.parseInt(conf.get("STOP_BITS"));
        dataBits = Integer.parseInt(conf.get("DATA_BITS"));
        baudRate = Integer.parseInt(conf.get("BAUD_RATE"));
        portName = conf.get("PORT_NAME");
        stopByte = Byte.parseByte(conf.get("STOP_BYTE"));
        startByte = Byte.parseByte(conf.get("START_BYTE"));
    }

    @Override
    public final boolean close() {
        try {
            comPort.close();
            in.close();
            setActive(false);
            return true;
        } catch (IOException ex) {
            log(Level.SEVERE, ex.toString());
            return false;
        }
    }

    @Override
    public final boolean open() {
        try {
            CommPortIdentifier portId;
            Enumeration portList = CommPortIdentifier.getPortIdentifiers();
            while (portList.hasMoreElements()) {
                portId = (CommPortIdentifier) portList.nextElement();
                if (portId.getPortType() == CommPortIdentifier.PORT_SERIAL) {
                    String port = portId.getName();
                    log(Level.INFO, "Serial Port Found: " + port);
                    if (port.equals(portName)) {
                        log(Level.INFO, "SINK");
                        comPort = (SerialPort) portId
                                .open("AdapterCOM", TIMEOUT);
                        break;
                    }
                }
            }

            if (comPort != null) {
                in = comPort.getInputStream();
                out = new BufferedOutputStream(comPort.getOutputStream());
                InternalSerialListener sl = new InternalSerialListener(in);
                sl.addObserver(this);
                comPort.setSerialPortParams(baudRate, dataBits, stopBits,
                        parity);
                comPort.addEventListener(sl);
                comPort.notifyOnDataAvailable(true);
                setActive(true);
                return true;
            } else {
                log(Level.SEVERE, "No serial port connected");
                return false;
            }
        } catch (PortInUseException | IOException | UnsupportedCommOperationException | NullPointerException | TooManyListenersException ex) {
            log(Level.SEVERE, "Unable to open Serial Port" + ex.toString());
            return false;
        }
    }

    @Override
    public final void send(final byte[] data) {
        if (isActive()) {
            try {
                int len = Byte.toUnsignedInt(data[0]);
                if (len <= NetworkPacket.MAX_PACKET_LENGTH) {
                    out.write(startByte);
                    out.write(data);
                    out.write(stopByte);
                    out.write('\n');
                    out.flush();
                }
            } catch (IOException ex) {
                log(Level.SEVERE, ex.toString());
            }
        }
    }

    /**
     * Creates packets from in InputStream.
     */
    private class InternalSerialListener extends Observable implements
            SerialPortEventListener {

        /**
         * Flags.
         */
        private boolean startFlag, idFlag;
        /**
         * Expected.
         */
        private int expected, b;
        /**
         * Current char.
         */
        private byte a;
        /**
         * Incoming buffer.
         */
        private final LinkedList<Byte> receivedBytes;
        /**
         * Incoming packet.
         */
        private final LinkedList<Byte> packet;
        /**
         * Receiving InputStream.
         */
        private final InputStream in;

        /**
         * Creates a Serial Listener from an InputStream.
         *
         * @param is the InputStream object
         */
        InternalSerialListener(final InputStream is) {
            packet = new LinkedList<>();
            receivedBytes = new LinkedList<>();
            in = is;
        }

        @Override
        public void serialEvent(final SerialPortEvent event) {
            if (event.getEventType() == SerialPortEvent.DATA_AVAILABLE) {
                try {
                    for (int i = 0; i < in.available(); i++) {
                        b = in.read();
                        //System.out.print((char)b); // DEBUG ONLY
                        if (b > -1) {
                            receivedBytes.add((byte) b);
                        }
                    }

                    while (!receivedBytes.isEmpty()) {
                        a = receivedBytes.poll();
                        if (!startFlag && a == startByte) {
                            startFlag = true;
                            packet.add(a);
                        } else if (startFlag && !idFlag) {
                            packet.add(a);
                            idFlag = true;
                        } else if (startFlag && idFlag && expected == 0) {
                            expected = Byte.toUnsignedInt(a);
                            packet.add(a);
                        } else if (startFlag && idFlag && expected > 0
                                && packet.size() < expected + 1) {
                            packet.add(a);
                        } else if (startFlag && idFlag && expected > 0
                                && packet.size() == expected + 1) {
                            packet.add(a);
                            if (a == stopByte) {
                                packet.removeFirst();
                                packet.removeLast();
                                byte[] bytePacket = new byte[packet.size()];
                                for (int i = 0; i < bytePacket.length; i++) {
                                    bytePacket[i] = packet.poll();
                                }
                                setChanged();
                                notifyObservers(bytePacket);
                            } else {
                                while (!packet.isEmpty()) {
                                    receivedBytes.addFirst(packet.removeLast());
                                }
                                receivedBytes.poll();
                            }
                            startFlag = false;
                            idFlag = false;
                            expected = 0;
                        }
                    }
                } catch (IOException e) {
                    log(Level.SEVERE, e.toString());
                }
            }
        }
    }
}
