#!/usr/bin/python
import argparse
import tensorflow as tf
from tensorflow.examples.tutorials.mnist import input_data


def build_arg_parser():
    parser = argparse.ArgumentParser(description="Build a CNN classifier  using MNIST data")
    parser.add_argument("--input-dir", dest="input_dir", type=str, default="./mnist_data", help="Directory for storing data")
    return parser


def get_weights(shape):
    data = tf.truncated_normal(shape, stddev=0.1)
    return tf.Variable(data)


def get_biases(shape):
    data = tf.constant(0.1, shape=shape)
    return tf.Variable(data)


def create_layer(shape):
    W = get_weights(shape)  # Get the weights and biases
    b = get_biases([shape[-1]])
    return W, b


def convolution_2d(x, W):
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding="SAME")


def max_pooling(x):
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1], strides=[1, 2, 2, 1], padding="SAME")


if __name__ == "__main__":
    args = build_arg_parser().parse_args()
    mnist = input_data.read_data_sets(args.input_dir, one_hot=True)  # Get the MNIST data
    x = tf.placeholder(tf.float32, [None, 784])  # with 784 neurons (28x28=784) # The images are 28x28, so create the input layer
    x_image = tf.reshape(x, [-1, 28, 28, 1])  # Reshape 'x' into a 4D tensor
    W_conv1, b_conv1 = create_layer([5, 5, 1, 32])  # Define the first convolutional layer
    h_conv1 = tf.nn.relu(convolution_2d(x_image, W_conv1) + b_conv1)  # bias, and then apply the ReLU function # Convolve the image with weight tensor, add the
    h_pool1 = max_pooling(h_conv1)  # Apply the max pooling operator
    W_conv2, b_conv2 = create_layer([5, 5, 32, 64])  # Define the second convolutional layer
    h_conv2 = tf.nn.relu(convolution_2d(h_pool1, W_conv2) + b_conv2)  # the ReLU function # weight tensor, add the bias, and then apply # Convolve the output of previous layer with the
    h_pool2 = max_pooling(h_conv2)  # Apply the max pooling operator
    W_fc1, b_fc1 = create_layer([7 * 7 * 64, 1024])  # Define the fully connected layer
    h_pool2_flat = tf.reshape(h_pool2, [-1, 7 * 7 * 64])  # Reshape the output of the previous layer
    h_fc1 = tf.nn.relu(tf.matmul(h_pool2_flat, W_fc1) + b_fc1)  # the ReLU function # weight tensor, add the bias, and then apply # Multiply the output of previous layer by the
    keep_prob = tf.placeholder(tf.float32)  # for all the neurons # Define the dropout layer using a probability placeholder
    h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)
    W_fc2, b_fc2 = create_layer([1024, 10])  # Define the readout layer (output layer)
    y_conv = tf.matmul(h_fc1_drop, W_fc2) + b_fc2
    y_loss = tf.placeholder(tf.float32, [None, 10])  # Define the entropy loss and the optimizer
    loss = tf.reduce_mean(tf.nn.softmax_cross_entropy_with_logits(y_conv, y_loss))
    optimizer = tf.train.AdamOptimizer(1e-4).minimize(loss)
    predicted = tf.equal(tf.argmax(y_conv, 1), tf.argmax(y_loss, 1))  # Define the accuracy computation
    accuracy = tf.reduce_mean(tf.cast(predicted, tf.float32))
    sess = tf.InteractiveSession()  # Create and run a session
    init = tf.initialize_all_variables()
    sess.run(init)
    num_iterations = 21000  # Start training
    batch_size = 75
    print("\nTraining the model....")
    for i in range(num_iterations):
        batch = mnist.train.next_batch(batch_size)  # Get the next batch of images
        if i % 50 == 0:  # Print progress
            cur_accuracy = accuracy.eval(feed_dict={x: batch[0], y_loss: batch[1], keep_prob: 1.0})
            print("Iteration", i, ", Accuracy =", cur_accuracy)
        optimizer.run(feed_dict={x: batch[0], y_loss: batch[1], keep_prob: 0.5})  # Train on the current batch
    print("Test accuracy =", accuracy.eval(feed_dict={x: mnist.test.images, y_loss: mnist.test.labels, keep_prob: 1.0}))  # Compute accuracy using test data
