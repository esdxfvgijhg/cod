/*
 * Copyright (C) 2015 Seby
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

import static com.github.sdnwiselab.sdnwise.flowtable.AbstractAction.Action.FORWARD_U;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;

/**
 * Representation of the ForwardUnicast action. A packet which is forwarded in
 * unicast is received by the node specified.
 *
 * @author Sebastiano Milardo
 */
public final class ForwardUnicastAction extends AbstractForwardAction {

    /**
     * Creates a ForwardUnicast action. The next hop is set by using the String.
     * An example of a string is "FORWARD_U 0.1" without quotes.
     *
     * @param str the string representing the ForwardUnicast action
     */
    public ForwardUnicastAction(final String str) {
        super(FORWARD_U);
        if (FORWARD_U.name().equals(str.split(" ")[0].trim())) {
            setNextHop(new NodeAddress(str.split(" ")[1].trim()));
        } else {
            throw new IllegalArgumentException();
        }
    }

    /**
     * Creates a ForwardUnicast action. The next hop is set by using the a
     * NodeAddress.
     *
     * @param nextHop the next hop address
     */
    public ForwardUnicastAction(final NodeAddress nextHop) {
        super(FORWARD_U);
        setNextHop(nextHop);
    }

    /**
     * Creates a ForwardUnicast action.
     *
     * @param value a byte array representing the ForwardAction
     */
    public ForwardUnicastAction(final byte[] value) {
        super(value);
    }

    @Override
    public String toString() {
        return FORWARD_U.name() + " " + getNextHop().intValue();
    }
}
