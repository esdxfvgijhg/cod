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
package com.github.sdnwiselab.sdnwise.mote.core;

import com.github.sdnwiselab.sdnwise.packet.RegProxyPacket;
import com.github.sdnwiselab.sdnwise.mote.battery.Dischargeable;
import com.github.sdnwiselab.sdnwise.packet.BeaconPacket;
import com.github.sdnwiselab.sdnwise.packet.ConfigPacket;
import com.github.sdnwiselab.sdnwise.packet.DataPacket;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import com.github.sdnwiselab.sdnwise.util.Neighbor;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.net.InetSocketAddress;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.logging.Level;

/**
 * @author Sebastiano Milardo
 */
public class SinkCore extends AbstractCore {

    /**
     * Fake RSSI towards the Control plane.
     */
    private static final int CTRL_RSSI = 255;
    /**
     * Sink parameters.
     */
    private final String switchDPid, switchMac;
    /**
     * Sink physical port connetect to the controller.
     */
    private final long switchPort;
    /**
     * Sink controller ip and port.
     */
    private final InetSocketAddress addrController;

    /**
     * Contains the NetworkPacket that will be sent over the serial port to the
     * controller.
     */
    private final ArrayBlockingQueue<NetworkPacket> txControllerQueue
            = new ArrayBlockingQueue<>(QUEUE_SIZE);

    /**
     * Creates a new Sink node. The Sink node is the only node directly conneted
     * to the control plane.
     *
     * @param net Network ID of the packet
     * @param address the NodeAddress of the Sink
     * @param battery the kind of battery to use
     * @param dPid dPid of th Sink
     * @param mac MAC address of the Sink
     * @param port physical port to which the Control plane is connected
     * @param ctrl the address of the Control plane
     */
    public SinkCore(
            final byte net,
            final NodeAddress address,
            final Dischargeable battery,
            final String dPid,
            final String mac,
            final long port,
            final InetSocketAddress ctrl) {
        super(net, address, battery);
        this.switchDPid = dPid;
        this.switchMac = mac;
        this.switchPort = port;
        this.addrController = ctrl;
    }

    @Override
    public final void controllerTX(final NetworkPacket pck) {
        try {
            txControllerQueue.put(pck);
            log(Level.FINE, "CTX " + pck);
        } catch (InterruptedException ex) {
            log(Level.SEVERE, ex.toString());
        }
    }

    /**
     * Gets a packet to be send to the Control plane.
     *
     * @return a packet to be send
     * @throws InterruptedException because it waits for a packet in the queue
     */
    public final NetworkPacket getControllerPacketTobeSend()
            throws InterruptedException {
        return txControllerQueue.take();
    }

    @Override
    public final void dataCallback(final DataPacket packet) {
        controllerTX(packet);
    }

    @Override
    public final void rxConfig(final ConfigPacket packet) {
        NodeAddress dest = packet.getDst();
        NodeAddress src = packet.getSrc();

        if (!dest.equals(getMyAddress())) {
            runFlowMatch(packet);
        } else if (!src.equals(getMyAddress())) {
            controllerTX(packet);
        } else if (execConfigPacket(packet)) {
            controllerTX(packet);
        }
    }

    @Override
    public final NodeAddress getActualSinkAddress() {
        return getMyAddress();
    }

    @Override
    protected final void initSdnWiseSpecific() {
        setSinkDistance(0);
        setSinkRssi(CTRL_RSSI);
        setActive(true);
        RegProxyPacket rpp = new RegProxyPacket(1, getMyAddress(), switchDPid,
                switchMac, switchPort, addrController);
        controllerTX(rpp);
    }

    @Override
    protected final void reset() {
        // Nothing to do here
    }

    @Override
    protected final void rxBeacon(final BeaconPacket bp, final int rssi) {
        Neighbor nb = new Neighbor(bp.getSrc(), rssi, bp.getBattery());
        getNeighborTable().add(nb);
    }
}
