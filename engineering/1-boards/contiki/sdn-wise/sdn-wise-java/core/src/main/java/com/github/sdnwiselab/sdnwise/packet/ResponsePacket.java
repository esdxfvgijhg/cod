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

import com.github.sdnwiselab.sdnwise.flowtable.FlowTableEntry;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.RESPONSE;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.util.Arrays;

/**
 * This class models an Response packet.
 *
 * @author Sebastiano Milardo
 */
public class ResponsePacket extends NetworkPacket {

    /**
     * This constructor initialize a response packet starting from a byte array.
     *
     * @param data the byte array representing the response packet.
     */
    public ResponsePacket(final byte[] data) {
        super(data);
    }

    /**
     * This constructor initialize a response packet starting from a
     * NetworkPacket.
     *
     * @param data the NetworkPacket representing the response packet.
     */
    public ResponsePacket(final NetworkPacket data) {
        super(data.toByteArray());
    }

    /**
     * This constructor initialize a response packet. The type of the packet is
     * set to SDN_WISE_RESPONSE.
     *
     * @param net Network ID of the packet
     * @param src source address of the packet
     * @param dst destination address of the packet
     * @param entry the FlowTableEntry sent from the Control Plane
     */
    public ResponsePacket(final int net, final NodeAddress src,
            final NodeAddress dst,
            final FlowTableEntry entry) {
        super(net, src, dst);
        setTyp(RESPONSE);
        setRule(entry);
    }

    /**
     * This constructor initialize a response packet starting from a int array.
     *
     * @param data the int array representing the response packet, all int are
     * casted to byte.
     */
    public ResponsePacket(final int[] data) {
        super(data);
    }

    /**
     * Setter for the rule in the response packet. sadsadas
     *
     * @param rule the FlowTableEntry item used in the NetworkPacket.
     * @return the packet itself
     */
    public final ResponsePacket setRule(final FlowTableEntry rule) {
        byte[] tmp = rule.toByteArray();
        // the last byte is for stats so it is useless to send it in a response
        setPayload(Arrays.copyOf(tmp, tmp.length - 1));
        return this;
    }

    /**
     * Getter for the rule in the response packet.
     *
     * @return the rule as a FlowTableEntry
     */
    public final FlowTableEntry getRule() {
        FlowTableEntry rule = new FlowTableEntry(getPayload());
        return rule;
    }
}
