#!/usr/bin/python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from convert_to_timeseries import convert_data_to_timeseries

input_file = "data_timeseries.txt"  # Input file containing data
data1 = convert_data_to_timeseries(input_file, 2)  # Load data
data2 = convert_data_to_timeseries(input_file, 3)
dataframe = pd.DataFrame({"first": data1, "second": data2})
dataframe["1952":"1955"].plot()  # Plot data
plt.title("Data overlapped on top of each other")
plt.figure()  # Plot the difference
difference = dataframe["1952":"1955"]["first"] - dataframe["1952":"1955"]["second"]
difference.plot()
plt.title("Difference (first - second)")
dataframe[(dataframe["first"] > 60) & (dataframe["second"] < 20)].plot()  # and 'second' is smaller than a certain threshold # When 'first' is greater than a certain threshold
plt.title("first > 60 and second < 20")
plt.show()
