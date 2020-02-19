#!/usr/bin/python
import numpy as np
import neurolab as nl

input_file = "letter.data"  # Input file
num_datapoints = 20  # Number of datapoints to load from the input file
orig_labels = "omandig"  # Distinct characters
num_output = len(orig_labels)  # Number of distinct characters
num_train = int(0.9 * num_datapoints)  # Training and testing parameters
num_test = num_datapoints - num_train
start_index = 6  # Define dataset extraction parameters
end_index = -1
data = []  # Creating the dataset
labels = []
with open(input_file, "r") as f:
    for line in f.readlines():
        list_vals = line.split("\t")  # Split the line tabwise
        if list_vals[1] not in orig_labels:  # If the label is not in our ground truth labels, skip it
            continue
        label = np.zeros((num_output, 1))  # Extract the label and append it to the main list
        label[orig_labels.index(list_vals[1])] = 1
        labels.append(label)
        cur_char = np.array([float(x) for x in list_vals[start_index:end_index]])  # Extract the character vector and append it to the main list
        data.append(cur_char)
        if len(data) >= num_datapoints:  # Exit the loop once the required dataset has been loaded
            break
data = np.asfarray(data)  # Convert data and labels to numpy arrays
labels = np.array(labels).reshape(num_datapoints, num_output)
num_dims = len(data[0])  # Extract number of dimensions
net = nl.net.newff([[0, 1] for _ in range(len(data[0]))], [128, 16, num_output])  # Create and train neural network
net.trainf = nl.train.train_gd
error = net.train(data[:num_train, :], labels[:num_train, :], epochs=10000, show=100, goal=0.01)
predicted_output = net.sim(data[num_train:, :])  # Predict the output for test inputs
print "\nTesting on unknown data:"
for i in range(num_test):
    print "\nOriginal:", orig_labels[np.argmax(labels[i])]
    print "Predicted:", orig_labels[np.argmax(predicted_output[i])]
