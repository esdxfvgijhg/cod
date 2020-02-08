#!/usr/bin/python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from convert_to_timeseries import convert_data_to_timeseries

input_file = "data_timeseries.txt"  # Input file containing data
data1 = convert_data_to_timeseries(input_file, 2)  # Load data
data2 = convert_data_to_timeseries(input_file, 3)
dataframe = pd.DataFrame({"first": data1, "second": data2})
print "\nMaximum:\n", dataframe.max()  # Print max and min
print "\nMinimum:\n", dataframe.min()
print "\nMean:\n", dataframe.mean()  # Print mean
print "\nMean row-wise:\n", dataframe.mean(1)[:10]
pd.rolling_mean(dataframe, window=24).plot()  # Plot rolling mean
print "\nCorrelation coefficients:\n", dataframe.corr()  # Print correlation coefficients
plt.figure()  # Plot rolling correlation
pd.rolling_corr(dataframe["first"], dataframe["second"], window=60).plot()
plt.show()
