#!/usr/bin/python
import argparse
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data


def build_arg_parser():
    parser = argparse.ArgumentParser(description="Build a classifier using  MNIST data")
    parser.add_argument("--input-dir", dest="input_dir", type=str, default="./mnist_data", help="Directory for storing data")
    return parser


if __name__ == "__main__":
    args = build_arg_parser().parse_args()
    mnist = input_data.read_data_sets(args.input_dir, one_hot=True)  # Get the MNIST data
    x = tf.placeholder(tf.float32, [None, 784])  # with 784 neurons (28x28=784) # The images are 28x28, so create the input layer
    W = tf.Variable(tf.zeros([784, 10]))  # digits, so the output layer should have 10 classes # Create a layer with weights and biases. There are 10 distinct
    b = tf.Variable(tf.zeros([10]))
    y = tf.matmul(x, W) + b  # Create the equation for 'y' using y = W*x + b
    y_loss = tf.placeholder(tf.float32, [None, 10])  # Define the entropy loss and the gradient descent optimizer
    loss = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(y, y_loss))
    optimizer = tf.train.GradientDescentOptimizer(0.5).minimize(loss)
    init = tf.initialize_all_variables()  # Initialize all the variables
    session = tf.Session()  # Create a session
    session.run(init)
    num_iterations = 1200  # Start training
    batch_size = 90
    for _ in range(num_iterations):
        x_batch, y_batch = mnist.train.next_batch(batch_size)  # Get the next batch of images
        session.run(optimizer, feed_dict={x: x_batch, y_loss: y_batch})  # Train on this batch of images
    predicted = tf.equal(tf.argmax(y, 1), tf.argmax(y_loss, 1))  # Compute the accuracy using test data
    accuracy = tf.reduce_mean(tf.cast(predicted, tf.float32))
    print("\nAccuracy =", session.run(accuracy, feed_dict={x: mnist.test.images, y_loss: mnist.test.labels}))
