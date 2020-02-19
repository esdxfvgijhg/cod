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

import com.github.sdnwiselab.sdnwise.flowtable.Window;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.util.Arrays;
import java.util.LinkedList;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Tests for the OpenPathPacket class.
 *
 * @author Sebastiano Milardo
 */
public final class OpenPathPacketTest {

    /**
     * Test of toByteArray method, of class OpenPathPacket.
     */
    @Test
    public void testToByteArray() {
        LinkedList<NodeAddress> path = new LinkedList<>();
        path.add(new NodeAddress("0.1"));
        path.add(new NodeAddress("0.2"));
        path.add(new NodeAddress("0.3"));
        path.add(new NodeAddress("0.4"));
        OpenPathPacket instance = new OpenPathPacket(1, new NodeAddress("0.2"),
                new NodeAddress("0.0"), path);
        LinkedList<Window> wl = new LinkedList<>();
        wl.add(Window.fromString("P.TYP == 10"));
        instance.setWindows(wl);
        String expResult = "[1, 24, 0, 0, 0, 2, 5, 100, 0, 0, 1, 18, 0, 6, 0, "
                + "10, 0, 1, 0, 2, 0, 3, 0, 4]";
        String result = Arrays.toString(instance.toByteArray());
        assertEquals(expResult, result);
    }
}
