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
package com.github.sdnwiselab.sdnwise.controller;

import com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter;
import com.github.sdnwiselab.sdnwise.controlplane.ControlPlaneLayer;
import com.github.sdnwiselab.sdnwise.controlplane.ControlPlaneLogger;
import com.github.sdnwiselab.sdnwise.flowtable.FlowTableEntry;
import com.github.sdnwiselab.sdnwise.function.FunctionInterface;
import com.github.sdnwiselab.sdnwise.packet.ConfigPacket;
import com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.ADD_ALIAS;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.ADD_FUNCTION;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.BEACON_PERIOD;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.GET_ALIAS;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.GET_RULE;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.MY_ADDRESS;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.MY_NET;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.PACKET_TTL;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.REM_ALIAS;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.REM_FUNCTION;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.REM_RULE;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.REPORT_PERIOD;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.RESET;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.RSSI_MIN;
import static com.github.sdnwiselab.sdnwise.packet.ConfigPacket.ConfigProperty.RULE_TTL;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.CONFIG;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.DFLT_HDR_LEN;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.MAX_PACKET_LENGTH;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.REG_PROXY;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.REPORT;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.REQUEST;
import com.github.sdnwiselab.sdnwise.packet.OpenPathPacket;
import com.github.sdnwiselab.sdnwise.packet.ReportPacket;
import com.github.sdnwiselab.sdnwise.packet.RequestPacket;
import com.github.sdnwiselab.sdnwise.packet.ResponsePacket;
import com.github.sdnwiselab.sdnwise.topology.NetworkGraph;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import static com.github.sdnwiselab.sdnwise.util.Utils.mergeBytes;
import static com.github.sdnwiselab.sdnwise.util.Utils.splitInteger;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Observable;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.TimeoutException;
import java.util.logging.Level;
import java.util.logging.Logger;
import net.jodah.expiringmap.ExpiringMap;

/**
 * Representation of the sensor network and resolver all the routing requests
 * coming from the network itself. This abstract class has two main methods.
 * manageRoutingRequest and graphUpdate. The first is called when a request is
 * coming from the network while the latter is called when something in the
 * topology of the network changes.
 * <p>
 * There are two main implementation of this class: ControllerDijkstra and
 * AbstractController Static.
 * <p>
 * This class also offers methods to send messages and configure the nodes in
 * the network.
 *
 * @author Sebastiano Milardo
 */
public abstract class AbstractController extends ControlPlaneLayer implements
        ControllerInterface {

    /**
     * Function buffer size.
     */
    private static final int BUFF_SIZE = 16384;
    /**
     * First request delay.
     */
    private static final int DELAY = 200;
    /**
     * Fields and lengths.
     */
    private static final int FUNCTION_HEADER_LEN = 3, CONFIG_HEADER_LEN = 1,
            FUNCTION_PAYLOAD_LEN = MAX_PACKET_LENGTH - (DFLT_HDR_LEN
            + FUNCTION_HEADER_LEN + CONFIG_HEADER_LEN);
    /**
     * Maximum number of parts for a function.
     */
    private static final int PARTS_MAX = 256;
    /**
     * Packet queue size.
     */
    private static final int QUEUE_SIZE = 1000;
    /**
     * Timeout for requests in cache.
     */
    protected static final int CACHE_EXP_TIME = 5;
    /**
     * To avoid garbage collection of the logger.
     */
    protected static final Logger LOGGER = Logger.getLogger("CTRL");
    /**
     * Timeout for a node request. Increase when using COOJA.
     */
    protected static final int RESPONSE_TIMEOUT = 300;
    /**
     * Incoming queue.
     */
    private final ArrayBlockingQueue<NetworkPacket> bQ
            = new ArrayBlockingQueue<>(QUEUE_SIZE);
    /**
     * Query cache.
     */
    private final Map<String, ConfigPacket> configCache = ExpiringMap
            .builder().expiration(CACHE_EXP_TIME, TimeUnit.SECONDS).build();
    /**
     * Identificator of the controller.
     */
    private final InetSocketAddress myId;
    /**
     * Network representation.
     */
    private final NetworkGraph networkGraph;

    /**
     * Request cache.
     */
    private final Map<String, RequestPacket> requestCache = ExpiringMap
            .builder().expiration(CACHE_EXP_TIME, TimeUnit.SECONDS).build();

    /**
     * Computed paths cache.
     */
    private final HashMap<NodeAddress, LinkedList<NodeAddress>> results
            = new HashMap<>();

    /**
     * Sink Address.
     */
    private NodeAddress sinkAddress;

    /**
     * Converts a Function into a series of ConfigPackets.
     *
     * @param net Network ID of the packet
     * @param src source address of the packet
     * @param dst destination address of the packet
     * @param id if of the function
     * @param buf the function itself as a byte array
     * @return a list of ConfigPackets
     */
    public static List<ConfigPacket> createConfigFunctionPackets(
            final byte net,
            final NodeAddress src,
            final NodeAddress dst,
            final byte id,
            final byte[] buf) {
        LinkedList<ConfigPacket> ll = new LinkedList<>();
        int packetNumber = buf.length / FUNCTION_PAYLOAD_LEN;
        int remaining = buf.length % FUNCTION_PAYLOAD_LEN;
        int totalPackets = packetNumber;
        if (remaining > 0) {
            totalPackets++;
        }
        int pointer = 0;
        int i = 0;

        if (packetNumber < PARTS_MAX) {
            if (packetNumber > 0) {
                for (i = 0; i < packetNumber; i++) {
                    byte[] payload = ByteBuffer.allocate(FUNCTION_PAYLOAD_LEN
                            + FUNCTION_HEADER_LEN)
                            .put(id)
                            .put((byte) (i + 1))
                            .put((byte) totalPackets)
                            .put(Arrays.copyOfRange(buf, pointer, pointer
                                    + FUNCTION_PAYLOAD_LEN)).array();
                    pointer += FUNCTION_PAYLOAD_LEN;
                    ConfigPacket np = new ConfigPacket(net, src, dst,
                            ADD_FUNCTION, payload);
                    ll.add(np);
                }
            }

            if (remaining > 0) {
                byte[] payload = ByteBuffer.allocate(remaining
                        + FUNCTION_HEADER_LEN)
                        .put(id)
                        .put((byte) (i + 1))
                        .put((byte) totalPackets)
                        .put(Arrays.copyOfRange(buf, pointer, pointer
                                + remaining)).array();
                ConfigPacket np = new ConfigPacket(net, src, dst, ADD_FUNCTION,
                        payload);
                ll.add(np);
            }
        }
        return ll;
    }

    /**
     * Constructor Method for the Controller Class.
     *
     * @param id ControllerId object.
     * @param lower Lower Adpater object.
     * @param network NetworkGraph object.
     */
    AbstractController(final InetSocketAddress id,
            final List<AbstractAdapter> lower,
            final NetworkGraph network,
            final NodeAddress sinkAddress) {
        super("CTRL", lower, null);
        this.sinkAddress = sinkAddress;
        ControlPlaneLogger.setupLogger(getLayerShortName());
        myId = id;
        networkGraph = network;
    }

    @Override
    public final void addNodeAlias(final byte net, final NodeAddress dst,
            final NodeAddress newAddr) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, ADD_ALIAS,
                newAddr.getArray());
        sendNetworkPacket(cp);
    }

    @Override
    public final void addNodeFunction(final byte net, final NodeAddress dst,
            final byte id, final String className) {
        try {
            InputStream is = FunctionInterface.class.getResourceAsStream(
                    className);
            ByteArrayOutputStream buffer = new ByteArrayOutputStream();

            int nRead;
            byte[] data = new byte[BUFF_SIZE];

            while ((nRead = is.read(data, 0, data.length)) != -1) {
                buffer.write(data, 0, nRead);
            }

            buffer.flush();

            List<ConfigPacket> ll = createConfigFunctionPackets(
                    net, sinkAddress, dst, id, buffer.toByteArray());
            Iterator<ConfigPacket> llIterator = ll.iterator();
            if (llIterator.hasNext()) {
                sendNetworkPacket(llIterator.next());
                Thread.sleep(DELAY);
                while (llIterator.hasNext()) {
                    sendNetworkPacket(llIterator.next());
                }
            }
        } catch (IOException | InterruptedException ex) {
            log(Level.SEVERE, ex.toString());
        }

    }

    @Override
    public final void addNodeRule(final byte net, final NodeAddress destination,
            final FlowTableEntry rule) {
        ResponsePacket rp = new ResponsePacket(
                net, sinkAddress, destination, rule);
        sendNetworkPacket(rp);
    }

    @Override
    public final InetSocketAddress getId() {
        return myId;
    }

    /**
     * Gets the topological representation of the network.
     *
     * @return a NetworkGraph object
     */
    @Override
    public final NetworkGraph getNetworkGraph() {
        return networkGraph;
    }

    @Override
    public final NodeAddress getNodeAddress(final byte net,
            final NodeAddress dst) {
        return new NodeAddress(getNodeValue(net, dst, MY_ADDRESS));
    }

    @Override
    public final NodeAddress getNodeAlias(final byte net, final NodeAddress dst,
            final byte index) {
        try {
            ConfigPacket cp = new ConfigPacket(
                    net, sinkAddress, dst, GET_ALIAS);
            cp.setParams(new byte[]{(byte) index}, GET_RULE.getSize());
            ConfigPacket response = sendQuery(cp);
            byte[] rule = Arrays.copyOfRange(
                    response.getParams(), 1, response.getPayloadSize() - 1);
            return new NodeAddress(rule);
        } catch (TimeoutException ex) {
            return null;
        }

    }

    @Override
    public final List<NodeAddress> getNodeAliases(final byte net,
            final NodeAddress dst) {
        List<NodeAddress> list = new LinkedList<>();
        NodeAddress na;
        int i = 0;
        while ((na = getNodeAlias(net, dst, (byte) i)) != null) {
            list.add(i, na);
            i++;
        }
        return list;
    }

    @Override
    public final int getNodeBeaconPeriod(final byte net,
            final NodeAddress dst) {
        return getNodeValue(net, dst, BEACON_PERIOD);
    }

    @Override
    public final int getNodeEntryTtl(final byte net,
            final NodeAddress dst) {
        return getNodeValue(net, dst, RULE_TTL);
    }

    @Override
    public final int getNodeNet(final byte net,
            final NodeAddress dst) {
        return getNodeValue(net, dst, MY_NET);
    }

    @Override
    public final int getNodePacketTtl(final byte net,
            final NodeAddress dst) {
        return getNodeValue(net, dst, PACKET_TTL);
    }

    @Override
    public final int getNodeReportPeriod(final byte net,
            final NodeAddress dst) {
        return getNodeValue(net, dst, REPORT_PERIOD);
    }

    @Override
    public final int getNodeRssiMin(final byte net,
            final NodeAddress dst) {
        return getNodeValue(net, dst, RSSI_MIN);
    }

    @Override
    public final FlowTableEntry getNodeRule(final byte net,
            final NodeAddress dst, final int index) {
        try {
            ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, GET_RULE);
            cp.setParams(new byte[]{(byte) index}, GET_RULE.getSize());
            ConfigPacket response = sendQuery(cp);
            byte[] rule = Arrays.copyOfRange(
                    response.getParams(), 1, response.getPayloadSize() - 1);
            if (rule.length > 0) {
                return new FlowTableEntry(rule);
            } else {
                return null;
            }
        } catch (TimeoutException ex) {
            return null;
        }
    }

    @Override
    public final List<FlowTableEntry> getNodeRules(final byte net,
            final NodeAddress dst) {
        List<FlowTableEntry> list = new ArrayList<>();
        FlowTableEntry fte;
        int i = 0;
        while ((fte = getNodeRule(net, dst, i)) != null) {
            list.add(i, fte);
            i++;
        }
        return list;
    }

    /**
     * Gets an HashMap with the already computed path.
     *
     * @return an hash map with the computed results
     */
    public final HashMap<NodeAddress, LinkedList<NodeAddress>> getResults() {
        return results;
    }

    @Override
    public final NodeAddress getSinkAddress() {
        return sinkAddress;
    }

    /**
     * Manages the packets coming from the network.
     *
     * @param data an incoming NetworkPacket
     */
    public final void managePacket(final NetworkPacket data) {

        switch (data.getTyp()) {
            case REPORT:
                networkGraph.updateMap(new ReportPacket(data));
                break;

            case REQUEST:
                RequestPacket req = new RequestPacket(data);
                NetworkPacket p = putInRequestCache(req);
                if (p != null) {
                    manageRoutingRequest(req, p);
                }
                break;

            case CONFIG:
                ConfigPacket cp = new ConfigPacket(data);

                String key;
                if (cp.getConfigId() == (GET_RULE)) {
                    key = cp.getNet() + " " + cp.getSrc() + " "
                            + cp.getConfigId() + " " + cp.getParams()[0];
                } else {
                    key = cp.getNet() + " " + cp.getSrc() + " "
                            + cp.getConfigId();
                }
                configCache.put(key, cp);
                break;
            case REG_PROXY:
                sinkAddress = data.getSrc();
                break;

            default:
                break;
        }
    }

    @Override
    public final void removeNodeAlias(final byte net, final NodeAddress dst,
            final byte index) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, REM_ALIAS,
                new byte[]{index});
        sendNetworkPacket(cp);
    }

    @Override
    public final void removeNodeFunction(final byte net, final NodeAddress dst,
            final byte index) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, REM_FUNCTION,
                new byte[]{index});
        sendNetworkPacket(cp);
    }

    @Override
    public final void removeNodeRule(final byte net, final NodeAddress dst,
            final byte index) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, REM_RULE,
                new byte[]{index});
        sendNetworkPacket(cp);
    }

    @Override
    public final void resetNode(final byte net, final NodeAddress dst) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, RESET);
        sendNetworkPacket(cp);
    }

    @Override
    public final void sendPath(final byte net, final NodeAddress dst,
            final List<NodeAddress> path) {
        OpenPathPacket op = new OpenPathPacket(net, sinkAddress, dst, path);
        sendNetworkPacket(op);
    }

    @Override
    public final void setNodeAddress(final byte net, final NodeAddress dst,
            final NodeAddress newAddress) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, MY_ADDRESS,
                newAddress.getArray());
        sendNetworkPacket(cp);
    }

    @Override
    public final void setNodeBeaconPeriod(final byte net, final NodeAddress dst,
            final short period) {
        ConfigPacket cp = new ConfigPacket(
                net, sinkAddress, dst, BEACON_PERIOD, splitInteger(period));
        sendNetworkPacket(cp);
    }

    @Override
    public final void setNodeEntryTtl(final byte net, final NodeAddress dst,
            final short period) {
        //TODO TTL should be in seconds
        ConfigPacket cp = new ConfigPacket(
                net, sinkAddress, dst, RULE_TTL, splitInteger(period));
        sendNetworkPacket(cp);
    }

    @Override
    public final void setNodeNet(final byte net, final NodeAddress dst,
            final byte newNet) {
        ConfigPacket cp = new ConfigPacket(
                net, sinkAddress, dst, MY_NET, new byte[]{newNet});
        sendNetworkPacket(cp);
    }

    @Override
    public final void setNodePacketTtl(final byte net, final NodeAddress dst,
            final byte newTtl) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, PACKET_TTL,
                new byte[]{newTtl});
        sendNetworkPacket(cp);
    }

    @Override
    public final void setNodeReportPeriod(final byte net, final NodeAddress dst,
            final short period) {
        ConfigPacket cp = new ConfigPacket(
                net, sinkAddress, dst, REPORT_PERIOD, splitInteger(period));
        sendNetworkPacket(cp);
    }

    @Override
    public final void setNodeRssiMin(final byte net, final NodeAddress dst,
            final byte newRssi) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, RSSI_MIN,
                new byte[]{newRssi});
        sendNetworkPacket(cp);
    }

    @Override
    public final void setupLayer() {
        new Thread(new Worker()).start();
        networkGraph.addObserver(this);
        register();
        setupNetwork();
    }

    /**
     * This methods manages updates coming from the lower adapter or the network
     * representation. When a message is received from the lower adapter it is
     * inserted in a ArrayBlockingQueue and then the method managePacket it is
     * called on it. While for updates coming from the network representation
     * the method graphUpdate is invoked.
     *
     * @param o the source of the event.
     * @param arg Object sent by Observable.
     */
    @Override
    public final void update(final Observable o, final Object arg) {
        for (AbstractAdapter adapter : getLower()) {
            if (o.equals(adapter)) {
                try {
                    bQ.put(new NetworkPacket((byte[]) arg));
                } catch (InterruptedException ex) {
                    log(Level.SEVERE, ex.toString());
                }
            } else if (o.equals(networkGraph)) {
                graphUpdate();
            }
        }
    }

    /**
     * Gets a property from a node.
     *
     * @param net Network ID of the packet
     * @param dst destination address of the packet
     * @param cfp the property to configure
     * @return the value from the node
     */
    private int getNodeValue(final byte net, final NodeAddress dst,
            final ConfigProperty cfp) {
        ConfigPacket cp = new ConfigPacket(net, sinkAddress, dst, cfp);
        try {
            byte[] res = sendQuery(cp).getParams();
            if (cfp.getSize() == 1) {
                return Byte.toUnsignedInt(res[0]);
            } else {
                return mergeBytes(res[0], res[1]);
            }
        } catch (TimeoutException ex) {
            log(Level.SEVERE, ex.toString());
            return -1;
        }
    }

    /**
     * Adds a Request packet in the cache. If the cache already contains a
     * request with the same key, it means that this is a response, therefore it
     * returns the packet, otherwise returns null
     *
     * @param rp an incoming Request packet
     * @return null if it sent by the controller, the RequestPacket if sent by a
     * node
     */
    private NetworkPacket putInRequestCache(final RequestPacket rp) {
        if (rp.getTotal() == 1) {
            return new NetworkPacket(rp.getData());
        }
        String key = rp.getSrc() + "." + rp.getId();
        if (requestCache.containsKey(key)) {
            RequestPacket p0 = requestCache.remove(key);
            return RequestPacket.mergePackets(p0, rp);
        } else {
            requestCache.put(key, rp);
        }
        return null;
    }

    /**
     * Will be used in the future to implement security polcies.
     */
    private void register() {
        //TODO we need to implement same sort of security check/auth.
    }

    /**
     * Sends a ConfigPacket to query the node.
     *
     * @param cp the Config packet to be sent
     * @return the response from the node
     * @throws TimeoutException if the node does not respond
     */
    private ConfigPacket sendQuery(final ConfigPacket cp)
            throws TimeoutException {

        sendNetworkPacket(cp);

        try {
            Thread.sleep(RESPONSE_TIMEOUT);
        } catch (InterruptedException ex) {
            log(Level.SEVERE, ex.toString());
        }

        String key;

        if (cp.getConfigId() == (GET_RULE)) {
            key = cp.getNet() + " "
                    + cp.getDst() + " "
                    + cp.getConfigId() + " "
                    + cp.getParams()[0];
        } else {
            key = cp.getNet() + " "
                    + cp.getDst() + " "
                    + cp.getConfigId();
        }
        if (configCache.containsKey(key)) {
            return configCache.remove(key);
        } else {
            throw new TimeoutException("No answer from the node");
        }
    }

    /**
     * This method sends a generic message to a node. The message is represented
     * by a NetworkPacket.
     *
     * @param packet the packet to be sent.
     */
    protected final void sendNetworkPacket(final NetworkPacket packet) {
        packet.setNxh(getSinkAddress());
        for (AbstractAdapter adapter : getLower()) {
            adapter.send(packet.toByteArray());
        }
    }

    /**
     * Manages the queue of incoming packets.
     */
    private class Worker implements Runnable {

        @Override
        public void run() {
            while (true) {
                try {
                    managePacket(bQ.take());
                } catch (InterruptedException ex) {
                    Logger.getGlobal().log(Level.SEVERE, ex.toString());
                }
            }
        }
    }
}
