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
import java.nio.charset.Charset;
import java.util.Arrays;
import static org.junit.Assert.assertEquals;
import org.junit.Test;

/**
 * Tests for the RequestPacketTest class.
 *
 * @author Sebastiano Milardo
 */
public final class RequestPacketTest {

    /**
     * Default charset.
     */
    protected static final Charset UTF8_CHARSET = Charset.forName("UTF-8");

    /**
     * Test of toByteArray method, of class RequestPacket.
     */
    @Test
    public void testToByteArray() {

        DataPacket dp = new DataPacket(1, new NodeAddress("0.2"),
                new NodeAddress("0.0"),
                ("SDN-WISE: The stateful Software Defined Networking solution"
                + " for the Internet of Things - Test.").getBytes(UTF8_CHARSET)
        );
        RequestPacket[] instance = RequestPacket.createPackets(1,
                new NodeAddress("0.1"), new NodeAddress("0.1"), (byte) 1,
                dp.toByteArray());
        String expResult = "[1, 116, 0, 1, 0, 1, 3, 100, 0, 0, 1, 0, 2, 1, 104,"
                + " 0, 0, 0, 2, 0, 100, 0, 0, 83, 68, 78, 45, 87, 73, 83, 69,"
                + " 58, 32, 84, 104, 101, 32, 115, 116, 97, 116, 101, 102, 117,"
                + " 108, 32, 83, 111, 102, 116, 119, 97, 114, 101, 32, 68, 101,"
                + " 102, 105, 110, 101, 100, 32, 78, 101, 116, 119, 111, 114,"
                + " 107, 105, 110, 103, 32, 115, 111, 108, 117, 116, 105, 111,"
                + " 110, 32, 102, 111, 114, 32, 116, 104, 101, 32, 73, 110,"
                + " 116, 101, 114, 110, 101, 116, 32, 111, 102, 32, 84, 104,"
                + " 105, 110, 103, 115, 32, 45, 32, 84, 101, 115, 116][1, 14,"
                + " 0, 1, 0, 1, 3, 100, 0, 0, 1, 1, 2, 46]";
        StringBuilder sb = new StringBuilder();
        for (RequestPacket rp : instance) {
            sb.append(Arrays.toString(rp.toByteArray()));
        }
        assertEquals(expResult, sb.toString());
    }
}
