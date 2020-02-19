#!/usr/bin/python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from timeseries import read_data

input_file = "data_2D.txt"  # Input filename
x1 = read_data(input_file, 2)  # Load data
x2 = read_data(input_file, 3)
data = pd.DataFrame({"dim1": x1, "dim2": x2})  # Create pandas dataframe for slicing
start = "1968"  # Plot data
end = "1975"
data[start:end].plot()
plt.title("Data overlapped on top of each other")
data[(data["dim1"] < 45) & (data["dim2"] > 30)].plot()  # - 'dim2' is greater than a certain threshold # - 'dim1' is smaller than a certain threshold # Filtering using conditions
plt.title("dim1 < 45 and dim2 > 30")
plt.figure()  # Adding two dataframes
diff = data[start:end]["dim1"] + data[start:end]["dim2"]
diff.plot()
plt.title("Summation (dim1 + dim2)")
plt.show()
