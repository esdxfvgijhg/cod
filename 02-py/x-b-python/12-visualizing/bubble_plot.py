#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt

num_vals = 40  # Define the number of values
x = np.random.rand(num_vals)  # Generate random values
y = np.random.rand(num_vals)
# Max radius is set to a specified value # Define area for each bubble
max_radius = 25
area = np.pi * (max_radius * np.random.rand(num_vals)) ** 2
colors = np.random.rand(num_vals)  # Generate colors
plt.scatter(x, y, s=area, c=colors, alpha=1.0)  # Plot the points
plt.show()
