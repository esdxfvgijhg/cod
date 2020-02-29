#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl

input_file = "data_vq.txt"  # Define input data
input_text = np.loadtxt(input_file)
data = input_text[:, 0:2]
labels = input_text[:, 2:]
# 10 neurons in input layer and 4 neurons in output layer # Define a neural network with 2 layers:
net = nl.net.newlvq(nl.tool.minmax(data), 10, [0.25, 0.25, 0.25, 0.25])
error = net.train(data, labels, epochs=100, goal=-1)  # Train the neural network
xx, yy = np.meshgrid(np.arange(0, 8, 0.2), np.arange(0, 8, 0.2))  # Create the input grid
xx.shape = xx.size, 1
yy.shape = yy.size, 1
input_grid = np.concatenate((xx, yy), axis=1)
output_grid = net.sim(input_grid)  # Evaluate the input grid of points
class1 = data[labels[:, 0] == 1]  # Define the 4 classes
class2 = data[labels[:, 1] == 1]
class3 = data[labels[:, 2] == 1]
class4 = data[labels[:, 3] == 1]
grid1 = input_grid[output_grid[:, 0] == 1]  # Define grids for all the 4 classes
grid2 = input_grid[output_grid[:, 1] == 1]
grid3 = input_grid[output_grid[:, 2] == 1]
grid4 = input_grid[output_grid[:, 3] == 1]
plt.plot(class1[:, 0], class1[:, 1], "ko", class2[:, 0], class2[:, 1], "ko", class3[:, 0], class3[:, 1], "ko", class4[:, 0], class4[:, 1], "ko")  # Plot outputs
plt.plot(grid1[:, 0], grid1[:, 1], "b.", grid2[:, 0], grid2[:, 1], "gx", grid3[:, 0], grid3[:, 1], "cs", grid4[:, 0], grid4[:, 1], "ro")
plt.axis([0, 8, 0, 8])
plt.xlabel("X-axis")
plt.ylabel("Y-axis")
plt.title("Vector quantization using neural networks")
plt.show()
