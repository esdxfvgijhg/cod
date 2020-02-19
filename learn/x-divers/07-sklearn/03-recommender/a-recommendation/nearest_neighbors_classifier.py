#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm
from sklearn import neighbors, datasets

input_file = "data.txt"  # Load input data
data = np.loadtxt(input_file, delimiter=",")
X, y = data[:, :-1], data[:, -1].astype(np.int)
plt.figure()  # Plot input data
plt.title("Input data")
marker_shapes = "v^os"
mapper = [marker_shapes[i] for i in y]
for i in range(X.shape[0]):
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=75, edgecolors="black", facecolors="none")
num_neighbors = 12  # Number of nearest neighbors
step_size = 0.01  # Step size of the visualization grid
classifier = neighbors.KNeighborsClassifier(num_neighbors, weights="distance")  # Create a K Nearest Neighbours classifier model
classifier.fit(X, y)  # Train the K Nearest Neighbours model
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1  # Create the mesh to plot the boundaries
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
x_values, y_values = np.meshgrid(np.arange(x_min, x_max, step_size), np.arange(y_min, y_max, step_size))
output = classifier.predict(np.c_[x_values.ravel(), y_values.ravel()])  # Evaluate the classifier on all the points on the grid
output = output.reshape(x_values.shape)  # Visualize the predicted output
plt.figure()
plt.pcolormesh(x_values, y_values, output, cmap=cm.Paired)
for i in range(X.shape[0]):  # Overlay the training points on the map
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=50, edgecolors="black", facecolors="none")
plt.xlim(x_values.min(), x_values.max())
plt.ylim(y_values.min(), y_values.max())
plt.title("K Nearest Neighbors classifier model boundaries")
test_datapoint = [5.1, 3.6]  # Test input datapoint
plt.figure()
plt.title("Test datapoint")
for i in range(X.shape[0]):
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=75, edgecolors="black", facecolors="none")
plt.scatter(test_datapoint[0], test_datapoint[1], marker="x", linewidth=6, s=200, facecolors="black")
_, indices = classifier.kneighbors([test_datapoint])  # Extract the K nearest neighbors
indices = indices.astype(np.int)[0]
plt.figure()  # Plot k nearest neighbors
plt.title("K Nearest Neighbors")
for i in indices:
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[y[i]], linewidth=3, s=100, facecolors="black")
plt.scatter(test_datapoint[0], test_datapoint[1], marker="x", linewidth=6, s=200, facecolors="black")
for i in range(X.shape[0]):
    plt.scatter(X[i, 0], X[i, 1], marker=mapper[i], s=75, edgecolors="black", facecolors="none")
print("Predicted output:", classifier.predict([test_datapoint])[0])
plt.show()
