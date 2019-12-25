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

import com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter;
import com.github.sdnwiselab.sdnwise.controlplane.ControlPlaneLayer;
import com.github.sdnwiselab.sdnwise.controlplane.ControlPlaneLogger;
import java.util.Arrays;
import java.util.List;
import java.util.Observable;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Incorporates the communication adapters for connecting the controller to the
 * sensor networks and vice versa. This class is implemented as an Observer, so
 * it has an update method that is called every time a new message is received
 * by one of the two adapters. This class also implements runnable and it works
 * on a separate thread. The behavior of this class is equal to a transparent
 * proxy that send messages coming from the lower adapter to the upper adapter
 * and from the upper adapter to the lower.
 *
 * @author Sebastiano Milardo
 */
public class Adaptation extends ControlPlaneLayer {

    /**
     * To avoid garbage collector.
     */
    protected static final Logger LOGGER = Logger.getLogger("ADA");

    /**
     * Creates an adaptation object given two adapters.
     *
     * @param lower the adapter that receives messages from the sensor network
     * @param upper the adapter that receives messages from the controller
     */
    Adaptation(final List<AbstractAdapter> lower,
            final List<AbstractAdapter> upper) {
        super("ADA", lower, upper);
        ControlPlaneLogger.setupLogger(getLayerShortName());
    }

    @Override
    public void setupLayer() {
        // Nothing to do here
    }

    /**
     * Called by each message coming from the adapters. Messages coming from the
     * lower adapter are sent to the upper one and vice versa.
     *
     * @param o the adapter that has received the message
     * @param arg the message received as a byte array
     */
    @Override
    public final void update(final Observable o, final Object arg) {
        boolean found = false;
        byte[] data = (byte[]) arg;
        String dataString = "";

        if (data != null && data.length>0){
            StringBuilder b = new StringBuilder();
            b.append('[');
            for (byte a : data){
                b.append(a & 0xFF).append(", ");
            }
            b.append(']');
            dataString = b.toString();
        }


        for (AbstractAdapter adapter : getLower()) {
            if (o.equals(adapter)) {
                log(Level.INFO, "\u2191" + dataString);
                for (AbstractAdapter ad : getUpper()) {
                    ad.send((byte[]) arg);
                }
                found = true;
                break;
            }
        }

        if (!found) {
            for (AbstractAdapter adapter : getUpper()) {
                if (o.equals(adapter)) {
                    log(Level.INFO, "\u2193" + dataString);
                    for (AbstractAdapter ad : getLower()) {
                        ad.send((byte[]) arg);
                    }
                    break;
                }
            }
        }
    }
}
