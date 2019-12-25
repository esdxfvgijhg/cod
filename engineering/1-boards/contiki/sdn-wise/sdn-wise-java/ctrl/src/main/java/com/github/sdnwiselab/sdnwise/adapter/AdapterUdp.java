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
import java.io.IOException;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
import java.net.SocketException;
import java.util.Arrays;
import java.util.Map;
import java.util.Observable;
import java.util.logging.Level;

/**
 * Representation an UDP Adapter. Configuration data are passed using a
 * {@code Map<String,String>} which contains all the options needed in the
 * constructor of the class.
 *
 * @author Sebastiano Milardo
 */
public class AdapterUdp extends AbstractAdapter {

    /**
     * UDP port of the source.
     */
    private final int inPort;
    /**
     * IP address of the destination.
     */
    private final String outIp;
    /**
     * UDP port of the destination.
     */
    private final int outPort;
    /**
     * UDP Socket.
     */
    private DatagramSocket sck;
    /**
     * Models an UDP receiver.
     */
    private InternalUDPServer udpServer;

    /**
     * Creates an AdapterUDP object. The conf map is used to pass the
     * configuration settings for the UDP socket as strings. Specifically the
     * needed parameters are:
     * <ol>
     * <li>IP</li>
     * <li>PORT</li>
     * <li>IN_PORT</li>
     * </ol>
     *
     * @param conf contains the serial port configuration data.
     */
    public AdapterUdp(final Map<String, String> conf) {
        outIp = conf.get("IP");
        outPort = Integer.parseInt(conf.get("PORT"));
        inPort = Integer.parseInt(conf.get("IN_PORT"));
    }

    @Override
    public final boolean close() {
        udpServer.isStopped = true;
        sck.close();
        return true;
    }

    @Override
    public final boolean open() {
        try {
            sck = new DatagramSocket(inPort);
            udpServer = new InternalUDPServer();
            udpServer.addObserver(this);
            new Thread(udpServer).start();
            return true;
        } catch (SocketException ex) {
            log(Level.SEVERE, ex.toString());
            return false;
        }
    }

    @Override
    public final void send(final byte[] data) {
        try {
            DatagramPacket packet = new DatagramPacket(
                    data, data.length, InetAddress.getByName(outIp), outPort);
            sck.send(packet);
        } catch (IOException ex) {
            log(Level.SEVERE, ex.toString());
        }
    }

    /**
     * Sends a byte array using this adapter. This method also specifies the
     * destination IP address and UDP port.
     *
     * @param data the array to be sent
     * @param ip a string containing the IP address of the destination
     * @param port an integer containing the UDP port of the destination
     */
    public final void send(final byte[] data, final String ip, final int port) {
        try {
            DatagramPacket packet = new DatagramPacket(
                    data, data.length, InetAddress.getByName(ip), port);
            sck.send(packet);
        } catch (IOException ex) {
            log(Level.SEVERE, ex.toString());
        }
    }

    /**
     * Models an UDP Receiver.
     */
    private final class InternalUDPServer extends Observable implements
            Runnable {

        /**
         * Manages the status of the server.
         */
        private boolean isStopped;

        @Override
        public void run() {
            try {
                byte[] buffer = new byte[NetworkPacket.MAX_PACKET_LENGTH];
                DatagramPacket p = new DatagramPacket(buffer, buffer.length);
                while (!isStopped) {
                    sck.receive(p);
                    setChanged();
                    notifyObservers(Arrays.copyOf(p.getData(), p.getLength()));
                }
            } catch (IOException ex) {
                log(Level.SEVERE, ex.toString());
            }
        }
    }
}
