#!/usr/bin/python
import numpy as np
import neurolab as nl

input_file = "letter.data"  # Define the input file
num_datapoints = 50  # be loaded from the input file # Define the number of datapoints to
orig_labels = "omandig"  # String containing all the distinct characters
num_orig_labels = len(orig_labels)  # Compute the number of distinct characters
num_train = int(0.9 * num_datapoints)  # Define the training and testing parameters
num_test = num_datapoints - num_train
start = 6  # Define the dataset extraction parameters
end = -1
data = []  # Creating the dataset
labels = []
with open(input_file, "r") as f:
    for line in f.readlines():
        list_vals = line.split("\t")  # Split the current line tabwise
        if list_vals[1] not in orig_labels:  # labels. If not, we should skip it. # Check if the label is in our ground truth
            continue
        label = np.zeros((num_orig_labels, 1))  # to the main list # Extract the current label and append it
        label[orig_labels.index(list_vals[1])] = 1
        labels.append(label)
        cur_char = np.array([float(x) for x in list_vals[start:end]])  # Extract the character vector and append it to the main list
        data.append(cur_char)
        if len(data) >= num_datapoints:  # Exit the loop once the required dataset has been created
            break
data = np.asfarray(data)  # Convert the data and labels to numpy arrays
labels = np.array(labels).reshape(num_datapoints, num_orig_labels)
num_dims = len(data[0])  # Extract the number of dimensions
nn = nl.net.newff([[0, 1] for _ in range(len(data[0]))], [128, 16, num_orig_labels])  # Create a feedforward neural network
nn.trainf = nl.train.train_gd  # Set the training algorithm to gradient descent
error_progress = nn.train(data[:num_train, :], labels[:num_train, :], epochs=10000, show=100, goal=0.01)  # Train the network
print("\nTesting on unknown data:")  # Predict the output for test inputs
predicted_test = nn.sim(data[num_train:, :])
for i in range(num_test):
    print("\nOriginal:", orig_labels[np.argmax(labels[i])])
    print("Predicted:", orig_labels[np.argmax(predicted_test[i])])
