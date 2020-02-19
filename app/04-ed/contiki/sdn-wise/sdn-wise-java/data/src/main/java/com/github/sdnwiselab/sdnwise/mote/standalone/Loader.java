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
package com.github.sdnwiselab.sdnwise.mote.standalone;

import com.github.sdnwiselab.sdnwise.util.NodeAddress;
import java.net.InetSocketAddress;
import org.apache.commons.cli.CommandLine;
import org.apache.commons.cli.CommandLineParser;
import org.apache.commons.cli.DefaultParser;
import org.apache.commons.cli.HelpFormatter;
import org.apache.commons.cli.Option;
import org.apache.commons.cli.Options;
import org.apache.commons.cli.ParseException;

/**
 * Representation of a command line parser that instanciate an SDN-WISE node.
 *
 * @author Sebastiano Milardo
 */
public final class Loader {

    /**
     * This is a util class. No public constructor.
     */
    private Loader() {
        // Nothing to do here
    }

    /**
     * @param args the command line arguments
     */
    public static void main(final String[] args) {
        Options options = new Options();
        options.addOption(Option.builder("n").argName("net").hasArg().required()
                .desc("Network ID of the node").numberOfArgs(1).build());
        options.addOption(Option.builder("a").argName("address").hasArg()
                .required().desc("Address of the node <0-65535>")
                .numberOfArgs(1).build());
        options.addOption(Option.builder("p").argName("port").hasArg()
                .required().desc("Listening UDP port").numberOfArgs(1).build());
        options.addOption(Option.builder("t").argName("filename").hasArg()
                .required().desc("Use given file for neighbors discovery")
                .numberOfArgs(1).build());
        options.addOption(Option.builder("c").argName("ip:port").hasArg()
                .desc("IP address and TCP port of the controller. (SINK ONLY)")
                .numberOfArgs(1).build());
        options.addOption(Option.builder("sp").argName("port").hasArg()
                .desc("Port number of the switch. (SINK ONLY)")
                .numberOfArgs(1).build());
        options.addOption(Option.builder("sm").argName("mac").hasArg()
                .desc("MAC address of the switch. Example: <00:00:00:00:00:00>."
                        + " (SINK ONLY)")
                .numberOfArgs(1).build());
        options.addOption(Option.builder("sd").argName("dpid").hasArg()
                .desc("DPID of the switch (SINK ONLY)")
                .numberOfArgs(1).build());
        options.addOption(Option.builder("l").argName("level").hasArg()
                .desc("Use given log level. Values: SEVERE, WARNING, INFO, "
                        + "CONFIG, FINE, FINER, FINEST.")
                .numberOfArgs(1).optionalArg(true).build());

        // create the parser
        CommandLineParser parser = new DefaultParser();
        try {
            CommandLine line = parser.parse(options, args);
            Thread th;

            byte cmdNet = (byte) Integer.parseInt(line.getOptionValue("n"));
            NodeAddress cmdAddress = new NodeAddress(Integer.parseInt(
                    line.getOptionValue("a")));
            int cmdPort = Integer.parseInt(line.getOptionValue("p"));
            String cmdTopo = line.getOptionValue("t");

            String cmdLevel;

            if (!line.hasOption("l")) {
                cmdLevel = "SEVERE";
            } else {
                cmdLevel = line.getOptionValue("l");
            }

            if (line.hasOption("c")) {

                if (!line.hasOption("sd")) {
                    throw new ParseException("-sd option missing");
                }
                if (!line.hasOption("sp")) {
                    throw new ParseException("-sp option missing");
                }
                if (!line.hasOption("sm")) {
                    throw new ParseException("-sm option missing");
                }

                String cmdSDpid = line.getOptionValue("sd");
                String cmdSMac = line.getOptionValue("sm");
                long cmdSPort = Long.parseLong(line.getOptionValue("sp"));
                String[] ipport = line.getOptionValue("c").split(":");
                th = new Thread(new Sink(cmdNet, cmdAddress, cmdPort,
                        new InetSocketAddress(ipport[0], Integer
                                .parseInt(ipport[1])), cmdTopo, cmdLevel,
                        cmdSDpid, cmdSMac, cmdSPort));
            } else {
                th = new Thread(new Mote(cmdNet, cmdAddress, cmdPort, cmdTopo,
                        cmdLevel));
            }
            th.start();
            th.join();
        } catch (InterruptedException | ParseException ex) {
            System.out.println("Parsing failed.  Reason: " + ex.getMessage());
            HelpFormatter formatter = new HelpFormatter();
            formatter.printHelp("sdn-wise-data -n id -a address -p port"
                    + " -t filename [-l level] [-sd dpid -sm mac -sp port]",
                    options);
        }
    }
}
