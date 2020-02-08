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
package com.github.sdnwiselab.sdnwise.util;

import static com.github.sdnwiselab.sdnwise.util.Utils.mergeBytes;
import java.io.Serializable;

/**
 * This Class is used to represent NodeAddress Object. The NodeAddress is the
 * address used by all the nodes in a SDN-WISE Network. The NodeAddress is two
 * byte long. There is a reserved address for broadcast communication which is
 * 255.255.
 *
 * @author Sebastiano Milardo
 */
public final class NodeAddress implements Comparable<NodeAddress>, Serializable {

    /**
     * The default broadcast address.
     */
    public static final NodeAddress BROADCAST_ADDR = new NodeAddress("255.255");

    /**
     * The serialVersionUID as specified in the Serializable interface.
     */
    private static final long serialVersionUID = 1L;

    /**
     * A byte array containing the address. A NodeAddress is two bytes long.
     */
    private final byte[] addr = new byte[2];

    /**
     * Constructor method to create a Node Address from an int.
     *
     * @param a int value to set a Node Address.
     */
    public NodeAddress(final int a) {
        addr[0] = (byte) (a >>> Byte.SIZE);
        addr[1] = (byte) a;
    }

    /**
     *
     * Constructor method to create a Node Address from a byte array.
     *
     * @param a byte array value to set a Node Address.
     */
    public NodeAddress(final byte[] a) {
        if (a.length == 2) {
            addr[0] = a[0];
            addr[1] = a[1];
        }
    }

    /**
     * Constructor method to create a Node Address from a string.
     *
     * @param a string value to set a Node Address.
     */
    public NodeAddress(final String a) {
        String[] add = a.split("\\s*\\.\\s*");
        if (add.length == 2) {
            addr[0] = (byte) Integer.parseInt(add[0]);
            addr[1] = (byte) Integer.parseInt(add[1]);
        } else {
            int adr = Integer.parseInt(a);
            addr[0] = (byte) (adr >>> Byte.SIZE);
            addr[1] = (byte) adr;
        }
    }

    /**
     * Constructor method to create a Node Address from two int.
     *
     * @param addr0 int value to set fist part of Node Address.
     * @param addr1 int value to set second part of a Node Address.
     */
    public NodeAddress(final int addr0, final int addr1) {
        addr[0] = (byte) addr0;
        addr[1] = (byte) addr1;
    }

    @Override
    public int compareTo(final NodeAddress other) {
        return Integer.valueOf(intValue()).compareTo(other.intValue());
    }

    @Override
    public boolean equals(final Object obj) {
        return obj instanceof NodeAddress
                && ((NodeAddress) obj).intValue() == intValue();
    }

    /**
     * Gets the Node Address in Byte.
     *
     * @return a byte array of Node Address.
     */
    public byte[] getArray() {
        return new byte[]{addr[0], addr[1]};
    }

    /**
     * Gets the first Byte of a NodeAddress.
     *
     * @return a byte value of High Part of a NodeAddress.
     */
    public byte getHigh() {
        return addr[0];
    }

    /**
     * Gets the last Byte of a NodeAddress.
     *
     * @return a byte value of Low Part of a NodeAddress.
     */
    public byte getLow() {
        return addr[1];
    }

    @Override
    public int hashCode() {
        return Integer.valueOf(intValue()).hashCode();
    }

    /**
     * Returns the NodeAddress as an integer.
     *
     * @return int value of the NodeAddress.
     */
    public int intValue() {
        return mergeBytes(addr[0], addr[1]);
    }

    /**
     * Checks if the address is a broadcast address.
     *
     * @return true if equal to 255.255 false otherwise
     */
    public boolean isBroadcast() {
        return equals(BROADCAST_ADDR);
    }

    /**
     * Gets the Node Address in Byte.
     *
     * @return a byte array of Node Address.
     */
    public Byte[] toByteArray() {
        return new Byte[]{addr[0], addr[1]};
    }

    @Override
    public String toString() {
        return Byte.toUnsignedInt(addr[0]) + "." + Byte.toUnsignedInt(addr[1]);
    }
}
