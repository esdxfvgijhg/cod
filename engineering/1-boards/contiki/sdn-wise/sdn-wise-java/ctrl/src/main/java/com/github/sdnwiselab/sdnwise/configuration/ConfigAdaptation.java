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
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * Holder of the two {@code Map<String,String>} containing the configuration
 * parameters for the lower and upper adapter of an adaptation object.
 *
 * @author Sebastiano Milardo
 */
public class ConfigAdaptation {

    /**
     * Contain the lower and upper adapter configurations.
     */
    private final List<Map<String, String>> lower = new LinkedList<>(),
            upper = new LinkedList<>();

    /**
     * Returns an unmodifiableMap containing the configurations for the lower
     * Adapter.
     *
     * @return a {@code Map<String,String>} containing the configurations for
     * the lower Adapter
     * @see com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter
     */
    public final List<Map<String, String>> getLowers() {
        return Collections.unmodifiableList(lower);
    }

    /**
     * Returns an unmodifiableMap containing the configurations for the upper
     * Adapter.
     *
     * @return a {@code Map<String,String>} containing the configurations for
     * the upper Adapter
     * @see com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter
     */
    public final List<Map<String, String>> getUppers() {
        return Collections.unmodifiableList(upper);
    }

}
