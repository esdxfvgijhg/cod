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
package com.github.sdnwiselab.sdnwise.packet;

import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.CONFIG;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;

/**
 * This class models a Configuration packet. This packet is sent to a node to
 * read/write a parameter or to get/set/remove a rule, a funtion, or a node
 * address alias.
 *
 * @author Sebastiano Milardo
 */
public class ConfigPacket extends NetworkPacket {

    /**
     * The value indicating if the ConfigProperty is a READ or WRITE.
     */
    private static final byte CNF_WRITE = 1;

    /**
     * Constants for parsing.
     */
    private static final int MASK_POS = 7, MASK = 0x7F;

    /**
     * This constructor initialize a config packet starting from a byte array.
     *
     * @param data the byte array representing the config packet
     */
    public ConfigPacket(final byte[] data) {
        super(data);
    }

    /**
     * This constructor initialize a config packet starting from a int array.
     *
     * @param data the int array representing the config packet, all int are
     * casted to byte
     */
    public ConfigPacket(final int[] data) {
        super(data);
    }

    /**
     * This constructor initialize a config packet starting from a
     * NetworkPacket.
     *
     * @param data the NetworkPacket representing the beacon packet
     */
    public ConfigPacket(final NetworkPacket data) {
        super(data.toByteArray());
    }

    /**
     * This constructor initialize a config packet. The type of the packet is
     * set to {@code CONFIG} and the read/write bit is set to {@code READ}.
     *
     * @param net Network ID of the packet
     * @param src source address of the packet
     * @param dst destination address of the packet
     * @param read the name of the property to read
     */
    public ConfigPacket(final int net, final NodeAddress src,
            final NodeAddress dst,
            final ConfigProperty read) {
        super(net, src, dst);
        setConfigId(read).setTyp(CONFIG);
    }

    /**
     * This constructor initialize a config packet. The type of the packet is
     * set to {@code CONFIG} and the read/write bit is set to {@code WRITE}.
     *
     * @param net the Network ID of the node
     * @param src source address
     * @param dst destination address
     * @param write the name of the property to write
     * @param value the value to be written
     */
    public ConfigPacket(final int net, final NodeAddress src,
            final NodeAddress dst,
            final ConfigProperty write,
            final byte[] value) {
        super(net, src, dst);
        setConfigId(write).setWrite().setParams(value, write.size)
                .setTyp(CONFIG);
    }

    /**
     * Returns true if the Config packet is a write packet.
     *
     * @return a boolean indicating if the packet is a write packet
     */
    public final boolean isWrite() {
        int value = Byte.toUnsignedInt(getPayloadAt((byte) 0)) >> MASK_POS;
        return (value == CNF_WRITE);
    }

    /**
     * Returns the Configuration ID of the property to read/write.
     *
     * @return the ConfigProperty set in the packet
     */
    public final ConfigProperty getConfigId() {
        return ConfigProperty.fromByte((byte) (getPayloadAt((byte) 0) & MASK));
    }

    /**
     * Sets the value of the property to write. If the ConfigProperty of the
     * packet is a Get or Remove it contains the index of the item. If it is an
     * Add, the item itself.
     *
     * @param bytes the value of the property as a byte[]
     * @param size the size of the property
     * @return the packet itself
     */
    public final ConfigPacket setParams(final byte[] bytes, final int size) {
        if (size != -1) {
            for (int i = 0; i < size; i++) {
                setPayloadAt(bytes[i], i + 1);
            }
        } else {
            for (int i = 0; i < bytes.length; i++) {
                setPayloadAt(bytes[i], i + 1);
            }
        }
        return this;
    }

    /**
     * Gets the value of the read property.
     *
     * @return the configuration property as a byte[]
     */
    public final byte[] getParams() {
        return getPayloadFromTo(1, getPayloadSize());
    }

    /**
     * Sets the Config packet to be a write ConfigPacket.
     *
     * @return the packet itself
     */
    private ConfigPacket setWrite() {
        setPayloadAt((byte) ((getPayloadAt(0)) | (CNF_WRITE << MASK_POS)), 0);
        return this;
    }

    /**
     * Sets the Config ID of the packet.
     *
     * @param id the id to be set
     * @return the packet itself
     */
    private ConfigPacket setConfigId(final ConfigProperty id) {
        setPayloadAt(id.value, 0);
        return this;
    }

    /**
     * Configuration Properties.
     */
    public enum ConfigProperty {
        /**
         * Restarts the node.
         */
        RESET(0, 0),
        /**
         * Network ID. Can be read/written.
         */
        MY_NET(1, 1),
        /**
         * Address of the node. Can be read/written.
         */
        MY_ADDRESS(2, 2),
        /**
         * Default Packet TTL. Can be read/written.
         */
        PACKET_TTL(3, 1),
        /**
         * Filter packets depending on RSSI. Can be read/written.
         */
        RSSI_MIN(4, 1),
        /**
         * Seconds between beacons. Can be read/written.
         */
        BEACON_PERIOD(5, 2),
        /**
         * Seconds between reports. Can be read/written.
         */
        REPORT_PERIOD(6, 2),
        /**
         * Reports between resets. Can be read/written.
         */
        RESET_PERIOD(7, 2),
        /**
         * TTL of a FlowTableEntry. Can be read/written.
         */
        RULE_TTL(8, 1),
        /**
         * Adds an alias to the list of aliases of the node. write only.
         */
        ADD_ALIAS(9, 2),
        /**
         * Removes an alias from the list of aliases of the node. write only.
         */
        REM_ALIAS(10, 1),
        /**
         * Gets an alias from the list of aliases of the node. read only.
         */
        GET_ALIAS(11, 1),
        /**
         * Adds a rule to the FlowTable of the node. write only.
         */
        ADD_RULE(12, -1),
        /**
         * Removes a rule from the FlowTable of the node. write only.
         */
        REM_RULE(13, 1),
        /**
         * Gets a rule from the FlowTable of the node. read only.
         */
        GET_RULE(14, 1),
        /**
         * Adds a function to the node. write only.
         */
        ADD_FUNCTION(15, -1),
        /**
         * Removes a function from the node. write only.
         */
        REM_FUNCTION(16, 1),
        /**
         * Gets a function from the node. read only.
         */
        GET_FUNCTION(17, 1);

        /**
         * The id of the configguration parameter.
         */
        private final byte value;

        /**
         * The size of the configuration parameter.
         */
        private final int size;

        /**
         * A byte array representation of all the possible values.
         */
        private static final ConfigProperty[] VALUES = ConfigProperty.values();

        /**
         * Creates a ConfigProperty given a byte array.
         *
         * @param value the byte array representing the config property
         * @return the config property object
         */
        public static ConfigProperty fromByte(final byte value) {
            return VALUES[value];
        }

        /**
         * Gets the size of the ConfigProperty.
         *
         * @return the size of the ConfigProperty
         */
        public int getSize() {
            return size;
        }

        /**
         * Creates a config property given a size and an id.
         *
         * @param v id of the ConfigProperty
         * @param s size of the ConfigProperty
         */
        ConfigProperty(final int v, final int s) {
            value = (byte) v;
            size = s;
        }
    }
}
