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
 * @author Sebastiano Milardo
 * @param <K> Type of Key
 * @param <V> Type of Value
 */
public final class Pair<K, V> {

    /**
     * Key of this <code>Pair</code>.
     */
    private final K key;

    /**
     * Value of this this <code>Pair</code>.
     */
    private final V value;

    /**
     * Creates a new pair.
     *
     * @param k The key for this pair
     * @param v The value to use for this pair
     */
    public Pair(final K k, final V v) {
        key = k;
        value = v;
    }

    /**
     * <p>
     * Test this <code>Pair</code> for equality with another
     * <code>Object</code>.</p>
     *
     * <p>
     * If the <code>Object</code> to be tested is not a <code>Pair</code> or is
     * <code>null</code>, then this method returns <code>false</code>.</p>
     *
     * <p>
     * Two <code>Pair</code>s are considered equal if and only if both the names
     * and values are equal.</p>
     *
     * @param o the <code>Object</code> to test for equality with this
     * <code>Pair</code>
     * @return <code>true</code> if the given <code>Object</code> is equal to
     * this <code>Pair</code> else <code>false</code>
     */
    @Override
    public boolean equals(final Object o) {
        if (this == o) {
            return true;
        }
        if (o instanceof Pair) {
            Pair pair = (Pair) o;
            if (key != null ? !key.equals(pair.key) : pair.key != null) {
                return false;
            }
            return !(value != null
                    ? !value.equals(pair.value) : pair.value != null);
        }
        return false;
    }

    /**
     * Gets the key for this pair.
     *
     * @return key for this pair
     */
    public K getKey() {
        return key;
    }

    /**
     * Gets the value for this pair.
     *
     * @return value for this pair
     */
    public V getValue() {
        return value;
    }

    /**
     * <p>
     * Generate a hash code for this <code>Pair</code>.</p>
     *
     * <p>
     * The hash code is calculated using both the name and the value of the
     * <code>Pair</code>.</p>
     *
     * @return hash code for this <code>Pair</code>
     */
    @Override
    public int hashCode() {
        // name's hashCode is multiplied by an arbitrary prime number (13)
        // in order to make sure there is a difference in the hashCode between
        // these two parameters:
        //  name: a  value: aa
        //  name: aa value: a
        return key.hashCode() * 13 + (value == null ? 0 : value.hashCode());
    }

    /**
     * <p>
     * <code>String</code> representation of this <code>Pair</code>.</p>
     *
     * <p>
     * The default name/value delimiter '=' is always used.</p>
     *
     * @return <code>String</code> representation of this <code>Pair</code>
     */
    @Override
    public String toString() {
        return key + "=" + value;
    }
}
