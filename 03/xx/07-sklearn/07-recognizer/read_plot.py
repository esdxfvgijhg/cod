#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile

sampling_freq, audio = wavfile.read("input_read.wav")  # Read the input file
print "\nShape:", audio.shape  # Print the params
print "Datatype:", audio.dtype
print "Duration:", round(audio.shape[0] / float(sampling_freq), 3), "seconds"
audio = audio / (2.0 ** 15)  # Normalize the values
audio = audio[:30]  # Extract first 30 values for plotting
x_values = np.arange(0, len(audio), 1) / float(sampling_freq)  # Build the time axis
x_values *= 1000  # Convert to seconds
plt.plot(x_values, audio, color="black")  # Plotting the chopped audio signal
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Audio signal")
plt.show()
