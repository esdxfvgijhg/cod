#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl


def create_waveform(num_points):
    data1 = 1 * np.cos(np.arange(0, num_points))  # Create train samples
    data2 = 2 * np.cos(np.arange(0, num_points))
    data3 = 3 * np.cos(np.arange(0, num_points))
    data4 = 4 * np.cos(np.arange(0, num_points))
    amp1 = np.ones(num_points)  # Create varying amplitudes
    amp2 = 4 + np.zeros(num_points)
    amp3 = 2 * np.ones(num_points)
    amp4 = 0.5 + np.zeros(num_points)
    data = np.array([data1, data2, data3, data4]).reshape(num_points * 4, 1)
    amplitude = np.array([[amp1, amp2, amp3, amp4]]).reshape(num_points * 4, 1)
    return data, amplitude


def draw_output(net, num_points_test):  # Draw the output using the network
    data_test, amplitude_test = create_waveform(num_points_test)
    output_test = net.sim(data_test)
    plt.plot(amplitude_test.reshape(num_points_test * 4))
    plt.plot(output_test.reshape(num_points_test * 4))


if __name__ == "__main__":
    num_points = 30  # Get data
    data, amplitude = create_waveform(num_points)
    net = nl.net.newelm([[-2, 2]], [10, 1], [nl.trans.TanSig(), nl.trans.PureLin()])  # Create network with 2 layers
    net.layers[0].initf = nl.init.InitRand([-0.1, 0.1], "wb")  # Set initialized functions and init
    net.layers[1].initf = nl.init.InitRand([-0.1, 0.1], "wb")
    net.init()
    error = net.train(data, amplitude, epochs=1000, show=100, goal=0.01)  # Training the recurrent neural network
    output = net.sim(data)  # Compute output from network
    plt.subplot(211)  # Plot training results
    plt.plot(error)
    plt.xlabel("Number of epochs")
    plt.ylabel("Error (MSE)")
    plt.subplot(212)
    plt.plot(amplitude.reshape(num_points * 4))
    plt.plot(output.reshape(num_points * 4))
    plt.legend(["Ground truth", "Predicted output"])
    plt.figure()  # Testing on unknown data at multiple scales
    plt.subplot(211)
    draw_output(net, 74)
    plt.xlim([0, 300])
    plt.subplot(212)
    draw_output(net, 54)
    plt.xlim([0, 300])
    plt.show()
