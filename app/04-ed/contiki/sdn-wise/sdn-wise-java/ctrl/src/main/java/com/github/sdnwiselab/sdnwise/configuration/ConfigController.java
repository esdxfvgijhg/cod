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
package com.github.sdnwiselab.sdnwise.configuration;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Holder of the three {@code Map<String,String>} containing the configuration
 * parameters for the lower adapter, the algorithm and the network map of a
 * controller object.
 *
 * @author Sebastiano Milardo
 */
public class ConfigController {

    /**
     * Contain the lower and upper adapter, and the map configurations.
     */
    private final Map<String, String> algorithm = new HashMap<>(),
            map = new HashMap<>();

    /**
     * Contains the lower adapters.
     */
    private List<Map<String, String>> lower;

    /**
     * Returns an unmodifiableMap containing the configurations for the
     * algorithm used.
     *
     * @return a {@code Map<String,String>} containing the configurations for
     * the algorithm used
     */
    public final Map<String, String> getAlgorithm() {
        return Collections.unmodifiableMap(algorithm);
    }

    /**
     * Returns an unmodifiableMap containing the configurations for the lower
     * Adapter.
     *
     * @return a {@code Map<String,String>} containing the configurations for
     * the lower Adapter
     * @see com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter
     */
    public final List<Map<String, String>> getLower() {
        return lower;
    }

    /**
     * Returns an unmodifiableMap containing the configurations for the network
     * map.
     *
     * @return a {@code Map<String,String>} containing the configurations for
     * the network map
     */
    public final Map<String, String> getMap() {
        return Collections.unmodifiableMap(map);
    }
}
