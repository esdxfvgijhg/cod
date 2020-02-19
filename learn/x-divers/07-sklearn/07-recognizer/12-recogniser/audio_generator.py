#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import write

output_file = "generated_audio.wav"  # Output file where the audio will be saved
duration = 4  # in seconds # Specify audio parameters
sampling_freq = 44100  # in Hz
tone_freq = 784
min_val = -4 * np.pi
max_val = 4 * np.pi
t = np.linspace(min_val, max_val, duration * sampling_freq)  # Generate the audio signal
signal = np.sin(2 * np.pi * tone_freq * t)
noise = 0.5 * np.random.rand(duration * sampling_freq)  # Add some noise to the signal
signal += noise
scaling_factor = np.power(2, 15) - 1  # Scale it to 16-bit integer values
signal_normalized = signal / np.max(np.abs(signal))
signal_scaled = np.int16(signal_normalized * scaling_factor)
write(output_file, sampling_freq, signal_scaled)  # Save the audio signal in the output file
signal = signal[:200]  # Extract the first 200 values from the audio signal
time_axis = 1000 * np.arange(0, len(signal), 1) / float(sampling_freq)  # Construct the time axis in milliseconds
plt.plot(time_axis, signal, color="black")  # Plot the audio signal
plt.xlabel("Time (milliseconds)")
plt.ylabel("Amplitude")
plt.title("Generated audio signal")
plt.show()
