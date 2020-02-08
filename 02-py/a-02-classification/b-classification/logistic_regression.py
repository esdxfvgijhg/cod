#!/usr/bin/python
import numpy as np
from sklearn import linear_model
import matplotlib.pyplot as plt


def plot_classifier(classifier, X, y):
    x_min, x_max = min(X[:, 0]) - 1.0, max(X[:, 0]) + 1.0  # define ranges to plot the figure
    y_min, y_max = min(X[:, 1]) - 1.0, max(X[:, 1]) + 1.0
    step_size = 0.01  # denotes the step size that will be used in the mesh grid
    x_values, y_values = np.meshgrid(np.arange(x_min, x_max, step_size), np.arange(y_min, y_max, step_size))  # define the mesh grid
    mesh_output = classifier.predict(np.c_[x_values.ravel(), y_values.ravel()])  # compute the classifier output
    mesh_output = mesh_output.reshape(x_values.shape)  # reshape the array
    plt.figure()  # Plot the output using a colored plot
    plt.pcolormesh(x_values, y_values, mesh_output, cmap=plt.cm.gray)  # here: http://matplotlib.org/examples/color/colormaps_reference.html # choose a color scheme you can find all the options
    plt.scatter(X[:, 0], X[:, 1], c=y, s=80, edgecolors="black", linewidth=1, cmap=plt.cm.Paired)  # Overlay the training points on the plot
    plt.xlim(x_values.min(), x_values.max())  # specify the boundaries of the figure
    plt.ylim(y_values.min(), y_values.max())
    plt.xticks((np.arange(int(min(X[:, 0]) - 1), int(max(X[:, 0]) + 1), 1.0)))  # specify the ticks on the X and Y axes
    plt.yticks((np.arange(int(min(X[:, 1]) - 1), int(max(X[:, 1]) + 1), 1.0)))
    plt.show()


if __name__ == "__main__":
    X = np.array([[4, 7], [3.5, 8], [3.1, 6.2], [0.5, 1], [1, 2], [1.2, 1.9], [6, 2], [5.7, 1.5], [5.4, 2.2]])  # input data
    y = np.array([0, 0, 0, 1, 1, 1, 2, 2, 2])
    classifier = linear_model.LogisticRegression(solver="liblinear", C=100)  # initialize the logistic regression classifier
    classifier.fit(X, y)  # train the classifier
    plot_classifier(classifier, X, y)  # draw datapoints and boundaries
