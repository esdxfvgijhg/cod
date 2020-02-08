#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt

group1 = ["France", "Italy", "Spain", "Portugal", "Germany"]  # Define the two groups
group2 = ["Japan", "China", "Brazil", "Russia", "Australia"]
data = np.random.rand(5, 5)  # Generate some random values
fig, ax = plt.subplots()  # Create a figure
heatmap = ax.pcolor(data, cmap=plt.cm.gray)  # Create the heat map
ax.set_xticks(np.arange(data.shape[0]) + 0.5, minor=False)  # Add major ticks at the middle of each cell
ax.set_yticks(np.arange(data.shape[1]) + 0.5, minor=False)
ax.invert_yaxis()  # Make it look like a table
ax.xaxis.tick_top()
ax.set_xticklabels(group2, minor=False)  # Add tick labels
ax.set_yticklabels(group1, minor=False)
plt.show()
