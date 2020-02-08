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
package com.github.sdnwiselab.sdnwise.mote.standalone;

import com.github.sdnwiselab.sdnwise.mote.battery.Battery;
import com.github.sdnwiselab.sdnwise.mote.battery.Dischargeable;
import com.github.sdnwiselab.sdnwise.mote.core.MoteCore;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;

/**
 * Models a SDN-WISE Mote as a standalone application.
 *
 * @author Sebastiano Milardo
 */
public class Mote extends AbstractMote {

    /**
     * Creates and starts a new Mote application.
     *
     * @param net the Network Id of the node
     * @param myAddress the address of the node
     * @param port the listening port of the node
     * @param neighboursPath the path to the file containing neighbours info
     * @param logLevel log level of the logger of the node
     */
    public Mote(final byte net,
            final NodeAddress myAddress,
            final int port,
            final String neighboursPath,
            final String logLevel) {
        super(port, neighboursPath, logLevel);
        Dischargeable battery = new Battery();
        setCore(new MoteCore(net, myAddress, battery)).start();
    }
}
