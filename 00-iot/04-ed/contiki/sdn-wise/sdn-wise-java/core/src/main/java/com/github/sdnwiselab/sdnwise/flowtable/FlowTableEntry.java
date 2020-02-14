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

import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.Objects;

/**
 * FlowTableEntry represents the structure of the Entry of a FlowTable. It is
 * made of Window[], AbstractAction and Statistics. This Class implements
 * FlowTableInterface.
 *
 * @author Sebastiano Milardo
 */
public final class FlowTableEntry implements FlowTableInterface {

    /**
     * Contains the list of windows of the FlowTableEntry. All the windows must
     * be sadisfied in order to execute the actions.
     */
    private final List<Window> windows = new LinkedList<>();
    /**
     * Contains the list of actions of the FlowTableEntry. The actions are
     * executed when all the windows are satisfied.
     */
    private final List<AbstractAction> actions = new LinkedList<>();
    /**
     * Statistics on the usages and time to live of the FlowTableEntry.
     */
    private Stats stats = new Stats();

    /**
     * Creates a FlowTableEntry object from a String.
     *
     * @param s the String used to create the FlowTableEntry
     * @return a new FlowTableEntry object
     */
    public static FlowTableEntry fromString(final String s) {
        String val = s.toUpperCase();
        FlowTableEntry res = new FlowTableEntry();

        String[] strWindows = (val.substring(
                val.indexOf("(") + 1, val.indexOf(")"))).split("&&");

        for (String w : strWindows) {
            res.addWindow(Window.fromString(w.trim()));
        }

        String[] strActions = (val.substring(
                val.indexOf("{") + 1, val.indexOf("}"))).trim().split(";");

        for (String a : strActions) {
            res.addAction(ActionBuilder.build(a.trim()));
        }
        return res;
    }

    /**
     * Simple constructor for the FlowTableEntry object.
     *
     * It creates new Window instances setting all the values to 0.
     */
    public FlowTableEntry() {
    }

    /**
     * Constructor for the FlowTableEntry object. It initializes new Window[],
     * AbstractAction and Stats instances.
     *
     * @param entry From byte array to FlowTableEntry
     */
    public FlowTableEntry(final byte[] entry) {
        int i = 0;

        int nWindows = entry[i];

        for (i = 1; i <= nWindows; i += Window.SIZE) {
            windows.add(new Window(
                    Arrays.copyOfRange(entry, i, i + Window.SIZE)));
        }

        while (i < entry.length - (Stats.SIZE)) {
            int len = entry[i++];
            actions.add(ActionBuilder.build(
                    Arrays.copyOfRange(entry, i, i + len)));
            i += len;
        }

        stats = new Stats(
                Arrays.copyOfRange(
                        entry, entry.length - Stats.SIZE, entry.length)
        );

    }

    @Override
    public String toString() {
        StringBuilder out = new StringBuilder("if (");

        windows.stream().map((Window w) -> {
            StringBuilder part = new StringBuilder();
            part.append(w.toString());
            return part;
        }).filter((part) -> (!part.toString().isEmpty())).forEach((part) -> {
            if (out.toString().equals("if (")) {
                out.append(part);
            } else {
                out.append(" && ").append(part);
            }
        });
        if (!out.toString().isEmpty()) {
            out.append(") { ");
            actions.stream().forEach((a) -> {
                out.append(a.toString()).append("; ");
            });
            out.append("} (")
                    .append(getStats().toString())
                    .append(')');
        }
        return out.toString().toUpperCase();
    }

    /**
     * Getter method to obtain the window array of the FlowTable entry.
     *
     * @return the window[] of the FlowTable
     */
    public List<Window> getWindows() {
        return windows;
    }

    /**
     * Sets a window list in the FlowTable entry.
     *
     * @param w the windows list to set
     */
    public void setWindows(final List<Window> w) {
        windows.clear();
        windows.addAll(w);
    }

    /**
     * Adds a window to the list of the windows in the FlowTable entry.
     *
     * @param w element to be appended
     * @return true
     */
    public boolean addWindow(final Window w) {
        return windows.add(w);
    }

    /**
     * Getter method to obtain the AbstractAction part of the FlowTable entry.
     *
     * @return the action of the FlowTable
     */
    public List<AbstractAction> getActions() {
        return actions;
    }

    /**
     * Setter method to set the AbstractAction part of the FlowTable entry.
     *
     * @param a the action to set
     */
    public void setAction(final List<AbstractAction> a) {
        actions.clear();
        actions.addAll(a);
    }

    /**
     * Adds an action to the FlowTable entry.
     *
     * @param a element to be appended
     * @return true
     */
    public boolean addAction(final AbstractAction a) {
        return actions.add(a);
    }

    /**
     * Getter method to obtain the Statistics of the FlowTable entry.
     *
     * @return the statistics of the FlowTable entry.
     */
    public Stats getStats() {
        return stats;
    }

    /**
     * Setter method to set statistics of the FlowTable entry.
     *
     * @param s the statistics will be set.
     */
    public void setStats(final Stats s) {
        stats = s;
    }

    @Override
    public byte[] toByteArray() {
        int size = (1 + windows.size() * Window.SIZE) + Stats.SIZE;
        for (AbstractAction a : actions) {
            size = size + a.getActionLength() + 1;
        }

        ByteBuffer target = ByteBuffer.allocate(size);
        target.put((byte) (windows.size() * Window.SIZE));

        windows.stream().forEach((fw) -> {
            target.put(fw.toByteArray());
        });

        actions.stream().map((a) -> {
            target.put((byte) a.getActionLength());
            return a;
        }).forEach((a) -> {
            target.put(a.toByteArray());
        });

        target.put(stats.toByteArray());

        return target.array();
    }

    @Override
    public int hashCode() {
        int hash = Objects.hashCode(windows) + Objects.hashCode(actions)
                + Objects.hashCode(stats);
        return hash;
    }

    /**
     * Indicates whether the windows of another FlowTableEntry object are "equal
     * to" the windows of this one.
     *
     * @param other the other FlowTableEntry object
     * @return {@code true} if this object is the same as the obj argument;
     * {@code false} otherwise.
     */
    public boolean equalWindows(final FlowTableEntry other) {
        return Objects.deepEquals(windows, other.windows);
    }

    @Override
    public boolean equals(final Object obj) {
        if (obj == null) {
            return false;
        }
        if (getClass() != obj.getClass()) {
            return false;
        }
        final FlowTableEntry other = (FlowTableEntry) obj;
        if (!Objects.deepEquals(windows, other.windows)) {
            return false;
        }
        return Objects.deepEquals(actions, other.actions);
    }

}
