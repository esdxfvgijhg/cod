#!/usr/bin/python
import numpy
import matplotlib.pyplot as plt
from matplotlib.mlab import csv2rec
import matplotlib.cbook as cbook
from matplotlib.ticker import Formatter


class DataFormatter(Formatter):  # Define a class for formatting
    def __init__(self, dates, date_format="%Y-%m-%d"):
        self.dates = dates
        self.date_format = date_format

    def __call__(self, t, position=0):  # Extact the value at time t at position 'position'
        index = int(round(t))
        if index >= len(self.dates) or index < 0:
            return ""
        return self.dates[index].strftime(self.date_format)


if __name__ == "__main__":
    input_file = cbook.get_sample_data("aapl.csv", asfileobj=False)  # CSV file containing the stock quotes
    data = csv2rec(input_file)  # Load csv file into numpy record array
    data = data[-70:]  # Take a subset for plotting
    formatter = DataFormatter(data.date)  # Create the date formatter object
    x_vals = numpy.arange(len(data))  # X axis
    y_vals = data.close  # Y axis values are the closing stock quotes
    fig, ax = plt.subplots()  # Plot data
    ax.xaxis.set_major_formatter(formatter)
    ax.plot(x_vals, y_vals, "o-")
    fig.autofmt_xdate()
    plt.show()
