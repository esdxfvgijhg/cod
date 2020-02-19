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

import static com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.Action.DROP;

/**
 * @author Sebastiano Milardo
 */
public final class DropAction extends AbstractAction {

    /**
     * The size of the action.
     */
    private static final byte SIZE = 0;

    /**
     * Creates a DropAction object. A DropAction is used to drop all the packets
     * matching the windows in the FlowTableEntry.
     */
    public DropAction() {
        super(DROP, SIZE);
    }

    /**
     * Creates a DropAction object. A DropAction is used to drop all the packets
     * matching the windows in the FlowTableEntry.
     *
     * @param value the array representing the DropAction object
     */
    public DropAction(final byte[] value) {
        super(value);
    }
}
