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
package com.github.sdnwiselab.sdnwise.controller;

import com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter;
import com.github.sdnwiselab.sdnwise.adapter.AdapterTcp;
import com.github.sdnwiselab.sdnwise.adapter.AdapterUdp;
import com.github.sdnwiselab.sdnwise.configuration.ConfigController;
import com.github.sdnwiselab.sdnwise.configuration.Configurator;
import com.github.sdnwiselab.sdnwise.topology.NetworkGraph;
import com.github.sdnwiselab.sdnwise.topology.VisualNetworkGraph;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;

import java.net.InetSocketAddress;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Builder of AbstractController objects given the specifications contained in a
 * Configurator object. In the current version the only possible lower adapter
 * is an AdapterUdp while the only possible algorithm is Dijkstra
 *
 * @author Sebastiano Milardo
 */
public class ControllerFactory {

    /**
     * Controller Identificator.
     */
    private static InetSocketAddress id = null;

    /**
     * Returns the corresponding AbstractController object given a Configurator
     * object.
     *
     * @param config a Configurator object.
     * @return an AbstractController object.
     */
    public final AbstractController getController(final Configurator config) {
        List<AbstractAdapter> adapt = getLower(config.getController());
        NetworkGraph ng = getNetworkGraph(config.getController());
        return getControllerType(config.getController(), id, adapt, ng);
    }

    /**
     * Creates a controller. The only accepted type of controller at the moment
     * is Dijkstra.
     *
     * @param conf a ConfigController class containing the config parameters of
     * the controller
     * @param newId the id of the controller
     * @param adapt the lower adapter of the controller
     * @param ng the NetworkGraph used
     * @return an AbstractController
     */
    public final AbstractController getControllerType(
            final ConfigController conf,
            final InetSocketAddress newId,
            final List<AbstractAdapter> adapt,
            final NetworkGraph ng) {
        String type = conf.getAlgorithm().get("TYPE");
        NodeAddress sink = new NodeAddress(conf.getAlgorithm().get("SINK"));
        switch (type) {
            case "DIJKSTRA":
                return new ControllerDijkstra(newId, adapt, ng, sink);
            default:
                throw new UnsupportedOperationException(
                        "Error in Configuration file");
        }
    }

    /**
     * Creates a lower adapter for the controller.
     *
     * @param conf a ConfigController class containing the config parameters of
     * the controller
     * @return the lower adapter
     */
    private List<AbstractAdapter> getLower(final ConfigController conf) {
        List<AbstractAdapter> low = new LinkedList<>();

        for (Map<String, String> map : conf.getLower()) {
            String type = map.get("TYPE");
            id = new InetSocketAddress(map.get("IP"),
                    Integer.parseInt(map.get("PORT")));
            switch (type) {
                case "TCP":
                    low.add(new AdapterTcp(map));
                    break;
                case "UDP":
                    low.add(new AdapterUdp(map));
                    break;
                default:
                    throw new UnsupportedOperationException(
                            "Error in config file");
            }
        }
        return low;
    }

    /**
     * Creates a NetworkGraph for the controller. This parameter manages the UI
     * of the controller.
     *
     * @param conf a ConfigController class containing the config parameters of
     * the controller
     * @return the NetworkGraph object
     */
    private NetworkGraph getNetworkGraph(final ConfigController conf) {
        String graph = conf.getMap().get("GRAPH");
        int timeout = Integer.parseInt(conf.getMap().get("TIMEOUT"));
        int rssiResolution = Integer.parseInt(conf.getMap()
                .get("RSSI_RESOLUTION"));

        switch (graph) {
            case "GUI":
                return new VisualNetworkGraph(timeout, rssiResolution);
            case "CLI":
                return new NetworkGraph(timeout, rssiResolution);
            default:
                throw new UnsupportedOperationException(
                        "Error in Configuration file");
        }
    }

}
