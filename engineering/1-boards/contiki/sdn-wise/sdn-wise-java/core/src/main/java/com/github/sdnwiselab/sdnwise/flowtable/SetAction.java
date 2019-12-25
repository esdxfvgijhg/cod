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

import static com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.Action.SET;
import static com.github.sdnwiselab.sdnwise.flowtable.Window.getOperandFromString;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import static com.github.sdnwiselab.sdnwise.util.Utils.getBitRange;
import static com.github.sdnwiselab.sdnwise.util.Utils.mergeBytes;
import static com.github.sdnwiselab.sdnwise.util.Utils.setBitRange;

/**
 * Window is part of the structure of the Entry of a FlowTable. This Class
 * implements FlowTableInterface.
 *
 * @author Sebastiano Milardo
 */
public final class SetAction extends AbstractAction {

    /**
     * SetAction operators.
     */
    public static final byte ADD = 0,
            AND = 5,
            DIV = 3,
            MOD = 4,
            MUL = 2,
            OR = 6,
            SUB = 1,
            XOR = 7;

    /**
     * Field indexes and lengths.
     */
    private static final byte LEFT_BIT = 1,
            LEFT_INDEX_H = 3,
            LEFT_INDEX_L = 4,
            LEFT_LEN = 2,
            OP_BIT = 3,
            OP_INDEX = 0, OP_LEN = 3,
            RES_BIT = 0,
            RES_INDEX_H = 1,
            RES_INDEX_L = 2,
            RES_LEN = 1,
            RIGHT_BIT = 6,
            RIGHT_INDEX_H = 5,
            RIGHT_INDEX_L = 6,
            RIGHT_LEN = LEFT_LEN;

    /**
     * Constans for String parsing.
     */
    private static final int FULL_SET = 6,
            HALF_SET = 4,
            RES = 1,
            LHS = 3,
            RHS = 5,
            OP = 4;

    /**
     * The size of the action.
     */
    private static final byte SIZE = 7;

    /**
     * Simple constructor for the Window object.
     *
     * Set action[] values at zero.
     */
    public SetAction() {
        super(SET, SIZE);
    }

    /**
     * Creates a SetAction given array of bytes.
     *
     * @param value the array of bytes representing the action
     */
    public SetAction(final byte[] value) {
        super(value);
    }

    /**
     * Creates a SetAction given a String. The String must contain: the name of
     * the Action, a result containing where the result should be stored.
     * Possible values are: "P." for packet and "R." for status register. A
     * number indicating the index where to store the result. Therefore a
     * possbile result location is "P.10" if you want to store the result at the
     * 10th byte of the packet. Then an equal sign and two operands separated by
     * the operator choosen. If an operand is a constant simply write it. A
     * complete example is "SET P.10 = R.11 + 12". This example stores the
     * result of the sum between the status register at byte 11, and the
     * constant value 12 in the 10th byte of the packet. Another possible value
     * is to set a result without making an operation. So an accepted string can
     * also be "SET R.10 = 11"
     *
     * @param val the String representing the action
     */
    public SetAction(final String val) {
        super(SET, SIZE);
        String[] operands = val.split(" ");
        if (operands.length == FULL_SET) {
            String res = operands[RES];
            String lhs = operands[LHS];
            String rhs = operands[RHS];

            int[] tmpRes = getResFromString(res);
            int[] tmpLhs = getOperandFromString(lhs);
            int[] tmpRhs = getOperandFromString(rhs);

            setResLocation(tmpRes[0]);
            setRes(tmpRes[1]);

            setLhsLocation(tmpLhs[0]);
            setLhs(tmpLhs[1]);

            setOperator(getOperatorFromString(operands[OP]));

            setRhsLocation(tmpRhs[0]);
            setRhs(tmpRhs[1]);

        } else if (operands.length == HALF_SET) {

            String res = operands[RES];
            String lhs = operands[LHS];

            int[] tmpRes = getResFromString(res);
            int[] tmpLhs = getOperandFromString(lhs);

            setResLocation(tmpRes[0]);
            setRes(tmpRes[1]);

            setLhsLocation(tmpLhs[0]);
            setLhs(tmpLhs[1]);

            setRhsLocation(NULL);
            setRhs(0);
        }

    }

    /**
     * Getter method to obtain Pos.
     *
     * @return an int value of pos.
     */
    public int getLhs() {
        return mergeBytes(getValue(LEFT_INDEX_H), getValue(LEFT_INDEX_L));
    }

    /**
     * Getter method to obtain lhs Location.
     *
     * @return an int value of location.
     */
    public int getLhsLocation() {
        return getBitRange(getValue(OP_INDEX), LEFT_BIT, LEFT_LEN);
    }

    /**
     * Getter method to obtain memory in string.
     *
     * @return a string value of memory.
     */
    public String getLhsToString() {
        switch (getLhsLocation()) {
            case NULL:
                return "";
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
     * Getter method to obtain Operator.
     *
     * @return an int value of operator.
     */
    public int getOperator() {
        return getBitRange(getValue(OP_INDEX), OP_BIT, OP_LEN);
    }

    /**
     * Gets the operator id from a String.
     *
     * @param val the char representing the operator
     * @return the operator id starting from a string.
     */
    public int getOperatorFromString(final String val) {
        switch (val.trim()) {
            case ("+"):
                return ADD;
            case ("-"):
                return SUB;
            case ("*"):
                return MUL;
            case ("/"):
                return DIV;
            case ("%"):
                return MOD;
            case ("&"):
                return AND;
            case ("|"):
                return OR;
            case ("^"):
                return XOR;
            default:
                throw new IllegalArgumentException();
        }
    }

    /**
     * Gets the operator as a String.
     *
     * @return a string representation of the operator.
     */
    public String getOperatorToString() {
        switch (getOperator()) {
            case (ADD):
                return " + ";
            case (SUB):
                return " - ";
            case (MUL):
                return " * ";
            case (DIV):
                return " / ";
            case (MOD):
                return " % ";
            case (AND):
                return " & ";
            case (OR):
                return " | ";
            case (XOR):
                return " ^ ";
            default:
                return "";
        }
    }

    /**
     * Getter method to obtain High Value.
     *
     * @return an int value of high value.
     */
    public int getRes() {
        return mergeBytes(getValue(RES_INDEX_H), getValue(RES_INDEX_L));
    }

    /**
     * Gets the result location from a String. See the SetAction(String)
     * constructor for more information on the format.
     *
     * @param val the String representing the operand
     * @return an array contianing the result location
     */
    public int[] getResFromString(final String val) {
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
                throw new IllegalArgumentException();
        }

        if (tmp[0] == PACKET) {
            tmp[1] = NetworkPacket.getNetworkPacketByteFromName(strVal[1]);
        } else {
            tmp[1] = Integer.parseInt(strVal[1]);
        }
        return tmp;
    }

    /**
     * Getter method to obtain Size.
     *
     * @return an int value of SIZE.
     */
    public int getResLocation() {
        return getBitRange(getValue(OP_INDEX), RES_BIT, RES_LEN) + 2;
    }

    /**
     * Getter method to obtain Size in string.
     *
     * @return a string in SIZE.
     */
    public String getResToString() {
        switch (getResLocation()) {
            case PACKET:
                return SET.name() + " P."
                        + NetworkPacket.getNetworkPacketByteName(getRes())
                        + " = ";
            case STATUS:
                return SET.name() + " R." + getRes() + " = ";
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
        return mergeBytes(getValue(RIGHT_INDEX_H), getValue(RIGHT_INDEX_L));
    }

    /**
     * Getter method to obtain rhs Location.
     *
     * @return an int value of location.
     */
    public int getRhsLocation() {
        return getBitRange(getValue(OP_INDEX), RIGHT_BIT, RIGHT_LEN);
    }

    /**
     * Getter method to obtain memory in string.
     *
     * @return a string value of memory.
     */
    public String getRhsToString() {
        switch (getRhsLocation()) {
            case NULL:
                return "";
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
     * Setter method to set offsetIndex of action[].
     *
     * @param val value to set
     * @return this Window
     */
    public SetAction setLhs(final int val) {
        setValue(LEFT_INDEX_L, (byte) val);
        setValue(LEFT_INDEX_H, (byte) val >>> Byte.SIZE);
        return this;
    }

    /**
     * Setter method to set OP_INDEX of action[].
     *
     * @param value value to set
     * @return this Window
     */
    public SetAction setLhsLocation(final int value) {
        setValue(OP_INDEX, (byte) setBitRange(getValue(OP_INDEX),
                LEFT_BIT, LEFT_LEN, value));
        return this;
    }

    /**
     * Setter method to set OP_INDEX of action[].
     *
     * @param value value to set
     * @return this Window
     */
    public SetAction setOperator(final int value) {
        setValue(OP_INDEX, (byte) setBitRange(getValue(OP_INDEX),
                OP_BIT, OP_LEN, value));
        return this;
    }

    /**
     * Setter method to set highValueIndex of action[].
     *
     * @param val value to set
     * @return this Window
     */
    public SetAction setRes(final int val) {
        setValue(RES_INDEX_L, (byte) val);
        setValue(RES_INDEX_H, (byte) val >>> Byte.SIZE);
        return this;
    }

    /**
     * Setter method to set OP_INDEX of action[].
     *
     * @param value value to set
     * @return this Window
     */
    public SetAction setResLocation(final int value) {
        setValue(OP_INDEX, (byte) setBitRange(getValue(OP_INDEX),
                RES_BIT, RES_LEN, value));
        return this;
    }

    /**
     * Setter method to set highValueIndex of action[].
     *
     * @param val value to set
     * @return this Window
     */
    public SetAction setRhs(final int val) {
        setValue(RIGHT_INDEX_L, (byte) val);
        setValue(RIGHT_INDEX_H, (byte) val >>> Byte.SIZE);
        return this;
    }

    /**
     * Setter method to set OP_INDEX of action[].
     *
     * @param value value to set
     * @return this Window
     */
    public SetAction setRhsLocation(final int value) {
        setValue(OP_INDEX, (byte) setBitRange(getValue(OP_INDEX),
                RIGHT_BIT, RIGHT_LEN, value));
        return this;
    }

    @Override
    public String toString() {
        String f = getResToString();
        String l = getLhsToString();
        String r = getRhsToString();
        String o = getOperatorToString();

        if (!l.isEmpty() && !r.isEmpty()) {
            return f + l + o + r;
        } else if (r.isEmpty()) {
            return f + l;
        } else {
            return f + r;
        }
    }

}
