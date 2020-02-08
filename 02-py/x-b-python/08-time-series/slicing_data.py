#!/usr/bin/python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from convert_to_timeseries import convert_data_to_timeseries

input_file = "data_timeseries.txt"  # Input file containing data
column_num = 2  # Load data
data_timeseries = convert_data_to_timeseries(input_file, column_num)
start = "2008"  # Plot within a certain year range
end = "2015"
plt.figure()
data_timeseries[start:end].plot()
plt.title("Data from " + start + " to " + end)
start = "2007-2"  # Plot within a certain range of dates
end = "2007-11"
plt.figure()
data_timeseries[start:end].plot()
plt.title("Data from " + start + " to " + end)
plt.show()
