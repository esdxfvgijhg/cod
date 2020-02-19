#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl

text = np.loadtxt("data_perceptron.txt")  # Load input data
data = text[:, :2]  # Separate datapoints and labels
labels = text[:, 2].reshape((text.shape[0], 1))
plt.figure()  # Plot input data
plt.scatter(data[:, 0], data[:, 1])
plt.xlabel("Dimension 1")
plt.ylabel("Dimension 2")
plt.title("Input data")
dim1_min, dim1_max, dim2_min, dim2_max = 0, 1, 0, 1  # Define minimum and maximum values for each dimension
num_output = labels.shape[1]  # Number of neurons in the output layer
dim1 = [dim1_min, dim1_max]  # have 2 dimensions in the input data) # Define a perceptron with 2 input neurons (because we
dim2 = [dim2_min, dim2_max]
perceptron = nl.net.newp([dim1, dim2], num_output)
error_progress = perceptron.train(data, labels, epochs=100, show=20, lr=0.03)  # Train the perceptron using the data
plt.figure()  # Plot the training progress
plt.plot(error_progress)
plt.xlabel("Number of epochs")
plt.ylabel("Training error")
plt.title("Training error progress")
plt.grid()
plt.show()
