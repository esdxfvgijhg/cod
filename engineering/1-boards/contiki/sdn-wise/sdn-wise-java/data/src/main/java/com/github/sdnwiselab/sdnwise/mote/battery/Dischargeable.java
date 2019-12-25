/*
 * Copyright (C) 2016 Seby
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
package com.github.sdnwiselab.sdnwise.mote.battery;

/**
 * Models a battery.
 *
 * @author Sebastiano Milardo
 */
public interface Dischargeable {

    /**
     * Gets the battery level as a percent of the MAX_LEVEL.
     *
     * @return the Battery level in the range [0-255].
     */
    int getByteLevel();

    /**
     * Gets the battery level of the Battery.
     *
     * @return the battery level of the node as a double. Can't be negative.
     */
    double getLevel();

    /**
     * Setter for the battery level of the Battery.
     *
     * @param batteryLevel the battery level. If negative, the battery level is
     * set to 0.
     */
    void setLevel(double batteryLevel);

    /**
     * Simulates the battery consumption for staying alive for n seconds.
     *
     * @param n the number of seconds the node is turned on.
     * @return the Battery object
     */
    Battery keepAlive(int n);

    /**
     * Simulates the battery consumption for receiving nByte bytes.
     *
     * @param nBytes the number of bytes received over the radio
     * @return the Battery object
     */
    Battery receiveRadio(int nBytes);

    /**
     * Simulates the battery consumption for sending nByte bytes.
     *
     * @param nBytes the number of bytes sent over the radio
     * @return the Battery object
     */
    Battery transmitRadio(int nBytes);

}
