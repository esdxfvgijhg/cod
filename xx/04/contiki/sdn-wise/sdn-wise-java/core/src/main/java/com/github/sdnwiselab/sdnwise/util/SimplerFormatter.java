/*
 * Copyright (C) 2015 Seby
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
package com.github.sdnwiselab.sdnwise.util;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.logging.Formatter;
import java.util.logging.LogRecord;

/**
 * Describes the format of all the logs. The format used is: HH:mm:ss [LEVEL]
 * [SOURCE] Message
 *
 * @author Sebastiano Milardo
 */
public class SimplerFormatter extends Formatter {

    /**
     * The format of the date in the log messages.
     */
    private final SimpleDateFormat formatter = new SimpleDateFormat("HH:mm:ss");
    /**
     * The name of the layer writing the log.
     */
    private final String name;

    /**
     * Creates a SimplerFormatter given a n. The n is used in the log to
     * identify the writer of the message.
     *
     * @param n the n of layer that creates the log. It is appended in the log
     * message
     */
    public SimplerFormatter(final String n) {
        name = n;
    }

    @Override
    public final String format(final LogRecord record) {
        StringBuilder sb = new StringBuilder(formatter
                .format(new Date(record.getMillis())));
        sb.append(" [").append(record.getLevel()).append("][").append(name)
                .append("] ").append(formatMessage(record));

        if (record.getThrown() != null) {
            StringWriter sw = new StringWriter();
            PrintWriter pw = new PrintWriter(sw);
            record.getThrown().printStackTrace(pw);
            sb.append(sw.toString());
        }
        return sb.append("\n").toString();
    }
}
