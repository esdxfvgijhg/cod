#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl

input_file = "data_single_layer.txt"  # Define input data
input_text = np.loadtxt(input_file)
data = input_text[:, 0:2]
labels = input_text[:, 2:]
plt.figure()  # Plot input data
plt.scatter(data[:, 0], data[:, 1])
plt.xlabel("X-axis")
plt.ylabel("Y-axis")
plt.title("Input data")
x_min, x_max = data[:, 0].min(), data[:, 0].max()  # Min and max values for each dimension
y_min, y_max = data[:, 1].min(), data[:, 1].max()
# Each element in the list (first argument) specifies the # Define a single-layer neural network with 2 neurons;
single_layer_net = nl.net.newp([[x_min, x_max], [y_min, y_max]], 2)  # min and max values of the inputs
error = single_layer_net.train(data, labels, epochs=50, show=20, lr=0.01)  # Train the neural network
plt.figure()  # Plot results
plt.plot(error)
plt.xlabel("Number of epochs")
plt.ylabel("Training error")
plt.title("Training error progress")
plt.grid()
plt.show()
print single_layer_net.sim([[0.3, 4.5]])
print single_layer_net.sim([[4.5, 0.5]])
print single_layer_net.sim([[4.3, 8]])
