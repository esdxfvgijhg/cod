#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl

text = np.loadtxt("data_simple_nn.txt")  # Load input data
data = text[:, 0:2]  # Separate it into datapoints and labels
labels = text[:, 2:]
plt.figure()  # Plot input data
plt.scatter(data[:, 0], data[:, 1])
plt.xlabel("Dimension 1")
plt.ylabel("Dimension 2")
plt.title("Input data")
dim1_min, dim1_max = data[:, 0].min(), data[:, 0].max()  # Minimum and maximum values for each dimension
dim2_min, dim2_max = data[:, 1].min(), data[:, 1].max()
num_output = labels.shape[1]  # Define the number of neurons in the output layer
dim1 = [dim1_min, dim1_max]  # Define a single-layer neural network
dim2 = [dim2_min, dim2_max]
nn = nl.net.newp([dim1, dim2], num_output)
error_progress = nn.train(data, labels, epochs=100, show=20, lr=0.03)  # Train the neural network
plt.figure()  # Plot the training progress
plt.plot(error_progress)
plt.xlabel("Number of epochs")
plt.ylabel("Training error")
plt.title("Training error progress")
plt.grid()
plt.show()
print("\nTest results:")  # Run the classifier on test datapoints
data_test = [[0.4, 4.3], [4.4, 0.6], [4.7, 8.1]]
for item in data_test:
    print(item, "-->", nn.sim([item])[0])
