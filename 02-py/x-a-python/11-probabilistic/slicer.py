#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
from timeseries import read_data

index = 2  # Load input data
data = read_data("data_2D.txt", index)
start = "2003"  # Plot data with year-level granularity
end = "2011"
plt.figure()
data[start:end].plot()
plt.title("Input data from " + start + " to " + end)
start = "1998-2"  # Plot data with month-level granularity
end = "2006-7"
plt.figure()
data[start:end].plot()
plt.title("Input data from " + start + " to " + end)
plt.show()
