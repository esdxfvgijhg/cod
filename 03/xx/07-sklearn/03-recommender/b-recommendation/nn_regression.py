#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn import neighbors

amplitude = 10  # Generate sample data
num_points = 100
X = amplitude * np.random.rand(num_points, 1) - 0.5 * amplitude
y = np.sinc(X).ravel()  # Compute target and add noise
y += 0.2 * (0.5 - np.random.rand(y.size))
plt.figure()  # Plot input data
plt.scatter(X, y, s=40, c="k", facecolors="none")
plt.title("Input data")
x_values = np.linspace(-0.5 * amplitude, 0.5 * amplitude, 10 * num_points)[:, np.newaxis]  # Create the 1D grid with 10 times the density of the input data
n_neighbors = 8  # Number of neighbors to consider
knn_regressor = neighbors.KNeighborsRegressor(n_neighbors, weights="distance")  # Define and train the regressor
y_values = knn_regressor.fit(X, y).predict(x_values)
plt.figure()
plt.scatter(X, y, s=40, c="k", facecolors="none", label="input data")
plt.plot(x_values, y_values, c="k", linestyle="--", label="predicted values")
plt.xlim(X.min() - 1, X.max() + 1)
plt.ylim(y.min() - 0.2, y.max() + 0.2)
plt.axis("tight")
plt.legend()
plt.title("K Nearest Neighbors Regressor")
plt.show()
