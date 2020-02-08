#!/usr/bin/python
import numpy as np
import neurolab as nl
import matplotlib.pyplot as plt

data = np.array([[0.3, 0.2], [0.1, 0.4], [0.4, 0.6], [0.9, 0.5]])  # Define input data
labels = np.array([[0], [0], [0], [1]])
plt.figure()  # Plot input data
plt.scatter(data[:, 0], data[:, 1])
plt.xlabel("X-axis")
plt.ylabel("Y-axis")
plt.title("Input data")
# Each element of the list in the first argument # Define a perceptron with 2 inputs;
perceptron = nl.net.newp([[0, 1], [0, 1]], 1)  # specifies the min and max values of the inputs
error = perceptron.train(data, labels, epochs=50, show=15, lr=0.01)  # Train the perceptron
plt.figure()  # plot results
plt.plot(error)
plt.xlabel("Number of epochs")
plt.ylabel("Training error")
plt.grid()
plt.title("Training error progress")
plt.show()
