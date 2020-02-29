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
package com.github.sdnwiselab.sdnwise.flowtable;

import java.util.Arrays;

/**
 * Stats is part of the structure of the FlowTableEntry. This Class implements
 * FlowTableInterface.
 *
 * @author Sebastiano Milardo
 */
public final class Stats implements FlowTableInterface {

    /**
     * The size in byte of the Statistical info.
     */
    public static final byte SIZE = 2;
    /**
     * A FlowTableEntry with TTL = 255 can be deleted only by the controller.
     */
    public static final int ENTRY_TTL_PERMANENT = 255;
    /**
     * The maximum TTL of a FlowTableEntry.
     */
    public static final int SDN_WISE_RL_TTL_MAX = 254;

    /**
     * Stats field indexes.
     */
    private static final byte TTL_INDEX = 0, COUNT_INDEX = 1;

    /**
     * An array of byte containing the Statistical information.
     */
    private final byte[] stats = new byte[SIZE];

    /**
     * Simple constructor for the FlowTableStats object.
     *
     * It sets the statistical fields to the default values.
     */
    public Stats() {
        stats[TTL_INDEX] = (byte) SDN_WISE_RL_TTL_MAX;
        stats[COUNT_INDEX] = 0;
    }

    /**
     * Constructor for the FlowTableStats object.
     *
     * @param value byte array to copy into the statistical part.
     */
    public Stats(final byte[] value) {
        switch (value.length) {
            case 2:
                stats[TTL_INDEX] = value[TTL_INDEX];
                stats[COUNT_INDEX] = value[COUNT_INDEX];
                break;
            case 1:
                stats[TTL_INDEX] = value[TTL_INDEX];
                stats[COUNT_INDEX] = 0;
                break;
            default:
                stats[TTL_INDEX] = (byte) SDN_WISE_RL_TTL_MAX;
                stats[COUNT_INDEX] = 0;
                break;
        }
    }

    /**
     * Getter Method to obtain the ttl value. When the TTL of an entry is equal
     * to 0 the entry is remove from the FlowTable.
     *
     * @return value of ttl of stats[].
     */
    public int getTtl() {
        return Byte.toUnsignedInt(stats[TTL_INDEX]);
    }

    /**
     * Getter Method to obtain count value. The count value represent the number
     * of times an entry has been executed in the FlowTable. This value is not
     * sent to a node.
     *
     * @return value of count of stats[].
     */
    public int getCounter() {
        return Byte.toUnsignedInt(stats[COUNT_INDEX]);
    }

    /**
     * Setter Method to set count value. The count value represent the number of
     * times an entry has been executed in the FlowTable. This value is not sent
     * to a node.
     *
     * @param count to be set
     * @return this Stats
     */
    public Stats setCounter(final int count) {
        stats[COUNT_INDEX] = (byte) count;
        return this;
    }

    /**
     * Increases the usage counter.
     *
     * @return the object itself
     */
    public Stats increaseCounter() {
        stats[COUNT_INDEX]++;
        return this;
    }

    @Override
    public String toString() {
        if (getTtl() == ENTRY_TTL_PERMANENT) {
            return "TTL: PERM, U: " + getCounter();
        } else {
            return "TTL: " + getTtl() + ", U: " + getCounter();
        }
    }

    @Override
    public byte[] toByteArray() {
        return Arrays.copyOf(stats, SIZE);
    }

    /**
     * Turns the FlowTableEntry into a permanent entry. Can be deleted only by a
     * Controller
     *
     * @return the object itself
     */
    public Stats setPermanent() {
        setTtl(ENTRY_TTL_PERMANENT);
        return this;
    }

    /**
     * Restores the TTL of a entry to its maximum.
     *
     * @return the object itself
     */
    public Stats restoreTtl() {
        setTtl(SDN_WISE_RL_TTL_MAX);
        return this;
    }

    /**
     * Decrement by a certain value the TTL of an entry.
     *
     * @param value how much the ttl will be decremented
     * @return the object itself
     */
    public Stats decrementTtl(final int value) {
        setTtl(getTtl() - value);
        return this;
    }

    /**
     * Sets the TTL of an entry.
     *
     * @param ttl the new value of the ttl
     * @return the object itself
     */
    private Stats setTtl(final int ttl) {
        stats[TTL_INDEX] = (byte) ttl;
        return this;
    }
}
