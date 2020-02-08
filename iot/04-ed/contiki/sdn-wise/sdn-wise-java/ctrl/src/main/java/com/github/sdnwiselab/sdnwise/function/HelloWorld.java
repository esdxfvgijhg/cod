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
package com.github.sdnwiselab.sdnwise.function;

import com.github.sdnwiselab.sdnwise.flowtable.FlowTableEntry;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import com.github.sdnwiselab.sdnwise.util.Neighbor;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;
import java.util.concurrent.ArrayBlockingQueue;

/**
 * @author Sebastiano Milardo
 */
public class HelloWorld implements FunctionInterface {

    @Override
    public final void function(
            final HashMap<String, Object> adcRegister,
            final List<FlowTableEntry> flowTable,
            final Set<Neighbor> neighborTable,
            final ArrayList<Integer> statusRegister,
            final List<NodeAddress> acceptedId,
            final ArrayBlockingQueue<NetworkPacket> flowTableQueue,
            final ArrayBlockingQueue<NetworkPacket> txQueue,
            final byte[] args,
            final NetworkPacket np
    ) {
        System.out.println("Hello, World!");
    }
}
