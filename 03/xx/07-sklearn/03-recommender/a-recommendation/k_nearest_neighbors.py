#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.neighbors import NearestNeighbors

X = np.array([[2.1, 1.3], [1.3, 3.2], [2.9, 2.5], [2.7, 5.4], [3.8, 0.9], [7.3, 2.1], [4.2, 6.5], [3.8, 3.7], [2.5, 4.1], [3.4, 1.9], [5.7, 3.5], [6.1, 4.3], [5.1, 2.2], [6.2, 1.1]])  # Input data
k = 5  # Number of nearest neighbors
test_datapoint = [4.3, 2.7]  # Test datapoint
plt.figure()  # Plot input data
plt.title("Input data")
plt.scatter(X[:, 0], X[:, 1], marker="o", s=75, color="black")
knn_model = NearestNeighbors(n_neighbors=k, algorithm="ball_tree").fit(X)  # Build K Nearest Neighbors model
distances, indices = knn_model.kneighbors([test_datapoint])
print("\nK Nearest Neighbors:")  # Print the 'k' nearest neighbors
for rank, index in enumerate(indices[0][:k], start=1):
    print(str(rank) + " ==>", X[index])
plt.figure()  # Visualize the nearest neighbors along with the test datapoint
plt.title("Nearest neighbors")
plt.scatter(X[:, 0], X[:, 1], marker="o", s=75, color="k")
plt.scatter(X[indices][0][:][:, 0], X[indices][0][:][:, 1], marker="o", s=250, color="k", facecolors="none")
plt.scatter(test_datapoint[0], test_datapoint[1], marker="x", s=75, color="k")
plt.show()
