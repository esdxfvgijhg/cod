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
package com.github.sdnwiselab.sdnwise.flowvisor;

import com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter;
import com.github.sdnwiselab.sdnwise.adapter.AdapterTcp;
import com.github.sdnwiselab.sdnwise.adapter.AdapterUdp;
import com.github.sdnwiselab.sdnwise.configuration.ConfigFlowVisor;
import com.github.sdnwiselab.sdnwise.configuration.Configurator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * FlowVisorFactory creates an FlowVisor object given the specifications
 * contained in a ConfigFlowVisor object. This class implements the factory
 * object pattern.
 *
 * @author Sebastiano Milardo
 */
public final class FlowVisorFactory {

    /**
     * Contains the configuration parameters of the class.
     */
    private static ConfigFlowVisor conf;

    /**
     *
     * Gets a FlowVisor object, created by this Factory Class.
     *
     * @param c ConfigFlowVisor file for this FlowVisorFactory.
     * @return FlowVisor object with a new AdapterUdp for Lower AbstractAdapter
     * and Upper AbstractAdapter
     */
    public static FlowVisor getFlowvisor(final Configurator c) {
        conf = c.getFlowvisor();
        return new FlowVisor(
                getAdapters(conf.getLowers()),
                getAdapters(conf.getLowers())
        );
    }

    /**
     * Returns an adapter depending on the options specified. The supported
     * types at the moment are "UDP/TCP" for udp/tcp communication and "COM" for
     * serial port communication. "OMNET" adapter is still under development.
     * Details regarding the adapters are contained in the c map.
     *
     * @param c the type of adapter that will be instantiated.
     * @return an adapter object
     */
    private static AbstractAdapter getAdapter(final Map<String, String> c) {
        switch (c.get("TYPE")) {
            case "UDP":
                return new AdapterUdp(c);
            case "TCP":
                return new AdapterTcp(c);
            default:
                throw new UnsupportedOperationException(
                        "Error in configuration file: "
                        + "Unsupported Adapter of type "
                        + c.get("TYPE"));
        }
    }

    /**
     * Returns a list of adapters depending on the options specified.
     *
     * @param c a list of maps conteining the parameters for each of the adapter
     * @return a list of Abstract Adapters
     */
    private static List<AbstractAdapter> getAdapters(
            final List<Map<String, String>> c) {
        List listAdapters = new LinkedList<>();
        c.stream().forEach((map) -> {
            listAdapters.add(getAdapter(map));
        });
        return listAdapters;
    }

    /**
     * Private constructor.
     */
    private FlowVisorFactory() {
        // Nothing to do here
    }
}
