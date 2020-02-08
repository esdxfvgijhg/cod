#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import neurolab as nl


def get_data(num_points):
    wave_1 = 0.5 * np.sin(np.arange(0, num_points))  # Create sine waveforms
    wave_2 = 3.6 * np.sin(np.arange(0, num_points))
    wave_3 = 1.1 * np.sin(np.arange(0, num_points))
    wave_4 = 4.7 * np.sin(np.arange(0, num_points))
    amp_1 = np.ones(num_points)  # Create varying amplitudes
    amp_2 = 2.1 + np.zeros(num_points)
    amp_3 = 3.2 * np.ones(num_points)
    amp_4 = 0.8 + np.zeros(num_points)
    wave = np.array([wave_1, wave_2, wave_3, wave_4]).reshape(num_points * 4, 1)
    amp = np.array([[amp_1, amp_2, amp_3, amp_4]]).reshape(num_points * 4, 1)
    return wave, amp


def visualize_output(nn, num_points_test):  # Visualize the output
    wave, amp = get_data(num_points_test)
    output = nn.sim(wave)
    plt.plot(amp.reshape(num_points_test * 4))
    plt.plot(output.reshape(num_points_test * 4))


if __name__ == "__main__":
    num_points = 40  # Create some sample data
    wave, amp = get_data(num_points)
    nn = nl.net.newelm([[-2, 2]], [10, 1], [nl.trans.TanSig(), nl.trans.PureLin()])  # Create a recurrent neural network with 2 layers
    nn.layers[0].initf = nl.init.InitRand([-0.1, 0.1], "wb")  # Set the init functions for each layer
    nn.layers[1].initf = nl.init.InitRand([-0.1, 0.1], "wb")
    nn.init()
    error_progress = nn.train(wave, amp, epochs=1200, show=100, goal=0.01)  # Train the recurrent neural network
    output = nn.sim(wave)  # Run the training data through the network
    plt.subplot(211)  # Plot the results
    plt.plot(error_progress)
    plt.xlabel("Number of epochs")
    plt.ylabel("Error (MSE)")
    plt.subplot(212)
    plt.plot(amp.reshape(num_points * 4))
    plt.plot(output.reshape(num_points * 4))
    plt.legend(["Original", "Predicted"])
    plt.figure()  # Testing the network performance on unknown data
    plt.subplot(211)
    visualize_output(nn, 82)
    plt.xlim([0, 300])
    plt.subplot(212)
    visualize_output(nn, 49)
    plt.xlim([0, 300])
    plt.show()
