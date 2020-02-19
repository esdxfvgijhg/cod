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
package com.github.sdnwiselab.sdnwise.mote.core;

/**
 * Contains all the constants for the correct simulation of a SDN-WISE node.
 *
 * @author Sebastiano Milardo
 */
public final class Constants {

    /**
     * Routing constants.
     */
    public static final int SDN_WISE_DFLT_RSSI_MIN = 180;

    /**
     * Table constants.
     */
    public static final byte ENTRY_TTL_DECR = 10;

    /**
     * Timer constants.
     */
    public static final byte SDN_WISE_DFLT_CNT_DATA_MAX = 10,
            SDN_WISE_DFLT_CNT_BEACON_MAX = 10,
            SDN_WISE_DFLT_CNT_REPORT_MAX = 2 * SDN_WISE_DFLT_CNT_BEACON_MAX,
            SDN_WISE_DFLT_CNT_UPDTABLE_MAX = 6; // TTL = 150s

    /**
     * Status Register constants.
     */
    public static final int SDN_WISE_STATUS_LEN = 10000;

    /**
     * Serial port constants.
     */
    public static final int SDN_WISE_COM_START_BYTE = 0x7A,
            SDN_WISE_COM_STOP_BYTE = 0x7E;

    /**
     * Send constants.
     */
    public static final boolean SDN_WISE_MAC_SEND_UNICAST = false,
            SDN_WISE_MAC_SEND_BROADCAST = true;

    /**
     * Private constructor.
     */
    private Constants() {
    }

}
