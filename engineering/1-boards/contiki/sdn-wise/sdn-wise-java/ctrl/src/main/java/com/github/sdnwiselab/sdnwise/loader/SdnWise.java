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
package com.github.sdnwiselab.sdnwise.loader;

import com.github.sdnwiselab.sdnwise.adaptation.Adaptation;
import com.github.sdnwiselab.sdnwise.adaptation.AdaptationFactory;
import com.github.sdnwiselab.sdnwise.configuration.Configurator;
import com.github.sdnwiselab.sdnwise.controller.AbstractController;
import com.github.sdnwiselab.sdnwise.controller.ControllerFactory;
import com.github.sdnwiselab.sdnwise.controller.ControllerGui;
import com.github.sdnwiselab.sdnwise.flowtable.FlowTableEntry;
import com.github.sdnwiselab.sdnwise.flowvisor.FlowVisor;
import com.github.sdnwiselab.sdnwise.flowvisor.FlowVisorFactory;
import com.github.sdnwiselab.sdnwise.mote.standalone.Mote;
import com.github.sdnwiselab.sdnwise.mote.standalone.Sink;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.net.InetSocketAddress;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Starter class of the SDN-WISE project. This class loads the configuration
 * file and starts the Adaptation, the FlowVisor, and the Controller.
 *
 * @author Sebastiano Milardo
 */
public final class SdnWise {

    /**
     * Dafault config file location.
     */
    private static final String CONFIG_FILE = "/config.ini";
    /**
     * Set to true to start an emulated network.
     */
    private static final boolean EMULATED = true;
    /**
     * Emulation constants.
     */
    private static final int NO_OF_MOTES = 10,
            ADA_PORT = 9990, BASE_NODE_PORT = 7770, SETUP_TIME = 60000,
            TIMEOUT = 100;

    /**
     * Starts the components of the SDN-WISE AbstractController. An SdnWise
     * object is made of three main components: A Controller, an Adaptation, and
     * a FlowVisor. The Controller manages the requests coming from the network,
     * and creates a representation of the topology. The Adaptation adapts the
     * format of the packets coming from the nodes in order to be accepted by
     * the other components of the architecture and vice versa. The FlowVisor is
     * responsible for authenticating nodes and controllers, allowing the
     * slicing of the network.
     *
     * @param args the first argument is the path to the configuration file. if
     * not specificated, the default one is loaded
     */
    public static void main(final String[] args) {
        InputStream is = null;

        if (args.length > 0) {
            try {
                is = new FileInputStream(args[0]);
            } catch (FileNotFoundException ex) {
                Logger.getGlobal().log(Level.SEVERE, ex.toString());
            }
        } else {
            is = SdnWise.class.getResourceAsStream(CONFIG_FILE);
        }
        startExemplaryControlPlane(Configurator.load(is));
    }

    /**
     * Starts the Adaptation layer of the SDN-WISE network. The configurator
     * contains the parameters of the Adaptation layer. In particular: a "lower"
     * Adapter, in order to communicate with the Nodes and an "upper" Adapter to
     * communicate with the FlowVisor
     *
     * @param conf contains the configuration parameters for the Adaptation
     * layer
     * @return the AbstractController layer of the current SDN-WISE network
     */
    public static Adaptation startAdaptation(final Configurator conf) {
        Adaptation adaptation = AdaptationFactory.getAdaptation(conf);
        new Thread(adaptation).start();
        return adaptation;
    }

    /**
     * Starts the AbstractController layer of the SDN-WISE network. The
     * configurator class contains the configuration parameters of the
     * Controller layer. In particular: a "lower" Adapter, that specifies hoe to
     * communicate with the FlowVisor, an "algorithm" to calculate the shortest
     * path in the network. The only supported at the moment is "DIJKSTRA". A
     * "map" which contains a "TIMEOUT" value in seconds, after which a non
     * responding node is removed from the topology, a "RSSI_RESOLUTION" value
     * that triggers an event when a link rssi value changes more than this
     * threshold. "GRAPH" option that set the kind of gui used for the
     * representation of the network, the only possible values at the moment is
     * "GFX" for a GraphStream graph.
     *
     * @param conf contains the configuration parameters of the layer
     * @return the AbstractController layer of the current SDN-WISE network
     */
    public static AbstractController startController(final Configurator conf) {
        AbstractController controller = new ControllerFactory()
                .getController(conf);
        new Thread(controller).start();
        return controller;
    }

    /**
     * Creates a SDN-WISE network. This method creates a Controller, a FlowVisor
     * and an Adaptation plus a simulated network
     *
     * @param conf contains the configuration parameters for the Control plane
     */
    public static void startExemplaryControlPlane(final Configurator conf) {

        // Start the elements of the Control Plane
        // TODO depending on the order of execution the different control plane
        // may be started in different order thus the connection refused
        AbstractController controller = startController(conf);
        try {
            Thread.sleep(TIMEOUT);
        } catch (InterruptedException ex) {
            Logger.getGlobal().log(Level.SEVERE, null, ex);
        }

        //startFlowVisor(conf);
        /*
        InetSocketAddress onos = new InetSocketAddress("192.168.1.108", 9999);

        // Add the nodes IDs that will be managed
        HashSet<NodeAddress> nodeSetAll = new HashSet<>();
        for (int i = 0; i <= 128; i++) {
            nodeSetAll.add(new NodeAddress(i));
        }
        
        // Register the Controllers
        flowVisor.addController(controller.getId(), nodeSetAll);
        flowVisor.addController(onos, nodeSetAll);
         */
        try {
            Thread.sleep(TIMEOUT);
        } catch (InterruptedException ex) {
            Logger.getGlobal().log(Level.SEVERE, null, ex);
        }
        startAdaptation(conf);

        if (EMULATED) {
            startVirtualNetwork();

            // Wait for the nodes to be discovered
            try {
                Thread.sleep(SETUP_TIME);
            } catch (InterruptedException ex) {
                Logger.getGlobal().log(Level.SEVERE, null, ex);
            }

            // Some examples
            /**
             * Send an "Hello, World!" function to nodes 8 and 3 add a rule that
             * tells node 3 to execute this function when it receives a packet
             * directed to node 8.
             */
            controller.addNodeFunction(
                    (byte) 1,
                    new NodeAddress("0.8"),
                    (byte) 1,
                    "HelloWorld.class");

            controller.addNodeFunction(
                    (byte) 1,
                    new NodeAddress("0.3"),
                    (byte) 1,
                    "HelloWorld.class");

            FlowTableEntry e1 = FlowTableEntry.fromString(
                    "if (P.DST == 8) {"
                    + " FUNCTION 1 9 8 7 6 5 4;"
                    + " FORWARD_U 8;"
                    + "}");
            controller.addNodeRule((byte) 1, new NodeAddress("0.3"), e1);
        }
        // You can verify the behaviour of the node  using the GUI
        java.awt.EventQueue.invokeLater(() -> {
            new ControllerGui(controller).setVisible(true);
        });
    }

    /**
     * Starts the FlowVisor layer of the SDN-WISE network. The configurator
     * class contains the configuration parameters of the FlowVisor layer. In
     * particular: a "lower" Adapter, in order to communicate with the
     * Adaptation and an "upper" Adapter to communicate with the Controller.
     *
     * @param conf contains the configuration parameters of the layer
     * @return the AbstractController layer of the current SDN-WISE network
     */
    public static FlowVisor startFlowVisor(final Configurator conf) {
        FlowVisor flowVisor = FlowVisorFactory.getFlowvisor(conf);
        new Thread(flowVisor).start();
        return flowVisor;
    }

    /**
     * Creates a virtual Network of SDN-WISE nodes. The links between the nodes
     * are specified in each Node#.txt file in the resources directory. These
     * files contain the id of the neighbor, its ip address and port on which it
     * is listening and the rssi between the nodes. For example if in Node0.txt
     * we find 0.1,localhost,7771,215 it means that node 0.0 has 0.1 as
     * neighbor, which is listening on localhost:7771 and the rssi between 0.0
     * and 0.1 is 215.
     */
    public static void startVirtualNetwork() {
        Thread th = new Thread(new Sink(
                // its own id
                (byte) 1,
                // its own address
                new NodeAddress("0.1"),
                // listener port
                BASE_NODE_PORT + 1,
                // controller address
                new InetSocketAddress("localhost", ADA_PORT),
                // neigh file
                "Node1.txt",
                "FINEST",
                "00000001",
                "00:01:02:03:04:05",
                1)
        );
        th.start();

        for (int i = 2; i <= NO_OF_MOTES; i++) {
            new Thread(new Mote(
                    // its own id
                    (byte) 1,
                    // its own address
                    new NodeAddress(i),
                    // listener port
                    BASE_NODE_PORT + i,
                    // neigh file
                    "Node" + i + ".txt",
                    "FINEST")).start();
        }
    }

    /**
     * Private constructor.
     */
    private SdnWise() {
        // Nothing to do here
    }
}
