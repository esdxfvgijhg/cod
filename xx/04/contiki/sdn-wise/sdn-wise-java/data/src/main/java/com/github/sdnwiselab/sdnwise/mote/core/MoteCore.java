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

import com.github.sdnwiselab.sdnwise.flowtable.FlowTableEntry;
import static com.github.sdnwiselab.sdnwise.flowtable.FlowTableInterface.CONST;
import static com.github.sdnwiselab.sdnwise.flowtable.FlowTableInterface.PACKET;
import com.github.sdnwiselab.sdnwise.flowtable.ForwardUnicastAction;
import com.github.sdnwiselab.sdnwise.flowtable.Window;
import static com.github.sdnwiselab.sdnwise.flowtable.Window.EQUAL;
import static com.github.sdnwiselab.sdnwise.flowtable.Window.W_SIZE_2;
import static com.github.sdnwiselab.sdnwise.flowtable.Window.fromString;
import com.github.sdnwiselab.sdnwise.mote.battery.Dischargeable;
import com.github.sdnwiselab.sdnwise.packet.BeaconPacket;
import com.github.sdnwiselab.sdnwise.packet.ConfigPacket;
import com.github.sdnwiselab.sdnwise.packet.DataPacket;
import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.DFLT_TTL_MAX;
import static com.github.sdnwiselab.sdnwise.packet.NetworkPacket.DST_INDEX;
import com.github.sdnwiselab.sdnwise.util.Neighbor;
import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.nio.charset.Charset;
import java.util.logging.Level;

/**
 * @author Sebastiano Milardo
 */
public class MoteCore extends AbstractCore {

    /**
     * Creates the core of a mote.
     *
     * @param net the network id of the mote
     * @param na the node address of the node
     * @param battery the battery of the node
     */
    public MoteCore(final byte net, final NodeAddress na,
            final Dischargeable battery) {
        super(net, na, battery);
    }

    @Override
    public final void controllerTX(final NetworkPacket np) {
        np.setNxh(getNextHopVsSink());
        radioTX(np);
    }

    @Override
    public final void dataCallback(final DataPacket dp) {
        if (getFunctions().get(1) == null) {
            log(Level.INFO, new String(dp.getData(),
                    Charset.forName("UTF-8")));
            dp.setSrc(getMyAddress())
                    .setDst(getActualSinkAddress())
                    .setTtl((byte) getRuleTtl());
            runFlowMatch(dp);
        } else {
            getFunctions().get(1).function(getSensors(),
                    getFlowTable(),
                    getNeighborTable(),
                    getStatusRegister(),
                    getAcceptedId(),
                    getFtQueue(),
                    getTxQueue(),
                    new byte[0],
                    dp);
        }
    }

    @Override
    protected final void rxBeacon(final BeaconPacket bp, final int rssi) {
        if (rssi > getRssiMin()) {
            if (bp.getDistance() < getSinkDistance()
                    && (rssi > getSinkRssi())) {
                setActive(true);
                FlowTableEntry toSink = new FlowTableEntry();
                toSink.addWindow(new Window()
                        .setOperator(EQUAL)
                        .setSize(W_SIZE_2)
                        .setLhsLocation(PACKET)
                        .setLhs(DST_INDEX)
                        .setRhsLocation(CONST)
                        .setRhs(bp.getSinkAddress().intValue()));
                toSink.addWindow(fromString("P.TYP == 3"));
                toSink.addAction(new ForwardUnicastAction(bp.getSrc()));
                getFlowTable().set(0, toSink);

                setSinkDistance(bp.getDistance() + 1);
                setSinkRssi(rssi);
            } else if ((bp.getDistance() + 1) == getSinkDistance()
                    && getNextHopVsSink().equals(bp.getSrc())) {
                getFlowTable().get(0).getStats().restoreTtl();
                getFlowTable().get(0).getWindows().get(0)
                        .setRhs(bp.getSinkAddress().intValue());
            }
            Neighbor nb = new Neighbor(bp.getSrc(), rssi, bp.getBattery());
            getNeighborTable().add(nb);
        }
    }

    @Override
    protected final void rxConfig(final ConfigPacket cp) {
        NodeAddress dest = cp.getDst();
        if (!dest.equals(getMyAddress())) {
            runFlowMatch(cp);
        } else if (execConfigPacket(cp)) {
            cp.setSrc(getMyAddress());
            cp.setDst(getActualSinkAddress());
            cp.setTtl((byte) getRuleTtl());
            runFlowMatch(cp);
        }
    }

    @Override
    protected final NodeAddress getActualSinkAddress() {
        return new NodeAddress(getFlowTable().get(0).getWindows()
                .get(0).getRhs());
    }

    @Override
    protected final void initSdnWiseSpecific() {
        reset();
    }

    @Override
    protected final void reset() {
        setSinkDistance(DFLT_TTL_MAX + 1);
        setSinkRssi(0);
        setActive(false);
    }
}
