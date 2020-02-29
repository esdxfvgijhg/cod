#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt


def visualize_classifier(classifier, X, y, title=""):
    min_x, max_x = X[:, 0].min() - 1.0, X[:, 0].max() + 1.0  # that will be used in the mesh grid # Define the minimum and maximum values for X and Y
    min_y, max_y = X[:, 1].min() - 1.0, X[:, 1].max() + 1.0
    mesh_step_size = 0.01  # Define the step size to use in plotting the mesh grid
    x_vals, y_vals = np.meshgrid(np.arange(min_x, max_x, mesh_step_size), np.arange(min_y, max_y, mesh_step_size))  # Define the mesh grid of X and Y values
    output = classifier.predict(np.c_[x_vals.ravel(), y_vals.ravel()])  # Run the classifier on the mesh grid
    output = output.reshape(x_vals.shape)  # Reshape the output array
    plt.figure()  # Create a plot
    plt.title(title)  # Specify the title
    plt.pcolormesh(x_vals, y_vals, output, cmap=plt.cm.gray)  # Choose a color scheme for the plot
    plt.scatter(X[:, 0], X[:, 1], c=y, s=75, edgecolors="black", linewidth=1, cmap=plt.cm.Paired)  # Overlay the training points on the plot
    plt.xlim(x_vals.min(), x_vals.max())  # Specify the boundaries of the plot
    plt.ylim(y_vals.min(), y_vals.max())
    plt.xticks((np.arange(int(X[:, 0].min() - 1), int(X[:, 0].max() + 1), 1.0)))  # Specify the ticks on the X and Y axes
    plt.yticks((np.arange(int(X[:, 1].min() - 1), int(X[:, 1].max() + 1), 1.0)))
    plt.show()
