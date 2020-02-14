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
package com.github.sdnwiselab.sdnwise.adapter;

import com.github.sdnwiselab.sdnwise.packet.NetworkPacket;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Observable;
import java.util.Observer;
import java.util.logging.Level;

/**
 * Representation of a TCP Adapter. Configuration data are passed using a
 * {@code Map<String,String>} which contains all the options needed in the
 * constructor of the class.
 *
 * @author Sebastiano Milardo
 */
public class AdapterTcp extends AbstractAdapter {

    /**
     * Destination ip address.
     */
    private final String ip;
    /**
     * Boolean used to set the behaviour of the adapter. The adapter can act as
     * a server or a client.
     */
    private final boolean isServer;
    /**
     * TCP port of the adapter.
     */
    private final int port;
    /**
     * Manages TCP connections.
     */
    private InternalTcpElement tcpElement;

    /**
     * Creates an AdapterTCP object. The conf map is used to pass the
     * configuration settings for the TPC socket as strings. Specifically the
     * needed parameters are:
     * <ol>
     * <li>IS_SERVER</li>
     * <li>IP</li>
     * <li>PORT</li>
     * </ol>
     *
     * @param conf contains the serial port configuration data.
     */
    public AdapterTcp(final Map<String, String> conf) {
        isServer = Boolean.parseBoolean(conf.get("IS_SERVER"));
        ip = conf.get("IP");
        port = Integer.parseInt(conf.get("PORT"));
    }

    @Override
    public final boolean close() {
        tcpElement.stop();
        setActive(false);
        return true;
    }

    @Override
    public final boolean open() {
        if (!isActive()) {
            if (isServer) {
                tcpElement = new InternalTcpElementServer();
            } else {
                tcpElement = new InternalTcpElementClient();
            }
            tcpElement.addObserver(this);
            new Thread(tcpElement).start();
            setActive(true);
        }
        return true;
    }

    @Override
    public final void send(final byte[] data) {
        if (isActive()) {
            tcpElement.send(data);
        }
    }

    /**
     * Models a generic TCP network element.
     */
    private abstract class InternalTcpElement extends Observable
            implements Runnable, Observer {

        /**
         * Manages the status of the element.
         */
        private boolean isStopped;

        /**
         * Sends a byte array.
         *
         * @param data the array to be sent
         */
        public abstract void send(final byte[] data);

        /**
         * Checks if the TCP element is still running.
         *
         * @return the status of the TCP element
         */
        public synchronized boolean isStopped() {
            return isStopped;
        }

        @Override
        public final void update(final Observable o, final Object arg) {
            setChanged();
            notifyObservers(arg);
        }

        /**
         * Stops the TCP element.
         */
        public void stop() {
            isStopped = true;
        }
    }

    /**
     * Models a TCP client.
     */
    private class InternalTcpElementClient extends InternalTcpElement {

        /**
         * TCP Socket.
         */
        private Socket socket;

        @Override
        public void send(final byte[] data) {
            try {
                OutputStream out = socket.getOutputStream();
                DataOutputStream dos = new DataOutputStream(out);
                dos.write(data);
            } catch (IOException ex) {
                log(Level.SEVERE, ex.toString());
            }
        }

        @Override
        public void run() {
            try {
                socket = new Socket(ip, port);
                InputStream in = socket.getInputStream();
                DataInputStream dis = new DataInputStream(in);
                while (!isStopped()) {
                    byte[] data = new NetworkPacket(dis).toByteArray();
                    setChanged();
                    notifyObservers(data);
                }
            } catch (IOException ex) {
                log(Level.SEVERE, ex.toString());
            }

        }
    }

    /**
     * Models a TCP server.
     */
    private class InternalTcpElementServer extends InternalTcpElement {

        /**
         * TCP server socket.
         */
        private ServerSocket serverSocket = null;

        /**
         * A list of client sockets.
         */
        private final List<Socket> clientSockets = new LinkedList<>();

        /**
         * A list of removable client sockets.
         */
        private final List<Socket> removableSockets = new LinkedList<>();

        @Override
        public void run() {
            try {
                serverSocket = new ServerSocket(port);
            } catch (IOException e) {
                throw new UnsupportedOperationException("Cannot open port "
                        + port, e);
            }
            Socket clientSocket;
            while (!isStopped()) {
                try {
                    clientSocket = serverSocket.accept();
                } catch (IOException e) {
                    if (isStopped()) {
                        return;
                    }
                    throw new UnsupportedOperationException(
                            "Error accepting client connection", e);
                }
                clientSockets.add(clientSocket);
                WorkerRunnable wr = new WorkerRunnable(clientSocket);
                wr.addObserver(this);
                new Thread(wr).start();
            }
        }

        @Override
        public synchronized void stop() {
            super.stop();
            try {
                serverSocket.close();
            } catch (IOException e) {
                throw new UnsupportedOperationException(
                        "Error closing server", e);
            }
        }

        @Override
        public void send(final byte[] data) {
            clientSockets.stream().forEach((sck) -> {
                try {
                    OutputStream out = sck.getOutputStream();
                    DataOutputStream dos = new DataOutputStream(out);
                    dos.write(data);
                } catch (IOException ex) {
                    log(Level.SEVERE, ex.toString());
                    removableSockets.add(sck);
                }
            });

            if (!removableSockets.isEmpty()) {
                clientSockets.removeAll(removableSockets);
                removableSockets.clear();
            }
        }

        /**
         * Notifies the observes that a new packet has arrived.
         */
        private class WorkerRunnable extends Observable implements Runnable {

            /**
             * Reference to the clientSocket.
             */
            private final Socket clientSocket;

            /**
             * Creates a new WorkerRunnable given a clientSocket.
             *
             * @param socket the clientSocket
             */
            WorkerRunnable(final Socket socket) {
                clientSocket = socket;
            }

            @Override
            public void run() {
                try {
                    InputStream in = clientSocket.getInputStream();
                    DataInputStream dis = new DataInputStream(in);
                    while (!isStopped()) {
                        byte[] data = new NetworkPacket(dis).toByteArray();
                        setChanged();
                        notifyObservers(data);
                    }
                } catch (IOException ex) {
                    log(Level.SEVERE, ex.toString());
                }
            }
        }
    }
}
