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
 * Test class for the Util class.
 *
 * @author Sebastiano Milardo
 */
public final class UtilsTest {

    /**
     * Test of toHex method, of class Utils.
     */
    @Test
    public void testToHex() {
        byte[] data = new byte[]{0, 1, -1};
        String expResult = "0001ff";
        String result = Utils.toHex(data);
        assertEquals(expResult, result);
    }

    /**
     * Test of mergeBytes method, of class Utils.
     */
    @Test
    public void testMergeBytes() {
        int high = Byte.MAX_VALUE * 2 + 1;
        int low = Byte.MAX_VALUE * 2 + 1;
        int expResult = Short.MAX_VALUE * 2 + 1;
        int result = Utils.mergeBytes(high, low);
        assertEquals(expResult, result);
    }

    /**
     * Test of splitInteger method, of class Utils.
     */
    @Test
    public void testSplitInteger() {
        int value = Short.MAX_VALUE * 2 + 1;
        byte[] expResult = new byte[]{-1, -1};
        byte[] result = Utils.splitInteger(value);
        assertArrayEquals(expResult, result);
    }

    /**
     * Test of getBitRange method, of class Utils.
     */
    @Test
    public void testGetBitRange() {
        int b = 1;
        int s = 0;
        int n = 1;
        int expResult = 1;
        int result = Utils.getBitRange(b, s, n);
        assertEquals(expResult, result);
    }

    /**
     * Test of setBitRange method, of class Utils.
     */
    @Test
    public void testSetBitRange() {
        int val = 1;
        int start = 0;
        int len = 1;
        int newVal = 1;
        int expResult = 1;
        int result = Utils.setBitRange(val, start, len, newVal);
        assertEquals(expResult, result);
    }

    /**
     * Test of concatByteArray method, of class Utils.
     */
    @Test
    public void testConcatByteArray() {
        byte[] a = new byte[]{1, 1};
        byte[] b = new byte[]{-1, -1};
        byte[] expResult = new byte[]{1, 1, -1, -1};
        byte[] result = Utils.concatByteArray(a, b);
        assertArrayEquals(expResult, result);
    }
}
