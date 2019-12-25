/*
 * Copyright (C) 2016 Seby
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

import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Test class for the NodeAddress class.
 *
 * @author Sebastiano Milardo
 */
public final class NodeAddressTest {

    /**
     * Test of intValue method, of class NodeAddress.
     */
    @Test
    public void testIntValue() {
        NodeAddress instance = new NodeAddress("255.255");
        int expResult = Short.MAX_VALUE * 2 + 1;
        int result = instance.intValue();
        assertEquals(expResult, result);
    }

    /**
     * Test of getHigh method, of class NodeAddress.
     */
    @Test
    public void testGetHigh() {
        NodeAddress instance = new NodeAddress("1.0");
        byte expResult = 1;
        byte result = instance.getHigh();
        assertEquals(expResult, result);
    }

    /**
     * Test of getLow method, of class NodeAddress.
     */
    @Test
    public void testGetLow() {
        NodeAddress instance = new NodeAddress("0.1");
        byte expResult = 1;
        byte result = instance.getLow();
        assertEquals(expResult, result);
    }

    /**
     * Test of getArray method, of class NodeAddress.
     */
    @Test
    public void testGetArray() {
        NodeAddress instance = new NodeAddress("1.1");
        byte[] expResult = new byte[]{(byte) 1, (byte) 1};
        byte[] result = instance.getArray();
        assertArrayEquals(expResult, result);
    }

    /**
     * Test of toByteArray method, of class NodeAddress.
     */
    @Test
    public void testToByteArray() {
        NodeAddress instance = new NodeAddress("1.1");
        Byte[] expResult = new Byte[]{(byte) 1, (byte) 1};
        Byte[] result = instance.toByteArray();
        assertArrayEquals(expResult, result);
    }

    /**
     * Test of toString method, of class NodeAddress.
     */
    @Test
    public void testToString() {
        NodeAddress instance = new NodeAddress("255.255");
        String expResult = "255.255";
        String result = instance.toString();
        assertEquals(expResult, result);
    }

    /**
     * Test of compareTo method, of class NodeAddress.
     */
    @Test
    public void testCompareTo() {
        NodeAddress other = new NodeAddress("1.1");
        NodeAddress instance = new NodeAddress("1.1");
        int expResult = 0;
        int result = instance.compareTo(other);
        assertEquals(expResult, result);
    }

    /**
     * Test of isBroadcast method, of class NodeAddress.
     */
    @Test
    public void testIsBroadcast() {
        NodeAddress instance = new NodeAddress("255.255");
        boolean expResult = true;
        boolean result = instance.isBroadcast();
        assertEquals(expResult, result);
    }
}
