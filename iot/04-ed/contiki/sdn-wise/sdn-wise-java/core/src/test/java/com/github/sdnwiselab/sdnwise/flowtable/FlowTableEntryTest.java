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
package com.github.sdnwiselab.sdnwise.flowtable;

import static com.github.sdnwiselab.sdnwise.flowtable.Window.EQUAL;
import static com.github.sdnwiselab.sdnwise.flowtable.Window.GREATER;
import static com.github.sdnwiselab.sdnwise.flowtable.Window.LESS;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import static org.junit.Assert.assertArrayEquals;
import static org.junit.Assert.assertEquals;
import org.junit.Test;
import static com.github.sdnwiselab.sdnwise.flowtable.SetAction.ADD;
import static com.github.sdnwiselab.sdnwise.flowtable.FlowTableInterface.CONST;
import static com.github.sdnwiselab.sdnwise.flowtable.FlowTableInterface.PACKET;
import static com.github.sdnwiselab.sdnwise.flowtable.FlowTableInterface.STATUS;

/**
 * Tests for the FlowTableEntry class.
 *
 * @author Sebastiano Milardo
 */
public final class FlowTableEntryTest {

    /**
     * Test of fromString method, of class FlowTableEntry.
     */
    @Test
    public void testFromString() {
        String s = "IF (P.TYP == 10 && "
                + "P.50 == 1 && "
                + "R.10 > 1 && "
                + "R.12 < 5) {"
                + " ASK;"
                + " SET P.10 = 40 + 1;"
                + " FUNCTION 1 9 8 7 6 5 4 3 2 1 ;"
                + " DROP;"
                + " FORWARD_B;"
                + " FORWARD_U 3;"
                + " MATCH;"
                + " SET P.11 = P.12 + P.13; "
                + "}";
        FlowTableEntry expResult = new FlowTableEntry();
        expResult.addWindow(new Window()
                .setLhsLocation(PACKET)
                .setLhs(6)
                .setOperator(EQUAL)
                .setRhsLocation(CONST)
                .setRhs(10));

        expResult.addWindow(new Window()
                .setLhsLocation(PACKET)
                .setLhs(50)
                .setOperator(EQUAL)
                .setRhsLocation(CONST)
                .setRhs(1));

        expResult.addWindow(new Window()
                .setLhsLocation(STATUS)
                .setLhs(10)
                .setOperator(GREATER)
                .setRhsLocation(CONST)
                .setRhs(1));

        expResult.addWindow(new Window()
                .setLhsLocation(STATUS)
                .setLhs(12)
                .setOperator(LESS)
                .setRhsLocation(CONST)
                .setRhs(5));

        expResult.addAction(new AskAction());
        expResult.addAction(new SetAction()
                .setLhsLocation(CONST)
                .setLhs(40)
                .setOperator(ADD)
                .setRhsLocation(CONST)
                .setRhs(1)
                .setResLocation(PACKET)
                .setRes(10));

        expResult.addAction(new FunctionAction(
                new byte[]{5, 1, 9, 8, 7, 6, 5, 4, 3, 2, 1,}));

        expResult.addAction(new DropAction());

        expResult.addAction(new ForwardBroadcastAction());

        expResult.addAction(new ForwardUnicastAction(new NodeAddress(3)));

        expResult.addAction(new MatchAction());

        expResult.addAction(new SetAction()
                .setLhsLocation(PACKET)
                .setLhs(12)
                .setOperator(ADD)
                .setRhsLocation(PACKET)
                .setRhs(13)
                .setResLocation(PACKET)
                .setRes(11));

        expResult.setStats(new Stats());

        FlowTableEntry result = FlowTableEntry.fromString(s);
        assertEquals(expResult, result);
    }

    /**
     * Test of toString method, of class FlowTableEntry.
     */
    @Test
    public void testToString() {
        FlowTableEntry instance = new FlowTableEntry();
        instance.addWindow(new Window()
                .setLhsLocation(PACKET)
                .setLhs(6)
                .setOperator(EQUAL)
                .setRhsLocation(CONST)
                .setRhs(10));

        instance.addWindow(new Window()
                .setLhsLocation(PACKET)
                .setLhs(50)
                .setOperator(EQUAL)
                .setRhsLocation(CONST)
                .setRhs(1));

        instance.addWindow(new Window()
                .setLhsLocation(STATUS)
                .setLhs(10)
                .setOperator(GREATER)
                .setRhsLocation(CONST)
                .setRhs(1));

        instance.addWindow(new Window()
                .setLhsLocation(STATUS)
                .setLhs(12)
                .setOperator(LESS)
                .setRhsLocation(CONST)
                .setRhs(5));

        instance.addAction(new AskAction());
        instance.addAction(new SetAction()
                .setLhsLocation(CONST)
                .setLhs(40)
                .setOperator(ADD)
                .setRhsLocation(CONST)
                .setRhs(1)
                .setResLocation(PACKET)
                .setRes(10));

        instance.addAction(new FunctionAction(
                new byte[]{5, 1, 9, 8, 7, 6, 5, 4, 3, 2, 1,}));

        instance.addAction(new DropAction());

        instance.addAction(new ForwardBroadcastAction());

        instance.addAction(new ForwardUnicastAction(new NodeAddress(3)));

        instance.addAction(new MatchAction());

        instance.addAction(new SetAction()
                .setLhsLocation(PACKET)
                .setLhs(12)
                .setOperator(ADD)
                .setRhsLocation(PACKET)
                .setRhs(13)
                .setResLocation(PACKET)
                .setRes(11));

        String expResult = "IF (P.TYP == 10 && "
                + "P.50 == 1 && "
                + "R.10 > 1 && "
                + "R.12 < 5) {"
                + " ASK;"
                + " SET P.10 = 40 + 1;"
                + " FUNCTION 1 9 8 7 6 5 4 3 2 1 ;"
                + " DROP;"
                + " FORWARD_B;"
                + " FORWARD_U 3;"
                + " MATCH;"
                + " SET P.11 = P.12 + P.13; "
                + "} (TTL: 254, U: 0)";
        String result = instance.toString();
        assertEquals(expResult, result);
    }

    /**
     * Test of toByteArray method, of class FlowTableEntry.
     */
    @Test
    public void testToByteArray() {
        String s = "IF (P.TYP == 10 && "
                + "P.50 == 1 && "
                + "R.10 > 1 && "
                + "R.12 < 5) {"
                + " ASK;"
                + " SET P.10 = 40 + 1;"
                + " FUNCTION 1 9 8 7 6 5 4 3 2 1 ;"
                + " DROP;"
                + " FORWARD_B;"
                + " FORWARD_U 3;"
                + " MATCH;"
                + " SET P.11 = P.12 + P.13; "
                + "} (TTL: 254, U: 0)";
        FlowTableEntry instance = FlowTableEntry.fromString(s);

        byte[] expResult = new byte[]{20, 18, 0, 6, 0, 10, 18, 0, 50, 0, 1, 90,
            0, 10, 0, 1, 122, 0, 12, 0, 5, 1, 4, 8, 6, 66, 0, 10, 0, 40, 0, 1,
            11, 5, 1, 9, 8, 7, 6, 5, 4, 3, 2, 1, 1, 3, 3, 2, -1, -1, 3, 1, 0, 3,
            1, 7, 8, 6, -124, 0, 11, 0, 12, 0, 13, -2, 0};
        byte[] result = instance.toByteArray();
        assertArrayEquals(expResult, result);
    }

}
