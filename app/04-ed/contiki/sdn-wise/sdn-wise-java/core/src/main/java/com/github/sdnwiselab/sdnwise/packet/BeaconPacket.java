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

import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.BEACON;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import static com.github.sdnwiselab.sdnwise.util.NodeAddress.BROADCAST_ADDR;

/**
 * This class models a Beacon packet. The Beacon packet is used to advertise the
 * existence of a node.
 *
 * @author Sebastiano Milardo
 */
public class BeaconPacket extends NetworkPacket {

    /**
     * Distance is at payload position 0, the residual charge at position 1.
     */
    private static final byte DIST_INDEX = 0,
            BATT_INDEX = 1;

    /**
     * This constructor initialize a beacon packet starting from a byte array.
     *
     * @param data the byte array representing the beacon packet
     */
    public BeaconPacket(final byte[] data) {
        super(data);
    }

    /**
     * This constructor initialize a beacon packet starting from a int array.
     *
     * @param data the int array representing the beacon packet, all int are
     * casted to byte
     */
    public BeaconPacket(final int[] data) {
        super(data);
    }

    /**
     * This constructor initialize a beacon packet starting from a
     * NetworkPacket.
     *
     * @param data the NetworkPacket representing the beacon packet
     */
    public BeaconPacket(final NetworkPacket data) {
        super(data.toByteArray());
    }

    /**
     * This constructor initialize a beacon packet. The type of the packet is
     * set to {@code BEACON} and the destination address is
     * {@code BROADCAST_ADDR}.
     *
     * @param net Network ID of the packet
     * @param src source address of the packet
     * @param sink sink address of the source node
     * @param distance the distance from the sink in no. of hops
     * @param battery the residual charge of the node
     */
    public BeaconPacket(final int net, final NodeAddress src,
            final NodeAddress sink,
            final int distance, final int battery) {
        super(net, src, BROADCAST_ADDR);
        setTyp(BEACON);
        setSinkAddress(sink);
        setDistance((byte) distance);
        setBattery((byte) battery);
    }

    /**
     * Getter for the number of hops between the source node and the sink.
     *
     * @return the number of hops between the source node and the sink
     */
    public final int getDistance() {
        return Byte.toUnsignedInt(getPayloadAt(DIST_INDEX));
    }

    /**
     * Setter for the number of hops between the source node and the sink.
     *
     * @param value the number of hops between the source node and the sink
     * @return the packet itself
     */
    public final BeaconPacket setDistance(final byte value) {
        setPayloadAt(value, DIST_INDEX);
        return this;
    }

    /**
     * Returns an estimation of the residual charge of the batteries of the
     * node. The possible values are: [0x00-0xFF] 0x00 = no charge, 0xFF = full
     * charge.
     *
     * @return an estimation of the residual charge of the batteries of the node
     */
    public final int getBattery() {
        return Byte.toUnsignedInt(getPayloadAt(BATT_INDEX));
    }

    /**
     * Set the battery level in the packet. The possible values are: [0x00-0xFF]
     * 0x00 = no charge, 0xFF = full charge.
     *
     * @param value the value of the battery level
     * @return the packet itself
     */
    public final BeaconPacket setBattery(final byte value) {
        setPayloadAt(value, BATT_INDEX);
        return this;
    }

    /**
     * Set the address of the sink to which this node is connected.
     *
     * @param addr the address of the sink
     * @return the packet itself
     */
    public final BeaconPacket setSinkAddress(final NodeAddress addr) {
        setNxh(addr);
        return this;
    }

    /**
     * Get the address of the sink to which this node is connected.
     *
     * @return the address of the sink
     */
    public final NodeAddress getSinkAddress() {
        return getNxh();
    }
}
