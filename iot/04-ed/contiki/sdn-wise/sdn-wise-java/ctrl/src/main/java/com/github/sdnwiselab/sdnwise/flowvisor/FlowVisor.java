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
package com.github.sdnwiselab.sdnwise.flowvisor;

import com.github.sdnwiselab.sdnwise.adapter.AbstractAdapter;
import com.github.sdnwiselab.sdnwise.adapter.AdapterTcp;
import com.github.sdnwiselab.sdnwise.adapter.AdapterUdp;
import com.github.sdnwiselab.sdnwise.controlplane.ControlPlaneLayer;
import com.github.sdnwiselab.sdnwise.controlplane.ControlPlaneLogger;
import com.github.sdnwiselab.sdnwise.packet.DataPacket;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.DATA;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.REPORT;
import com.github.sdnwiselab.sdnwise.packet.ReportPacket;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.net.InetSocketAddress;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Observable;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class registers Nodes and Controllers of the SDN-WISE Network.
 *
 * This class is created by FlowVisorFactory. It permits Network slicing and
 * implements Runnable and the Observer pattern.
 *
 * @author Sebastiano Milardo
 */
public class FlowVisor extends ControlPlaneLayer {

    /**
     * Avoid garbage collection of the logger.
     */
    protected static final Logger LOGGER = Logger.getLogger("FLW");

    /**
     * Maps each controller to a set of nodes.
     */
    private final HashMap<InetSocketAddress, Set<NodeAddress>> controllerMapping;
    /**
     * Maps each application to a controller.
     */
    private final HashMap<InetSocketAddress, InetSocketAddress> applicationMapping;

    /**
     * Constructor for the FlowVisor. It defines Lower and Upper
     * AbstractAdapters.
     *
     * @param lower the lower adapter
     * @param upper the upper adapter
     */
    FlowVisor(final List<AbstractAdapter> lower,
            final List<AbstractAdapter> upper) {
        super("FLW", lower, upper);
        ControlPlaneLogger.setupLogger(getLayerShortName());

        controllerMapping = new HashMap<>();
        applicationMapping = new HashMap<>();
    }

    /**
     * This method permits to register a Controller to this FlowVisor and its
     * Nodes.
     *
     * @param controller Controller Identity to register
     * @param set Set of Nodes to register
     */
    public final void addController(final InetSocketAddress controller,
            final Set<NodeAddress> set) {
        controllerMapping.put(controller, set);
    }

    /**
     * This method permits to register an Application to this FlowVisor and its
     * Controller.
     *
     * @param application Application Identity to register
     * @param controller Controller Identity for the Application
     */
    public final void addApplication(final InetSocketAddress application,
            final InetSocketAddress controller) {
        applicationMapping.put(application, controller);
    }

    /**
     * Remove a Controller from this FlowVisor.
     *
     * @param controller Controller Identity to remove
     */
    public final void removeController(final InetSocketAddress controller) {
        controllerMapping.remove(controller);
    }

    /**
     * Remove an Application from this FlowVisor.
     *
     * @param application Application Identity to remove
     */
    public final void removeApplication(final InetSocketAddress application) {
        applicationMapping.remove(application);
    }

    @Override
    public final void update(final Observable o, final Object arg) {
        if (o.equals(getLower())) {
            // if it is a data packet send to the application, else send it to
            // the controller
            byte[] data = (byte[]) arg;
            NetworkPacket np = new NetworkPacket(data);
            switch (np.getTyp()) {
                case DATA:
                    manageData(data);
                    break;
                case REPORT:
                    manageReports(data);
                    break;
                default:
                    manageRequests(data);
                    break;
            }
        } else if (o.equals(getUpper())) {
            manageResponses((byte[]) arg);
        }
    }

    @Override
    public void setupLayer() {
        // Nothing to do here
    }

    /**
     * This method consists of a way to manage reports.
     *
     * @param data Byte Array contains data message
     */
    private void manageReports(final byte[] data) {
        controllerMapping.entrySet().stream().forEach((set) -> {
            ReportPacket pkt = new ReportPacket(
                    Arrays.copyOf(data, data.length));
            HashMap<NodeAddress, Byte> map = pkt.getNeighbors();
            if (set.getValue().contains(pkt.getSrc())) {
                boolean mod = false;
                final int numNeigh = pkt.getNeigborsSize();
                for (int i = 0; i < numNeigh; i++) {
                    NodeAddress tmp = pkt.getNeighborAddress(i);
                    if (!set.getValue().contains(tmp)) {
                        map.remove(tmp);
                        mod = true;
                    }
                }

                if (mod) {
                    pkt.setNeighbors(map);
                }
                ((AdapterTcp) getUpper()).open();
                ((AdapterTcp) getUpper()).send(pkt.toByteArray());
            }
        });
    }

    /**
     * This method consists of a way to manage requests.
     *
     * @param data Byte Array contains data message
     */
    private void manageRequests(final byte[] data) {
        NetworkPacket pkt = new NetworkPacket(data);
        controllerMapping.entrySet().stream().filter((set) -> (set.getValue()
                .contains(pkt.getSrc())
                && set.getValue().contains(pkt.getDst()))).map((set) -> {
            ((AdapterUdp) getUpper()).send(data, set.getKey().getAddress()
                    .getHostAddress(),
                    set.getKey().getPort());
            return set;
        }).forEach((set) -> {
            log(Level.INFO, "Sending request to " + set.getKey().getAddress()
                    + ":" + set.getKey().getPort());
        });
    }

    /**
     * Manages data packets.
     *
     * @param data a DataPacket as a byte array
     */
    private void manageData(final byte[] data) {
        DataPacket pkt = new DataPacket(data);

        applicationMapping.keySet().stream().forEach((app) -> {
            Set<NodeAddress> nodes = controllerMapping.get(applicationMapping
                    .get(app));
            if (nodes.contains(pkt.getSrc())
                    && nodes.contains(pkt.getDst())) {
                ((AdapterUdp) getUpper()).send(data, app.getAddress()
                        .getHostAddress(), app.getPort());
                log(Level.INFO, "Sending data to " + app.getAddress() + ":"
                        + app.getPort());
            }
        });
    }

    /**
     * Manages Responses from the Controller.
     *
     * @param data a Response packet as a byte array
     */
    private void manageResponses(final byte[] data) {
        log(Level.INFO, "Receiving " + Arrays.toString(data));
        getLower().stream().forEach(adp -> {
            adp.send(data);
        });
    }
}
