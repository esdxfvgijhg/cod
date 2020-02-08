#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.neighbors import NearestNeighbors

X = np.array([[1, 1], [1, 3], [2, 2], [2.5, 5], [3, 1], [4, 2], [2, 3.5], [3, 3], [3.5, 4]])  # Input data
num_neighbors = 3  # Number of neighbors we want to find
input_point = [2.6, 1.7]  # Input point
plt.figure()  # Plot datapoints
plt.scatter(X[:, 0], X[:, 1], marker="o", s=25, color="k")
knn = NearestNeighbors(n_neighbors=num_neighbors, algorithm="ball_tree").fit(X)  # Build nearest neighbors model
distances, indices = knn.kneighbors(input_point)
print "\nk nearest neighbors"  # Print the 'k' nearest neighbors
for rank, index in enumerate(indices[0][:num_neighbors]):
    print str(rank + 1) + " -->", X[index]
plt.figure()  # Plot the nearest neighbors
plt.scatter(X[:, 0], X[:, 1], marker="o", s=25, color="k")
plt.scatter(X[indices][0][:][:, 0], X[indices][0][:][:, 1], marker="o", s=150, color="k", facecolors="none")
plt.scatter(input_point[0], input_point[1], marker="x", s=150, color="k", facecolors="none")
plt.show()
