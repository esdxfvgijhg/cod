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
import java.util.Arrays;
import java.util.HashMap;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Tests for the BeaconPacket class.
 *
 * @author Sebastiano Milardo
 */
public final class ReportPacketTest {

    /**
     * Test of toByteArray method, of class ReportPacket.
     */
    @Test
    public void testToByteArray() {
        ReportPacket instance = new ReportPacket(1, new NodeAddress("0.2"),
                new NodeAddress("0.0"), 2, 1);
        HashMap<NodeAddress, Byte> map = new HashMap<>();
        map.put(new NodeAddress("0.3"), (byte) 1);
        map.put(new NodeAddress("0.4"), (byte) 2);
        instance.setNeighbors(map);
        String expResult = "[1, 19, 0, 0, 0, 2, 2, 100, 0, 0, 2, 1, 2, 0,"
                + " 3, 1, 0, 4, 2]";
        String result = Arrays.toString(instance.toByteArray());
        assertEquals(expResult, result);
    }
}
