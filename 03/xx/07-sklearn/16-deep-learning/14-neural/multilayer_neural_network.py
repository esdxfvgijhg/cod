#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl

min_val = -15  # Generate some training data
max_val = 15
num_points = 130
x = np.linspace(min_val, max_val, num_points)
y = 3 * np.square(x) + 5
y /= np.linalg.norm(y)
data = x.reshape(num_points, 1)  # Create data and labels
labels = y.reshape(num_points, 1)
plt.figure()  # Plot input data
plt.scatter(data, labels)
plt.xlabel("Dimension 1")
plt.ylabel("Dimension 2")
plt.title("Input data")
# Output layer consists of 1 neuron # Second hidden layer consists of 6 neurons # First hidden layer consists of 10 neurons # Define a multilayer neural network with 2 hidden layers;
nn = nl.net.newff([[min_val, max_val]], [10, 6, 1])
nn.trainf = nl.train.train_gd  # Set the training algorithm to gradient descent
error_progress = nn.train(data, labels, epochs=2000, show=100, goal=0.01)  # Train the neural network
output = nn.sim(data)  # Run the neural network on training datapoints
y_pred = output.reshape(num_points)
plt.figure()  # Plot training error
plt.plot(error_progress)
plt.xlabel("Number of epochs")
plt.ylabel("Error")
plt.title("Training error progress")
x_dense = np.linspace(min_val, max_val, num_points * 2)  # Plot the output
y_dense_pred = nn.sim(x_dense.reshape(x_dense.size, 1)).reshape(x_dense.size)
plt.figure()
plt.plot(x_dense, y_dense_pred, "-", x, y, ".", x, y_pred, "p")
plt.title("Actual vs predicted")
plt.show()
