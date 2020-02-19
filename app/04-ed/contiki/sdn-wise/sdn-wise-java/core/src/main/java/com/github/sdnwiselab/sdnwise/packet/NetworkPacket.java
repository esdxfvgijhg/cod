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

import com.github.sdnwiselab.sdnwise.util.NodeAddress;

import java.io.BufferedInputStream;
import java.io.DataInputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.LinkedList;

/**
 * This class represents a generic SDN-WISE packet.
 *
 * @author Sebastiano Milardo
 */
public class NetworkPacket implements Cloneable {

    /**
     * The maximum length of a NetworkPAcket.
     */
    public static final byte MAX_PACKET_LENGTH = 116;

    /**
     * The indexes of the different fields in the packet.
     */
    public static final byte NET_INDEX = 0,
            LEN_INDEX = 1,
            DST_INDEX = 2,
            SRC_INDEX = 4,
            TYP_INDEX = 6,
            TTL_INDEX = 7,
            NXH_INDEX = 8,
            PLD_INDEX = 10;

    /**
     * The possible values of the type of a packet.
     */
    public static final byte DATA = 0,
            BEACON = 1,
            REPORT = 2,
            REQUEST = 3,
            RESPONSE = 4,
            OPEN_PATH = 5,
            CONFIG = 6,
            REG_PROXY = 7;

    /**
     * An SDN-WISE header is always 10 bytes long.
     */
    public static final byte DFLT_HDR_LEN = 10;

    /**
     * The maximum number of hops allowed in the network.
     */
    public static final byte DFLT_TTL_MAX = 100;

    /**
     * The byte array containing the packet.
     */
    private final byte[] data;

    /**
     * NET values less than 63 are SDN-WISE.
     */
    public static final byte THRES = 63;

    /**
     * Returns the index of a byte in the header given a string.
     *
     * @param b the byte name
     * @return the unsigned value of the byte
     */
    public static int getNetworkPacketByteFromName(final String b) {
        switch (b) {
            case "LEN":
                return LEN_INDEX;
            case "NET":
                return NET_INDEX;
            case "SRC":
                return SRC_INDEX;
            case "DST":
                return DST_INDEX;
            case "TYP":
                return TYP_INDEX;
            case "TTL":
                return TTL_INDEX;
            case "NXH":
                return NXH_INDEX;
            default:
                return Integer.parseInt(b);
        }
    }

    /**
     * Checks if a byte array is an SDN-WISE packet.
     *
     * @param data a byte array
     * @return a boolean depending if is an SDN-WISE packet or not
     */
    public static boolean isSdnWise(final byte[] data) {
        return (Byte.toUnsignedInt(data[NET_INDEX]) < THRES);
    }

    /**
     * Returns a string representation of a byte of the header.
     *
     * @param b an integer representing the index of a byte in the header
     * @return a string representation of a byte of the header
     */
    public static String getNetworkPacketByteName(final int b) {
        switch (b) {
            case (NET_INDEX):
                return "NET";
            case (LEN_INDEX):
                return "LEN";
            case (DST_INDEX):
                return "DST";
            case (SRC_INDEX):
                return "SRC";
            case (TYP_INDEX):
                return "TYP";
            case (TTL_INDEX):
                return "TTL";
            case (NXH_INDEX):
                return "NXH";
            default:
                return String.valueOf(b);
        }
    }

    /**
     * Returns a NetworkPacket given a byte array.
     *
     * @param d the d contained in the NetworkPacket
     */
    public NetworkPacket(final byte[] d) {
        data = new byte[MAX_PACKET_LENGTH];
        setArray(d);
    }

    /**
     * Creates an empty NetworkPacket. The TTL and LEN values are set to
     * default.
     *
     * @param net Network ID of the packet
     * @param src source address of the packet
     * @param dst destination address of the packet
     */
    public NetworkPacket(final int net, final NodeAddress src,
                         final NodeAddress dst) {
        data = new byte[MAX_PACKET_LENGTH];
        setNet((byte) net);
        setSrc(src);
        setDst(dst);
        setTtl(DFLT_TTL_MAX);
        setLen(DFLT_HDR_LEN);
    }

    /**
     * Returns a NetworkPacket given a int array. Integer values will be
     * truncated to byte.
     *
     * @param d the data contained in the NetworkPacket
     */
    public NetworkPacket(final int[] d) {
        data = new byte[MAX_PACKET_LENGTH];
        setArray(fromIntArrayToByteArray(d));
    }

    /**
     * Returns a NetworkPacket given a DataInputStream. Integer values will be
     * truncated to byte.
     *
     * @param dis the DataInputStreamt
     */
    public NetworkPacket(final DataInputStream dis) throws IOException {
        data = new byte[MAX_PACKET_LENGTH];
        byte[] tmpData = new byte[MAX_PACKET_LENGTH];
        int net = Byte.toUnsignedInt(dis.readByte());
        int len = Byte.toUnsignedInt(dis.readByte());
        if (len > 0) {
            tmpData[NET_INDEX] = (byte) net;
            tmpData[LEN_INDEX] = (byte) len;
            dis.readFully(tmpData, LEN_INDEX + 1, len - 2);

        }
        setArray(tmpData);
    }

    /**
     * Returns a NetworkPacket given a BufferedInputStream. It supports
     * streams where there could be bytes not belonging to a packet or
     * malformed packets.
     *
     * @param bis the BufferedInputStream
     */
    public NetworkPacket(final BufferedInputStream bis) throws IOException {
        data = new byte[MAX_PACKET_LENGTH];
        boolean startFlag = false;
        boolean idFlag = false;
        boolean found = false;
        int expected = 0;
        int b;
        byte a;
        final LinkedList<Byte> receivedBytes = new LinkedList<>();
        final LinkedList<Byte> packet = new LinkedList<>();
        byte startByte = 0x7A;
        byte stopByte = 0x7E;


        while (!found && (b = bis.read()) != -1) {
            receivedBytes.add((byte) b);
            while (!receivedBytes.isEmpty()) {
                a = receivedBytes.poll();
                if (!startFlag && a == startByte) {
                    startFlag = true;
                    packet.add(a);
                } else if (startFlag && !idFlag) {
                    packet.add(a);
                    idFlag = true;
                } else if (startFlag && idFlag && expected == 0) {
                    expected = Byte.toUnsignedInt(a);
                    packet.add(a);
                } else if (startFlag && idFlag && expected > 0
                        && packet.size() < expected + 1) {
                    packet.add(a);
                } else if (startFlag && idFlag && expected > 0
                        && packet.size() == expected + 1) {
                    packet.add(a);
                    if (a == stopByte) {
                        packet.removeFirst();
                        packet.removeLast();
                        byte[] tmpData = new byte[packet.size()];
                        for (int i = 0; i < tmpData.length; i++) {
                            tmpData[i] = packet.poll();
                        }
                        setArray(tmpData);
                        found = true;
                        break;
                    } else {
                        while (!packet.isEmpty()) {
                            receivedBytes.addFirst(packet.removeLast());
                        }
                        receivedBytes.poll();
                    }
                    startFlag = false;
                    idFlag = false;
                    expected = 0;
                }
            }
        }
    }

    /**
     * Fills the NetworkPacket with the content of an int array. Each element of
     * the array is casted to byte.
     *
     * @param array an array representing the packet
     */
    public final void setArray(final int[] array) {
        setArray(fromIntArrayToByteArray(array));
    }

    /**
     * Fills the NetworkPacket with the content of a byte array.
     *
     * @param array an array representing the packet
     */
    public final void setArray(final byte[] array) {
        if (isSdnWise(array)) {
            if (array.length <= MAX_PACKET_LENGTH && array.length
                    >= DFLT_HDR_LEN) {

                setLen(array[LEN_INDEX]);
                setNet(array[NET_INDEX]);
                setSrc(array[SRC_INDEX], array[SRC_INDEX + 1]);
                setDst(array[DST_INDEX], array[DST_INDEX + 1]);
                setTyp(array[TYP_INDEX]);
                setTtl(array[TTL_INDEX]);
                setNxh(array[NXH_INDEX], array[NXH_INDEX + 1]);
                setPayload(Arrays.copyOfRange(array, DFLT_HDR_LEN,
                        getLen()));
            } else {
                throw new IllegalArgumentException("Invalid array size: "
                        + array.length);
            }
        } else {
            System.arraycopy(array, 0, data, 0, array.length);
        }
    }

    /**
     * Returns the length of the message.
     *
     * @return an integer representing the length of the message
     */
    public final int getLen() {
        if (isSdnWise()) {
            return Byte.toUnsignedInt(data[LEN_INDEX]);
        } else {
            return data.length;
        }
    }

    /**
     * Sets the length of the message.
     *
     * @param value an integer representing the length of the message.
     * @return the packet itself
     */
    public final NetworkPacket setLen(final byte value) {
        int v = Byte.toUnsignedInt(value);
        if (v <= MAX_PACKET_LENGTH && v > 0) {
            data[LEN_INDEX] = value;
        } else {
            throw new IllegalArgumentException("Invalid length: " + v);
        }
        return this;
    }

    /**
     * Returns the NetworkId of the message.
     *
     * @return an integer representing the NetworkId of the message
     */
    public final int getNet() {
        return Byte.toUnsignedInt(data[NET_INDEX]);
    }

    /**
     * Sets the NetworkId of the message.
     *
     * @param value the networkId of the packet.
     * @return the packet itself
     */
    public final NetworkPacket setNet(final byte value) {
        data[NET_INDEX] = value;
        return this;
    }

    /**
     * Returns the address of the source node.
     *
     * @return the NodeAddress of the source node
     */
    public final NodeAddress getSrc() {
        return new NodeAddress(data[SRC_INDEX], data[SRC_INDEX + 1]);
    }

    /**
     * Sets the address of the source node.
     *
     * @param valueH the high byte of the address
     * @param valueL the low byte of the address
     * @return the packet itself
     */
    public final NetworkPacket setSrc(final byte valueH, final byte valueL) {
        data[SRC_INDEX] = valueH;
        data[SRC_INDEX + 1] = valueL;
        return this;
    }

    /**
     * Sets the address of the source node.
     *
     * @param address the NodeAddress of the source node.
     * @return the packet itself
     */
    public final NetworkPacket setSrc(final NodeAddress address) {
        setSrc(address.getHigh(), address.getLow());
        return this;
    }

    /**
     * Returns the address of the destination node.
     *
     * @return the NodeAddress of the destination node
     */
    public final NodeAddress getDst() {
        return new NodeAddress(data[DST_INDEX], data[DST_INDEX + 1]);
    }

    /**
     * Set the address of the destination node.
     *
     * @param valueH high value of the address of the destination
     * @param valueL low value of the address of the destination
     * @return the packet itself
     */
    public final NetworkPacket setDst(final byte valueH, final byte valueL) {
        data[DST_INDEX] = valueH;
        data[DST_INDEX + 1] = valueL;
        return this;
    }

    /**
     * Set the address of the destination node.
     *
     * @param address the NodeAddress value of the destination
     * @return the packet itself
     */
    public final NetworkPacket setDst(final NodeAddress address) {
        setDst(address.getHigh(), address.getLow());
        return this;
    }

    /**
     * Returns the type of the message.
     *
     * @return an integer representing the type of the message
     */
    public final int getTyp() {
        return data[TYP_INDEX];
    }

    /**
     * Sets the type of the message.
     *
     * @param value an integer representing the type of the message
     * @return the packet itself
     */
    public final NetworkPacket setTyp(final byte value) {
        data[TYP_INDEX] = value;
        return this;
    }

    /**
     * Returns the Time To Live of the message. When the TTL of a packet reaches
     * 0 the receiving node will drop the packet.
     *
     * @return an integer representing the Time To Live of the message
     */
    public final int getTtl() {
        return Byte.toUnsignedInt(data[TTL_INDEX]);
    }

    /**
     * Sets the Time To Live of the message. When the TTL of a packet reaches 0
     * the receiving node will drop the packet.
     *
     * @param value an integer representing the Time To Live of the message.
     * @return the packet itself
     */
    public final NetworkPacket setTtl(final byte value) {
        data[TTL_INDEX] = value;
        return this;
    }

    /**
     * Decrements the Time To Live of the message by 1. When the TTL of a packet
     * reaches 0 the receiving node will drop the packet.
     *
     * @return the packet itself
     */
    public final NetworkPacket decrementTtl() {
        if (data[TTL_INDEX] > 0) {
            data[TTL_INDEX]--;
        }
        return this;
    }

    /**
     * Returns the NodeAddress of the next hop towards the destination.
     *
     * @return the NodeAddress of the the next hop towards the destination node
     */
    public final NodeAddress getNxh() {
        return new NodeAddress(data[NXH_INDEX], data[NXH_INDEX + 1]);
    }

    /**
     * Sets the NodeAddress of the next hop towards the destination.
     *
     * @param valueH high value of the address of the next hop.
     * @param valueL low value of the address of the next hop.
     * @return packet itself.
     */
    public final NetworkPacket setNxh(final byte valueH, final byte valueL) {
        data[NXH_INDEX] = valueH;
        data[NXH_INDEX + 1] = valueL;
        return this;
    }

    /**
     * Sets the NodeAddress of the next hop towards the destination.
     *
     * @param address the NodeAddress address of the next hop.
     * @return packet itself.
     */
    public final NetworkPacket setNxh(final NodeAddress address) {
        setNxh(address.getHigh(), address.getLow());
        return this;
    }

    /**
     * Sets the NodeAddress of the next hop towards the destination.
     *
     * @param address a string representing the address of the next hop.
     * @return packet itself.
     */
    public final NetworkPacket setNxh(final String address) {
        setNxh(new NodeAddress(address));
        return this;
    }

    /**
     * Gets the payload size of the packet.
     *
     * @return the packet payload size.
     */
    public final int getPayloadSize() {
        return (getLen() - DFLT_HDR_LEN);
    }

    /**
     * Returns a String representation of the NetworkPacket.
     *
     * @return a String representation of the NetworkPacket
     */
    @Override
    public final String toString() {
        return Arrays.toString(toIntArray());
    }

    /**
     * Returns a byte array representation of the NetworkPacket.
     *
     * @return a byte array representation of the NetworkPacket
     */
    public final byte[] toByteArray() {
        return Arrays.copyOf(data, getLen());
    }

    /**
     * Returns an int array representation of the NetworkPacket.
     *
     * @return a int array representation of the NetworkPacket
     */
    public final int[] toIntArray() {
        int[] tmp = new int[getLen()];
        for (int i = 0; i < tmp.length; i++) {
            tmp[i] = Byte.toUnsignedInt(data[i]);
        }
        return tmp;
    }

    @Override
    public final NetworkPacket clone() throws CloneNotSupportedException {
        super.clone();
        return new NetworkPacket(data.clone());
    }

    /**
     * Checks if this NetworkPacket is an SDN-WISE packet.
     *
     * @return a boolean depending if is an SDN-WISE packet or not
     */
    public final boolean isSdnWise() {
        return (Byte.toUnsignedInt(data[NET_INDEX]) < THRES);
    }

    /**
     * Casts an int array to a byte array.
     *
     * @param array an int array
     * @return a byte array
     */
    private byte[] fromIntArrayToByteArray(final int[] array) {
        byte[] dataToByte = new byte[array.length];
        for (int i = 0; i < array.length; i++) {
            dataToByte[i] = (byte) array[i];
        }
        return dataToByte;
    }

    /**
     * Returns the payload of the packet as a byte array.
     *
     * @return the payload of the packet
     */
    protected final byte[] getPayload() {
        return Arrays.copyOfRange(data, DFLT_HDR_LEN,
                getLen());
    }

    /**
     * Sets the p of the packet from a byte array.
     *
     * @param p the p of the packet.
     * @return the p of the packet.
     */
    protected final NetworkPacket setPayload(final byte[] p) {
        if (p.length + DFLT_HDR_LEN <= MAX_PACKET_LENGTH) {
            System.arraycopy(p, 0, data, DFLT_HDR_LEN, p.length);
            setLen((byte) (p.length + DFLT_HDR_LEN));
        } else {
            throw new IllegalArgumentException("Payload exceeds packet size");
        }
        return this;
    }

    /**
     * Sets the payload size of the packet.
     *
     * @param size the payload size.
     * @return the packet itself
     */
    protected final NetworkPacket setPayloadSize(final int size) {
        if (DFLT_HDR_LEN + size <= MAX_PACKET_LENGTH) {
            setLen((byte) (DFLT_HDR_LEN + size));
        } else {
            throw new IllegalArgumentException("Index cannot be greater than "
                    + "the maximum payload size: " + size);
        }
        return this;
    }

    /**
     * Sets a single payload byte.
     *
     * @param i the i of the payload. The first byte of the payload is 0.
     * @param d the new data to be set.
     * @return the packet itself
     */
    protected final NetworkPacket setPayloadAt(final byte d, final int i) {
        if (DFLT_HDR_LEN + i < MAX_PACKET_LENGTH) {
            data[DFLT_HDR_LEN + i] = d;
            if ((i + DFLT_HDR_LEN) >= getLen()) {
                setLen((byte) (DFLT_HDR_LEN + i + 1));
            }
        } else {
            throw new IllegalArgumentException("Index cannot be greater than "
                    + "the maximum payload size");
        }
        return this;
    }

    /**
     * Sets a part of the payload of the NetworkPacket. Differently from
     * copyPayload this method updates also the length of the packet
     *
     * @param src        the new data to be set.
     * @param srcPos     starting from this byte of src.
     * @param payloadPos copying to this byte of payload.
     * @param length     this many bytes.
     * @return the packet itself
     */
    protected final NetworkPacket setPayload(final byte[] src,
                                             final int srcPos,
                                             final int payloadPos,
                                             final int length) {

        if (srcPos < 0 || payloadPos < 0 || length < 0) {
            throw new IllegalArgumentException("Negative index");
        } else {
            copyPayload(src, srcPos, payloadPos, length);
            setPayloadSize(length + payloadPos);
        }
        return this;
    }

    /**
     * Copy a part of the payload of the NetworkPacket. Differently from
     * copyPayload this method does not update the length of the packet
     *
     * @param src        the new data to be set.
     * @param srcPos     starting from this byte of src.
     * @param payloadPos copying to this byte of payload.
     * @param length     this many bytes.
     * @return the packet itself
     */
    protected final NetworkPacket copyPayload(final byte[] src,
                                              final int srcPos,
                                              final int payloadPos,
                                              final int length) {
        for (int i = 0; i < length; i++) {
            setPayloadAt(src[i + srcPos], i + payloadPos);
        }
        return this;
    }

    /**
     * Gets a byte from the payload of the packet at position i.
     *
     * @param i the offset of the byte.
     * @return the byte of the payload.
     */
    protected final byte getPayloadAt(final int i) {
        if (i + DFLT_HDR_LEN < getLen()) {
            return data[DFLT_HDR_LEN + i];
        } else {
            throw new IllegalArgumentException("Index cannot be greater than "
                    + "the maximum payload size");
        }
    }

    /**
     * Gets a byte array from the payload of the packet from position start to
     * position end.
     *
     * @param start starting index inclusive.
     * @param stop  stop index exclusive.
     * @return the byte of the payload.
     */
    protected final byte[] getPayloadFromTo(final int start, final int stop) {
        if (start > stop) {
            throw new IllegalArgumentException(
                    "Start must be equal or less than stop");
        }
        if (stop < 0) {
            throw new IllegalArgumentException(
                    "Stop must be greater than 0");
        }
        if (start + DFLT_HDR_LEN > getLen()) {
            throw new IllegalArgumentException(
                    "Start is greater than packet size");
        }
        int newStop = Math.min(stop + DFLT_HDR_LEN, getLen());
        return Arrays.copyOfRange(data, start + DFLT_HDR_LEN, newStop);
    }

    /**
     * Gets a part of the payload of the packet from position start, to position
     * end.
     *
     * @param start start the copy from this byte.
     * @param end   to this byte.
     * @return a byte[] part of the payload.
     */
    protected final byte[] copyPayloadOfRange(final int start, final int end) {
        return Arrays.copyOfRange(data, DFLT_HDR_LEN + start,
                DFLT_HDR_LEN + end);
    }

}
