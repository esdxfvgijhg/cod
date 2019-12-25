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

import static com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.Action.FUNCTION;
import java.util.Arrays;

/**
 * Representation of the FunctionAction. This action is used to invoke a
 * function installed in the node. This implementation works only for the java
 * emulated nodes.
 *
 * @author Sebastiano Milardo
 */
public final class FunctionAction extends AbstractAction {

    /**
     * Field indexes.
     */
    private static final byte ARGS_INDEX = 1, ID_INDEX = 0;

    /**
     * Creates a FunctionAction object.
     *
     * @param value an array representing the FunctionAction object
     */
    public FunctionAction(final byte[] value) {
        super(value);
    }

    /**
     * Creates a Function action starting from a String. The string specifies
     * the name of the action, the id of the function and an array of bytes. An
     * example is "FUNCTION 1 0 1 2 3 4 5 6" without quotes.
     *
     * @param str the String representing the action
     */
    public FunctionAction(final String str) {
        super(FUNCTION, 0);
        String[] tmp = str.split(" ");
        if (tmp[0].equals(FUNCTION.name())) {
            byte[] args = new byte[tmp.length - 1];
            for (int i = 0; i < args.length; i++) {
                args[i] = (byte) (Integer.parseInt(tmp[i + 1]));
            }
            setValue(args);
        } else {
            throw new IllegalArgumentException();
        }
    }

    /**
     * Gets the list of arguments that will be provided to the function.
     *
     * @return the list of arguments as a byte array
     */
    public byte[] getArgs() {
        byte[] value = getValue();
        return Arrays.copyOfRange(value, ARGS_INDEX, value.length);
    }

    /**
     * Gets the id of the function that will be invoked. When istalled each
     * function has a id.
     *
     * @return the id of the function
     */
    public int getId() {
        return getValue(ID_INDEX);
    }

    /**
     * Sets the list of arguments that will be provided to the function.
     *
     * @param args the list of arguments as a byte array
     * @return the FunctionAction itself
     */
    public FunctionAction setArgs(final byte[] args) {
        int i = 0;
        for (byte b : args) {
            setValue(ARGS_INDEX + i, b);
            i++;
        }
        return this;
    }

    /**
     * Sets the id of the function that will be invoked. When istalled each
     * function has a id.
     *
     * @param id identificator of the function
     * @return the FunctionAction itself
     */
    public FunctionAction setId(final int id) {
        setValue(ID_INDEX, id);
        return this;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder(FUNCTION.name());
        sb.append(' ').append(getId()).append(' ');
        for (byte b : getArgs()) {
            sb.append(Byte.toUnsignedInt(b)).append(' ');
        }
        return sb.toString();
    }
}
