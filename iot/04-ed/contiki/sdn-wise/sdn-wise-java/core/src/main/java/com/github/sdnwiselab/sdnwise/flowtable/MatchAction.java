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

import static com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.Action.MATCH;

/**
 * Representing the Match action. A match action is used to match the current
 * packet against all the FlowTableEntry of the FlowTable.
 *
 * @author Sebastiano Milardo
 */
public final class MatchAction extends AbstractAction {

    /**
     * The size of the action.
     */
    private static final byte SIZE = 0;

    /**
     * Creates a MatchAction object. A MatchAction is used to match the current
     * packet against all the FlowTableEntry of the FlowTable.
     */
    public MatchAction() {
        super(MATCH, SIZE);
    }

    /**
     * Creates a MatchAction object. A MatchAction is used to match the current
     * packet against all the FlowTableEntry of the FlowTable.
     *
     * @param array the array representing the MatchAction object
     */
    public MatchAction(final byte[] array) {
        super(array);
    }
}
