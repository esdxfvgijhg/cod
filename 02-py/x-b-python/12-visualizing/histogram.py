#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt

apples = [30, 25, 22, 36, 21, 29]  # Input data
oranges = [24, 33, 19, 27, 35, 20]
num_groups = len(apples)  # Number of groups
fig, ax = plt.subplots()  # Create the figure
indices = np.arange(num_groups)  # Define the X axis
bar_width = 0.4  # Width and opacity of histogram bars
opacity = 0.6
hist_apples = plt.bar(indices, apples, bar_width, alpha=opacity, color="g", label="Apples")  # Plot the values
hist_oranges = plt.bar(indices + bar_width, oranges, bar_width, alpha=opacity, color="b", label="Oranges")
plt.xlabel("Month")
plt.ylabel("Production quantity")
plt.title("Comparing apples and oranges")
plt.xticks(indices + bar_width, ("Jan", "Feb", "Mar", "Apr", "May", "Jun"))
plt.ylim([0, 45])
plt.legend()
plt.tight_layout()
plt.show()
