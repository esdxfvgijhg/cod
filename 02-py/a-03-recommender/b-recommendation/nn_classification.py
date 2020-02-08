#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from sklearn import neighbors, datasets
from utilities import load_data

input_file = "data_nn_classifier.txt"  # Load input data
data = load_data(input_file)
X, y = data[:, :-1], data[:, -1].astype(np.int)
plt.figure()  # Plot input data
plt.title("Input datapoints")
markers = "^sov<>hp"
mapper = np.array([markers[i] for i in y])
for i in range(X.shape[0]):
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=50, edgecolors="black", facecolors="none")
num_neighbors = 10  # Number of nearest neighbors to consider
h = 0.01  # step size of the grid
classifier = neighbors.KNeighborsClassifier(num_neighbors, weights="distance")  # Create a K-Neighbours Classifier model and train it
classifier.fit(X, y)
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1  # Create the mesh to plot the boundaries
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
x_grid, y_grid = np.meshgrid(np.arange(x_min, x_max, h), np.arange(y_min, y_max, h))
predicted_values = classifier.predict(np.c_[x_grid.ravel(), y_grid.ravel()])  # Compute the outputs for all the points on the mesh
predicted_values = predicted_values.reshape(x_grid.shape)  # Put the computed results on the map
plt.figure()
plt.pcolormesh(x_grid, y_grid, predicted_values, cmap=cm.Pastel1)
for i in range(X.shape[0]):  # Overlay the training points on the map
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=50, edgecolors="black", facecolors="none")
plt.xlim(x_grid.min(), x_grid.max())
plt.ylim(y_grid.min(), y_grid.max())
plt.title("k nearest neighbors classifier boundaries")
test_datapoint = [4.5, 3.6]  # Test input datapoint
plt.figure()
plt.title("Test datapoint")
for i in range(X.shape[0]):
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=50, edgecolors="black", facecolors="none")
plt.scatter(test_datapoint[0], test_datapoint[1], marker="x", linewidth=3, s=200, facecolors="black")
dist, indices = classifier.kneighbors(test_datapoint)  # Extract k nearest neighbors
plt.figure()  # Plot k nearest neighbors
plt.title("k nearest neighbors")
for i in indices:
    plt.scatter(X[i, 0], X[i, 1], marker="o", linewidth=3, s=100, facecolors="black")
plt.scatter(test_datapoint[0], test_datapoint[1], marker="x", linewidth=3, s=200, facecolors="black")
for i in range(X.shape[0]):
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=50, edgecolors="black", facecolors="none")
print "Predicted output:", classifier.predict(test_datapoint)[0]
plt.show()
