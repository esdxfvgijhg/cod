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
package com.github.sdnwiselab.sdnwise.controller;

import com.github.sdnwiselab.sdnwise.flowtable.FlowTableEntry;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import com.github.sdnwiselab.sdnwise.packet.RequestPacket;
import com.github.sdnwiselab.sdnwise.topology.NetworkGraph;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.net.InetSocketAddress;
import java.util.List;
import java.util.concurrent.TimeoutException;

/**
 * @author Sebastiano Milardo
 */
public interface ControllerInterface {

    /**
     * Adds a new address in the list of addresses accepted by the node.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @param newAddr the address
     */
    void addNodeAlias(byte net, NodeAddress dst, NodeAddress newAddr);

    /**
     * Adds a new function in the list of the functions of the node.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @param id the id of the function
     * @param className the name of the class containing the function
     */
    void addNodeFunction(byte net, NodeAddress dst, byte id, String className);

    /**
     * Installs a rule in the node.
     *
     * @param net network id of the destination node.
     * @param destination network address of the destination node.
     * @param rule the rule to be installed.
     */
    void addNodeRule(byte net, NodeAddress destination, FlowTableEntry rule);

    /**
     * Reads the id of the Controller.
     *
     * @return returns an InetSocketAddress identificating the controller
     */
    InetSocketAddress getId();

    /**
     * Gets the NetworkGraph of the controller.
     *
     * @return returns a NetworkGraph object
     */
    NetworkGraph getNetworkGraph();

    /**
     * Reads the address of a node.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @return returns the NodeAddress of a node, null if it does exists.
     */
    NodeAddress getNodeAddress(byte net, NodeAddress dst);

    /**
     * Returns the list of addresses accepted by the node.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param index position of the entry in the table.
     * @return returns the list of accepted Addresses.
     */
    NodeAddress getNodeAlias(byte net, NodeAddress dst, byte index);

    /**
     * Returns the list of addresses accepted by the node.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @return returns the list of accepted Addresses.
     */
    List<NodeAddress> getNodeAliases(byte net, NodeAddress dst);

    /**
     * Reads the beacon period of a node.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @return returns the beacon period, -1 if not found
     */
    int getNodeBeaconPeriod(byte net, NodeAddress dst);

    /**
     * Reads the entry TTL of a node.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @return returns the updateTablePeriod, -1 if not found.
     */
    int getNodeEntryTtl(byte net, NodeAddress dst);

    /**
     * Reads the network ID of a node.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @return returns the nedId, -1 if not found.
     */
    int getNodeNet(byte net, NodeAddress dst);

    /**
     * Reads the maximum time to live for each message sent by a node.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @return returns the maximum time to live, -1 if not found.
     */
    int getNodePacketTtl(byte net, NodeAddress dst);

    /**
     * Reads the report period of a node.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @return returns the report period, -1 if not found
     */
    int getNodeReportPeriod(byte net, NodeAddress dst);

    /**
     * Reads the minimum RSSI in order to accept a packet.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @return returns the minimum RSSI, -1 if not found.
     */
    int getNodeRssiMin(byte net, NodeAddress dst);

    /**
     * Gets the WISE flow table entry of a node at position n.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param index position of the entry in the table.
     * @return returns the list of the entries in the WISE Flow Table.
     * @throws java.util.concurrent.TimeoutException when the timeout expires
     */
    FlowTableEntry getNodeRule(byte net, NodeAddress dst, int index) throws
            TimeoutException;

    /**
     * Gets the WISE flow table of a node.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @return returns the list of the entries in the WISE Flow Table.
     */
    List<FlowTableEntry> getNodeRules(byte net, NodeAddress dst);

    /**
     * Gets the NodeAddress of the current Sink.
     *
     * @return returns the NodeAddress of the Sink.
     */
    NodeAddress getSinkAddress();

    /**
     * Removes an address in the list of addresses accepted by the node at
     * position index.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param index the address.
     */
    void removeNodeAlias(byte net, NodeAddress dst, byte index);

    /**
     * Removes a function from the list of functions of the node at position
     * index.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param index the address.
     */
    void removeNodeFunction(byte net, NodeAddress dst, byte index);

    /**
     * Removes a rule in the node at position index.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param index index of the erased row.
     */
    void removeNodeRule(byte net, NodeAddress dst, byte index);

    /**
     * Sets the Network ID of a node. The new value is passed using a byte.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     */
    void resetNode(byte net, NodeAddress dst);

    /**
     * Sends an OpenPath message to a generic node. This kind of message holds a
     * list of nodes that will create a path inside the network.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param path the list of all the NodeAddresses in the path.
     */
    void sendPath(byte net, NodeAddress dst, List<NodeAddress> path);

    /**
     * Sets the address of a node. The new address value is passed using two
     * bytes.
     *
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param newAddress the new address.
     */
    void setNodeAddress(byte net, NodeAddress dst, NodeAddress newAddress);

    /**
     * Sets the beacon period of a node. The new value is passed using a short.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @param period beacon period in seconds
     */
    void setNodeBeaconPeriod(byte net, NodeAddress dst, short period);

    /**
     * Sets the update table period of a node. The new value is passed using a
     * short.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @param period update table period in seconds
     */
    void setNodeEntryTtl(byte net, NodeAddress dst, short period);

    /**
     * Sets the Network ID of a node. The new value is passed using a byte.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @param newNet value of the new net ID
     */
    void setNodeNet(byte net, NodeAddress dst, byte newNet);

    /**
     * Sets the maximum time to live for each message sent by a node. The new
     * value is passed using a byte.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param newTtl time to live in number of hops.
     */
    void setNodePacketTtl(byte net, NodeAddress dst, byte newTtl);

    /**
     * Sets the report period of a node. The new value is passed using a short.
     *
     * @param net network id of the destination node
     * @param dst network address of the destination node
     * @param period report period in seconds
     */
    void setNodeReportPeriod(byte net, NodeAddress dst, short period);

    /**
     * Sets the minimum RSSI in order accept a packet.
     *
     * @param net network id of the destination node.
     * @param dst network address of the destination node.
     * @param newRssi new threshold rssi value.
     */
    void setNodeRssiMin(byte net, NodeAddress dst, byte newRssi);

    /**
     * Called when the network starts. It could be used to configuration rules
     * or network at the beginning of the application.
     */
    void setupNetwork();

    /**
     * Called to update the graph of Network.
     *
     */
    void graphUpdate();

    /**
     * Manages Request packets.
     *
     * @param req the last RequestPacket containing the request
     * @param data NetworkPacket will be managed.
     */
    void manageRoutingRequest(RequestPacket req, NetworkPacket data);
}
