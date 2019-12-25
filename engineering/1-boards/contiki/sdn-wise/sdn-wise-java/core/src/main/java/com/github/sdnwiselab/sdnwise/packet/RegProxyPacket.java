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
package com.github.sdnwiselab.sdnwise.packet;

import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.REG_PROXY;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import com.github.sdnwiselab.sdnwise.util.Utils;
import java.math.BigInteger;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.UnknownHostException;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;

/**
 * @author Sebastiano Milardo
 */
public class RegProxyPacket extends NetworkPacket {

    /**
     * Fields, indexes and lenghts.
     */
    private static final int DPID_INDEX = 0, DPID_LEN = 8,
            IP_LEN = 4,
            MAC_INDEX = DPID_INDEX + DPID_LEN, MAC_LEN = 6, MAC_STR_LEN = 18,
            PORT_INDEX = MAC_INDEX + MAC_LEN, PORT_LEN = 8,
            IP_INDEX = PORT_INDEX + PORT_LEN, RADIX = 16,
            TCP_INDEX = IP_INDEX + IP_LEN;

    /**
     * This constructor initialize a RegProxy packet starting from a byte array.
     *
     * @param data the byte array representing the beacon packet.
     */
    public RegProxyPacket(final byte[] data) {
        super(data);
    }

    /**
     * This constructor initialize a RegProxy packet starting from a
     * NetworkPacket.
     *
     * @param data the NetworkPacket representing the beacon packet.
     */
    public RegProxyPacket(final NetworkPacket data) {
        super(data.toByteArray());
    }

    /**
     * This constructor initialize a RegProxy packet. The type of the packet is
     * set to REG_PROXY and the destination isa is src beacuse this message is
     * only sent by sinks.
     *
     * @param net Network ID of the packet
     * @param src sorce address
     * @param dPid dpid
     * @param mac mac address
     * @param port physical port
     * @param isa InetSocketAddress of the node
     */
    public RegProxyPacket(final int net, final NodeAddress src,
            final String dPid,
            final String mac,
            final long port,
            final InetSocketAddress isa) {
        super(net, src, src);
        setTyp(REG_PROXY);
        setMac(mac);
        setDpid(dPid);
        setPort(port);
        setNxh(src);
        setInetSocketAddress(isa);
    }

    /**
     * This constructor initialize a RegProxy packet starting from a int array.
     *
     * @param data the int array representing the beacon packet, all ints are
     * casted to byte.
     */
    public RegProxyPacket(final int[] data) {
        super(data);
    }

    /**
     * Gets the Dpid of the node sending the packet.
     *
     * @return the dPid of the Sink node
     */
    public final String getDpid() {
        return new String(getPayloadFromTo(DPID_INDEX, MAC_INDEX));
    }

    /**
     * Gets the InetSocketAddress of the node sending the packet.
     *
     * @return the InetSocketAddress of the Sink node
     */
    public final InetSocketAddress getInetSocketAddress() {
        try {
            byte[] ip = getPayloadFromTo(IP_INDEX, IP_INDEX + IP_LEN);
            return new InetSocketAddress(InetAddress.getByAddress(ip),
                    Utils.mergeBytes(getPayloadAt(TCP_INDEX),
                            getPayloadAt(TCP_INDEX + 1)));
        } catch (UnknownHostException ex) {
            return null;
        }
    }

    /**
     * Gets the MAC address of the node sending the packet.
     *
     * @return the MAC address of the Sink node
     */
    public final String getMac() {
        StringBuilder sb = new StringBuilder(MAC_STR_LEN);
        byte[] mac = getPayloadFromTo(MAC_INDEX, MAC_INDEX + MAC_LEN);
        for (byte b : mac) {
            if (sb.length() > 0) {
                sb.append(':');
            }
            sb.append(String.format("%02x", b));
        }
        return sb.toString();
    }

    /**
     * Gets the physical port of the node sending the packet.
     *
     * @return the physical port of the Sink node
     */
    public final long getPort() {
        return new BigInteger(getPayloadFromTo(PORT_INDEX, PORT_INDEX
                + PORT_LEN)).longValue();
    }

    /**
     * Sets the dPid.
     *
     * @param dPid the dPid to set
     * @return the packet itself
     */
    public final RegProxyPacket setDpid(final String dPid) {
        byte[] dpid = dPid.getBytes(Charset.forName("UTF-8"));
        int len = Math.min(DPID_LEN, dpid.length);
        setPayload(dpid, 0, DPID_INDEX, len);
        return this;
    }

    /**
     * Sets the InetSocketAddress.
     *
     * @param isa the InetSocketAddress to set
     * @return the packet itself
     */
    public final RegProxyPacket setInetSocketAddress(
            final InetSocketAddress isa) {
        byte[] ip = isa.getAddress().getAddress();
        int port = isa.getPort();
        return setInetSocketAddress(ip, port);
    }

    /**
     * Sets the MAC address.
     *
     * @param mac the MAC address to set
     * @return the packet itself
     */
    public final RegProxyPacket setMac(final String mac) {
        String[] elements = mac.split(":");
        if (elements.length != MAC_LEN) {
            throw new IllegalArgumentException("Invalid MAC address");
        }
        for (int i = 0; i < MAC_LEN; i++) {
            setPayloadAt((byte) Integer.parseInt(elements[i], RADIX),
                    MAC_INDEX + i);
        }
        return this;
    }

    /**
     * Sets the physical port.
     *
     * @param port the physical port to set
     * @return the packet itself
     */
    public final RegProxyPacket setPort(final long port) {
        byte[] bytes = ByteBuffer
                .allocate(Long.SIZE / Byte.SIZE).putLong(port).array();
        setPayload(bytes, (byte) 0, PORT_INDEX, PORT_LEN);
        return this;
    }

    /**
     * Sets the InetSocketAddress.
     *
     * @param ip the IP Address to set
     * @param p the port to set
     * @return the packet itself
     */
    private RegProxyPacket setInetSocketAddress(final byte[] ip, final int p) {
        setPayload(ip, 0, IP_INDEX, IP_LEN);
        setPayloadAt((byte) (p), TCP_INDEX + 1);
        setPayloadAt((byte) (p >> Byte.SIZE), TCP_INDEX);
        return this;
    }

}
