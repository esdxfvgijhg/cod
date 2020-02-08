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

import com.github.sdnwiselab.sdnwise.util.NodeAddress;

/**
 * @author Sebastiano Milardo
 */
public abstract class AbstractForwardAction extends AbstractAction {

    /**
     * The index in the action array where the address of the next hop is
     * located.
     */
    private static final byte NXH_INDEX = 0;

    /**
     * Creates a new AbstractAction given an ActionType.
     *
     * @param actionType the action type of the Abstract Action
     */
    public AbstractForwardAction(final Action actionType) {
        super(actionType, 2);
    }

    /**
     * Creates a new AbstractAction given an array of bytes.
     *
     * @param value the byte array
     */
    public AbstractForwardAction(final byte[] value) {
        super(value);
    }

    /**
     * Sets the next hop toward which the packet will be sent.
     *
     * @param addr the NodeAddress of the next hop
     * @return the action itself
     */
    public final AbstractForwardAction setNextHop(final NodeAddress addr) {
        setValue(NXH_INDEX, addr.getHigh());
        setValue(NXH_INDEX + 1, addr.getLow());
        return this;
    }

    /**
     * Gets the next hop toward which the packet will be sent.
     *
     * @return the NodeAddress of the next hop
     */
    public final NodeAddress getNextHop() {
        return new NodeAddress(getValue(NXH_INDEX), getValue(NXH_INDEX + 1));
    }
}
