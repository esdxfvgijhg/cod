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
package com.github.sdnwiselab.sdnwise.packet;

import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.net.InetSocketAddress;
import java.util.Arrays;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Tests for the RegProxyPacket class.
 *
 * @author Sebastiano Milardo
 */
public final class RegProxyPacketTest {

    /**
     * Default port address.
     */
    private static final int PORT = 7000;

    /**
     * Test of toByteArray method, of class RegProxyPacket.
     */
    @Test
    public void testToByteArray() {
        InetSocketAddress inetAddr = new InetSocketAddress("localhost", PORT);
        RegProxyPacket instance = new RegProxyPacket((byte) 1, new NodeAddress(
                "0.2"), "dPid", "00:01:02:03:04:05", 1, inetAddr);
        String expResult = "[1, 38, 0, 2, 0, 2, 7, 100, 0, 2, 100, 80, 105, 100"
                + ", 0, 0, 0, 0, 0, 1, 2, 3, 4, 5, 0, 0, 0, 0, 0, 0, 0, 1, 127,"
                + " 0, 0, 1, 27, 88]";
        String result = Arrays.toString(instance.toByteArray());
        assertEquals(expResult, result);
    }
}
