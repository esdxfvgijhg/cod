#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile

sampling_freq, signal = wavfile.read("random_sound.wav")  # Read the audio file
print("\nSignal shape:", signal.shape)  # Display the params
print("Datatype:", signal.dtype)
print("Signal duration:", round(signal.shape[0] / float(sampling_freq), 2), "seconds")
signal = signal / np.power(2, 15)  # Normalize the signal
signal = signal[:50]  # Extract the first 50 values
time_axis = 1000 * np.arange(0, len(signal), 1) / float(sampling_freq)  # Construct the time axis in milliseconds
plt.plot(time_axis, signal, color="black")  # Plot the audio signal
plt.xlabel("Time (milliseconds)")
plt.ylabel("Amplitude")
plt.title("Input audio signal")
plt.show()
