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
package com.github.sdnwiselab.sdnwise.adaptation;

import com.github.sdnwiselab.sdnwise.adapter.*;
import com.github.sdnwiselab.sdnwise.configuration.ConfigAdaptation;
import com.github.sdnwiselab.sdnwise.configuration.Configurator;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Creates an Adaptation object given the specifications contained in a
 * Configurator object. This class implements the factory object pattern.
 * <p>
 * This class is used in the initialization phase of the network in order to
 * create an adaptation object. The different types of adapter are chosen using
 * the option TYPE of the configuration file provided to the ConfigAdaptation
 * class.
 *
 * @author Sebastiano Milardo
 */
public final class AdaptationFactory {

    /**
     * Contains the configuration parameters of the class.
     */
    private static ConfigAdaptation conf;

    /**
     * Returns an adaptation object given a configAdaptation object. If one of
     * the adapter cannot be instantiated then this method throws an
     * UnsupportedOperationException.
     *
     * @param c contains the configurations for the adaptation object
     * @return an adaptation object
     */
    public static Adaptation getAdaptation(final Configurator c) {
        conf = c.getAdaptation();
        List<AbstractAdapter> lower = getAdapters(conf.getLowers());
        List<AbstractAdapter> upper = getAdapters(conf.getUppers());
        return new Adaptation(lower, upper);
    }

    /**
     * Returns an adapter depending on the options specified. The supported
     * types at the moment are "UDP/TCP" for udp/tcp communication and "COM" for
     * serial port communication. "COOJA" adapter is still under development.
     * Details regarding the adapters are contained in the c map.
     *
     * @param c the type of adapter that will be instantiated.
     * @return an adapter object
     */
    private static AbstractAdapter getAdapter(final Map<String, String> c) {
        switch (c.get("TYPE")) {
            case "UDP":
                return new AdapterUdp(c);
            case "COM":
                return new AdapterCom(c);
            case "TCP":
                return new AdapterTcp(c);
            case "COOJA":
                return new AdapterCooja(c);
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
    private AdaptationFactory() {
        // Nothing to do here
    }
}
