#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from timeseries import read_data

input_file = "data_2D.txt"  # Input filename
x1 = read_data(input_file, 2)  # Load input data in time series format
x2 = read_data(input_file, 3)
data = pd.DataFrame({"dim1": x1, "dim2": x2})  # Create pandas dataframe for slicing
print("\nMaximum values for each dimension:")  # Extract max and min values
print(data.max())
print("\nMinimum values for each dimension:")
print(data.min())
print("\nOverall mean:")  # Extract overall mean and row-wise mean values
print(data.mean())
print("\nRow-wise mean:")
print(data.mean(1)[:12])
data.rolling(center=False, window=24).mean().plot()  # Plot the rolling mean using a window size of 24
plt.title("Rolling mean")
print("\nCorrelation coefficients:\n", data.corr())  # Extract correlation coefficients
plt.figure()  # Plot rolling correlation using a window size of 60
plt.title("Rolling correlation")
data["dim1"].rolling(window=60).corr(other=data["dim2"]).plot()
plt.show()
