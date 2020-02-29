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

import java.nio.ByteBuffer;

/**
 * An utility class.
 *
 * @author Sebastiano Milardo
 */
public final class Utils {

    /**
     * Constant used for coverting a byte to hex.
     */
    private static final String DIGITS = "0123456789abcdef";
    /**
     * Constant used for Masks.
     */
    private static final int MASK = 0xFF, MASK_1 = 4, MASK_2 = 0xf;

    /**
     * Concatenates two byte arrays.
     *
     * @param a first byte array
     * @param b second byte array
     * @return the array resulting from the concatenation
     */
    public static byte[] concatByteArray(final byte[] a, final byte[] b) {
        return ByteBuffer.allocate(a.length + b.length).put(a).put(b).array();
    }

    /**
     * Gets a set of bits from a byte.
     *
     * @param b the original byte
     * @param s the bit of the byte from where we start extracting
     * @param n the number of bits to extract
     * @return an int made of the extracted bits
     */
    public static int getBitRange(final int b, final int s, final int n) {
        return (((b & MASK) >> (s & MASK))
                & ((1 << (n & MASK)) - 1)) & MASK;
    }

    /**
     * Merges two bytes into an int.
     *
     * @param high high byte
     * @param low low byte
     * @return merge of the two bytes
     */
    public static int mergeBytes(final int high, final int low) {
        int h = Byte.toUnsignedInt((byte) high);
        int l = Byte.toUnsignedInt((byte) low);
        return (h << Byte.SIZE) | l;
    }

    /**
     * Sets a set of bits in a int.
     *
     * @param val the original int
     * @param start the bit of the int from where we start setting
     * @param len the number of bits to set
     * @param newVal the new value to set
     * @return the original int with the bit replaced
     */
    public static int setBitRange(final int val,
            final int start, final int len, final int newVal) {
        int mask = ((1 << len) - 1) << start;
        return (val & ~mask) | ((newVal << start) & mask);
    }

    /**
     * Splits an integer into a byte array. The maximum size of the returned
     * array is two.
     *
     * @param value the value to split
     * @return a bite array
     */
    public static byte[] splitInteger(final int value) {
        ByteBuffer b = ByteBuffer.allocate(2);
        b.putShort((short) value);
        return b.array();
    }

    /**
     * Return the passed in byte array as a hex string.
     *
     * @param data the bytes to be converted.
     * @return a hex representation of data.
     */
    public static String toHex(final byte[] data) {
        StringBuilder buf = new StringBuilder();

        for (int i = 0; i < data.length; i++) {
            int v = Byte.toUnsignedInt(data[i]);
            buf.append(DIGITS.charAt(v >> MASK_1));
            buf.append(DIGITS.charAt(v & MASK_2));
        }

        return buf.toString();
    }

    /**
     * Utility class has no public constructor.
     */
    private Utils() {
    }
}
