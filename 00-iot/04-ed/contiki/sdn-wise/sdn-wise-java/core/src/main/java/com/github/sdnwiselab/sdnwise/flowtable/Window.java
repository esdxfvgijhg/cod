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
package com.github.sdnwiselab.sdnwise.flowtable;

import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import com.github.sdnwiselab.sdnwise.util.Utils;
import static com.github.sdnwiselab.sdnwise.util.Utils.getBitRange;
import static com.github.sdnwiselab.sdnwise.util.Utils.setBitRange;
import java.util.Arrays;

/**
 * Window is part of the structure of the Entry of a FlowTable. This Class
 * implements FlowTableInterface.
 *
 * @author Sebastiano Milardo
 */
public final class Window implements FlowTableInterface {

    /**
     * Window Operators.
     */
    public static final byte EQUAL = 0,
            GREATER = 2,
            GREATER_OR_EQUAL = 4,
            LESS = 3,
            LESS_OR_EQUAL = 5,
            NOT_EQUAL = 1;

    /**
     * The size of the window as an array of bytes.
     */
    public static final byte SIZE = 5;

    /**
     * Window Sizes.
     */
    public static final byte W_SIZE_1 = 0, W_SIZE_2 = 1;

    /**
     * Operators and operands lenghts and indexes.
     */
    private static final byte LEFT_BIT = 3, LEFT_INDEX_H = 1, LEFT_INDEX_L = 2,
            LEFT_LEN = 2, OP_BIT = 5, OP_INDEX = 0, OP_LEN = 3,
            RIGHT_BIT = 1, RIGHT_INDEX_H = 3, RIGHT_INDEX_L = 4,
            RIGHT_LEN = LEFT_LEN,
            SIZE_BIT = 0,
            SIZE_LEN = 1, WIN_LEN = 3;

    /**
     * Stores the window as a byte array.
     */
    private final byte[] window = new byte[SIZE];

    /**
     * Creates a Window given a String. The String must contain: the two values
     * to compare divided by an operator. Possible values are: Possible values
     * are: "P." for packet and "R." for status registern then a number
     * indicating the index where to retrieve the operand. Therefore a possbile
     * result location is "P.10" if you want to compare the 10th byte of the
     * packet. Then operator and the second operand. A complete example is "P.10
     * != R.11". A list of accepted operators can be found in the
     * getOperatorFromString method.
     *
     * @param val the String representing the action
     * @return the window object
     */
    public static Window fromString(final String val) {
        Window w = new Window();
        String[] operands = val.split(" ");
        if (operands.length == WIN_LEN) {
            String lhs = operands[0];
            int[] tmpLhs = Window.getOperandFromString(lhs);
            w.setLhsLocation(tmpLhs[0]);
            w.setLhs(tmpLhs[1]);
            w.setOperator(w.getOperatorFromString(operands[1]));

            String rhs = operands[2];
            int[] tmpRhs = Window.getOperandFromString(rhs);
            w.setRhsLocation(tmpRhs[0]);
            w.setRhs(tmpRhs[1]);

            if ("P.SRC".equals(lhs)
                    || "P.DST".equals(lhs)
                    || "P.NXH".equals(lhs)
                    || "P.SRC".equals(rhs)
                    || "P.DST".equals(rhs)
                    || "P.NXH".equals(rhs)) {
                w.setSize(W_SIZE_2);
            }
        }
        return w;
    }

    /**
     * Simple constructor for the FlowTableWindow object.
     *
     * Set window[] values at zero.
     */
    public Window() {
        Arrays.fill(window, (byte) 0);
    }

    /**
     * Constructor for the FlowTableWindow object.
     *
     * @param value byte array contains value to copy in actions[]
     */
    public Window(final byte[] value) {
        if (value.length == SIZE) {
            System.arraycopy(value, 0, window, 0, value.length);
        } else {
            Arrays.fill(window, (byte) 0);
        }
    }

    @Override
    public boolean equals(final Object obj) {
        if (this == obj) {
            return true;
        }
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        Window other = (Window) obj;
        return Arrays.equals(other.window, window);
    }

    /**
     * Getter method to obtain Pos.
     *
     * @return an int value of pos.
     */
    public int getLhs() {
        return Utils.mergeBytes(window[LEFT_INDEX_H], window[LEFT_INDEX_L]);
    }

    /**
     * Getter method to obtain lhs Location.
     *
     * @return an int value of location.
     */
    public int getLhsLocation() {
        return getBitRange(window[OP_INDEX], LEFT_BIT, LEFT_LEN);
    }

    /**
     * Getter method to obtain memory in string.
     *
     * @return a string value of memory.
     */
    public String getLhsToString() {
        switch (getLhsLocation()) {
            case CONST:
                return String.valueOf(getLhs());
            case PACKET:
                return "P." + NetworkPacket.getNetworkPacketByteName(getLhs());
            case STATUS:
                return "R." + getLhs();
            default:
                return "";
        }
    }

    /**
     * Gets an operand given a string. See the fromString method for more
     * details.
     *
     * @param val a String representing the operator
     * @return an array representing the operator
     */
    public static int[] getOperandFromString(final String val) {
        int[] tmp = new int[2];
        String[] strVal = val.split("\\.");
        switch (strVal[0]) {
            case "P":
                tmp[0] = PACKET;
                break;
            case "R":
                tmp[0] = STATUS;
                break;
            default:
                tmp[0] = CONST;
                break;
        }

        switch (tmp[0]) {
            case PACKET:
                tmp[1] = NetworkPacket.getNetworkPacketByteFromName(strVal[1]);
                break;
            case CONST:
                tmp[1] = Integer.parseInt(strVal[0]);
                break;
            default:
                tmp[1] = Integer.parseInt(strVal[1]);
                break;
        }
        return tmp;
    }

    /**
     * Getter method to obtain Operator.
     *
     * @return an int value of operator.
     */
    public int getOperator() {
        return getBitRange(window[OP_INDEX], OP_BIT, OP_LEN);
    }

    /**
     * Gets the operator given a String. See the fromString method for more
     * details.
     *
     * @param val a String representing the operand
     * @return an array representing the operand
     */
    private int getOperatorFromString(final String val) {
        switch (val) {
            case ("=="):
                return EQUAL;
            case ("!="):
                return NOT_EQUAL;
            case (">"):
                return GREATER;
            case ("<"):
                return LESS;
            case (">="):
                return GREATER_OR_EQUAL;
            case ("<="):
                return LESS_OR_EQUAL;
            default:
                throw new IllegalArgumentException();
        }
    }

    /**
     * Getter method to obtain Operator in String.
     *
     * @return a string of operator.
     */
    public String getOperatorToString() {
        switch (getOperator()) {
            case (EQUAL):
                return " == ";
            case (NOT_EQUAL):
                return " != ";
            case (GREATER):
                return " > ";
            case (LESS):
                return " < ";
            case (GREATER_OR_EQUAL):
                return " >= ";
            case (LESS_OR_EQUAL):
                return " <= ";
            default:
                return "";
        }
    }

    /**
     * Getter method to obtain High Value.
     *
     * @return an int value of high value.
     */
    public int getRhs() {
        return Utils.mergeBytes(window[RIGHT_INDEX_H], window[RIGHT_INDEX_L]);
    }

    /**
     * Getter method to obtain rhs Location.
     *
     * @return an int value of location.
     */
    public int getRhsLocation() {
        return getBitRange(window[OP_INDEX], RIGHT_BIT, RIGHT_LEN);
    }

    /**
     * Getter method to obtain memory in string.
     *
     * @return a string value of memory.
     */
    public String getRhsToString() {
        switch (getRhsLocation()) {
            case CONST:
                return String.valueOf(getRhs());
            case PACKET:
                return "P." + NetworkPacket.getNetworkPacketByteName(getRhs());
            case STATUS:
                return "R." + getRhs();
            default:
                return "";
        }
    }

    /**
     * Getter method to obtain Size.
     *
     * @return an int value of size.
     */
    public int getSize() {
        return getBitRange(window[OP_INDEX], SIZE_BIT, SIZE_LEN);
    }

    /**
     * Getter method to obtain Size in string.
     *
     * @return a string in size.
     */
    public String getSizeToString() {
        return String.valueOf(getSize() + 1);
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(window);
    }

    /**
     * Setter method to set offsetIndex of window[].
     *
     * @param val value to set
     * @return this Window
     */
    public Window setLhs(final int val) {
        window[LEFT_INDEX_H] = (byte) (val >>> Byte.SIZE);
        window[LEFT_INDEX_L] = (byte) val;
        return this;
    }

    /**
     * Setter method to set OP_INDEX of window[].
     *
     * @param value value to set
     * @return this Window
     */
    public Window setLhsLocation(final int value) {
        window[OP_INDEX] = (byte) setBitRange(
                window[OP_INDEX], LEFT_BIT, LEFT_LEN, value);
        return this;
    }

    /**
     * Setter method to set OP_INDEX of window[].
     *
     * @param value value to set
     * @return this Window
     */
    public Window setOperator(final int value) {
        window[OP_INDEX] = (byte) setBitRange(
                window[OP_INDEX], OP_BIT, OP_LEN, value);
        return this;
    }

    /**
     * Setter method to set highValueIndex of window[].
     *
     * @param val value to set
     * @return this Window
     */
    public Window setRhs(final int val) {
        window[RIGHT_INDEX_H] = (byte) (val >>> Byte.SIZE);
        window[RIGHT_INDEX_L] = (byte) val;
        return this;
    }

    /**
     * Setter method to set OP_INDEX of window[].
     *
     * @param value value to set
     * @return this Window
     */
    public Window setRhsLocation(final int value) {
        window[OP_INDEX] = (byte) setBitRange(
                window[OP_INDEX], RIGHT_BIT, RIGHT_LEN, value);
        return this;
    }

    /**
     * Setter method to set OP_INDEX of window[].
     *
     * @param value value to set
     * @return this Window
     */
    public Window setSize(final int value) {
        window[OP_INDEX] = (byte) setBitRange(
                window[OP_INDEX], SIZE_BIT, SIZE_LEN, value);
        return this;
    }

    @Override
    public byte[] toByteArray() {
        return Arrays.copyOf(window, SIZE);
    }

    @Override
    public String toString() {
        return getLhsToString() + getOperatorToString() + getRhsToString();
    }

}
