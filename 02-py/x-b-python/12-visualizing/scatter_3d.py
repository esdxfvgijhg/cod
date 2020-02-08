#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

fig = plt.figure()  # Create the figure
ax = fig.add_subplot(111, projection="3d")
n = 250  # Define the number of values
f = lambda minval, maxval, n: minval + (maxval - minval) * np.random.rand(n)  # Create a lambda function to generate the random values in the given range
x_vals = f(15, 41, n)  # Generate the values
y_vals = f(-10, 70, n)
z_vals = f(-52, -37, n)
ax.scatter(x_vals, y_vals, z_vals, c="k", marker="o")  # Plot the values
ax.set_xlabel("X axis")
ax.set_ylabel("Y axis")
ax.set_zlabel("Z axis")
plt.show()
