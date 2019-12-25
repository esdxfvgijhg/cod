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

import com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.Action;
import static com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.TYPE_INDEX;

/**
 * @author Sebastiano Milardo
 */
public final class ActionBuilder {

    /**
     * Builds a class extending AbstractAction, given a String.
     *
     * @param val the String representing the action
     * @return an object extending AbstractAction
     */
    public static AbstractAction build(final String val) {
        switch (Action.valueOf(val.split(" ")[0])) {
            case FORWARD_U:
                return new ForwardUnicastAction(val);
            case FORWARD_B:
                return new ForwardBroadcastAction();
            case SET:
                return new SetAction(val);
            case MATCH:
                return new MatchAction();
            case ASK:
                return new AskAction();
            case FUNCTION:
                return new FunctionAction(val);
            case DROP:
                return new DropAction();
            default:
                throw new IllegalArgumentException();
        }
    }

    /**
     * Builds a class extending AbstractAction, given a byte array.
     *
     * @param array the byte[] representing the action
     * @return an object extending AbstractAction
     */
    public static AbstractAction build(final byte[] array) {
        switch (Action.fromByte(array[TYPE_INDEX])) {
            case FORWARD_U:
                return new ForwardUnicastAction(array);
            case FORWARD_B:
                return new ForwardBroadcastAction(array);
            case DROP:
                return new DropAction(array);
            case FUNCTION:
                return new FunctionAction(array);
            case ASK:
                return new AskAction(array);
            case SET:
                return new SetAction(array);
            case MATCH:
                return new MatchAction(array);
            default:
                throw new IllegalArgumentException();
        }
    }

    /**
     * The ActionBuilder class is a utility class. Therefore there is no public
     * constructor.
     */
    private ActionBuilder() {
    }
}
