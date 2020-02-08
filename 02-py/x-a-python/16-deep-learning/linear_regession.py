#!/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt
import tensorflow as tf

num_points = 1200  # Define the number of points to generate
data = []  # Generate the data based on equation y = mx + c
m = 0.2
c = 0.5
for i in range(num_points):
    x = np.random.normal(0.0, 0.8)  # Generate 'x'
    noise = np.random.normal(0.0, 0.04)  # Generate some noise
    y = m * x + c + noise  # Compute 'y'
    data.append([x, y])
x_data = [d[0] for d in data]  # Separate x and y
y_data = [d[1] for d in data]
plt.plot(x_data, y_data, "ro")  # Plot the generated data
plt.title("Input data")
plt.show()
W = tf.Variable(tf.random_uniform([1], -1.0, 1.0))  # Generate weights and biases
b = tf.Variable(tf.zeros([1]))
y = W * x_data + b  # Define equation for 'y'
loss = tf.reduce_mean(tf.square(y - y_data))  # Define how to compute the loss
optimizer = tf.train.GradientDescentOptimizer(0.5)  # Define the gradient descent optimizer
train = optimizer.minimize(loss)
init = tf.initialize_all_variables()  # Initialize all the variables
sess = tf.Session()  # Start the tensorflow session and run it
sess.run(init)
num_iterations = 10  # Start iterating
for step in range(num_iterations):
    sess.run(train)  # Run the session
    print("\nITERATION", step + 1)  # Print the progress
    print("W =", sess.run(W)[0])
    print("b =", sess.run(b)[0])
    print("loss =", sess.run(loss))
    plt.plot(x_data, y_data, "ro")  # Plot the input data
    plt.plot(x_data, sess.run(W) * x_data + sess.run(b))  # Plot the predicted output line
    plt.xlabel("Dimension 0")  # Set plotting parameters
    plt.ylabel("Dimension 1")
    plt.title("Iteration " + str(step + 1) + " of " + str(num_iterations))
    plt.show()
