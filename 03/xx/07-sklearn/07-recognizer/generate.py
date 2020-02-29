#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.io.wavfile import write

output_file = "output_generated.wav"  # File where the output will be saved
duration = 3  # seconds # Specify audio parameters
sampling_freq = 44100  # Hz
tone_freq = 587
min_val = -2 * np.pi
max_val = 2 * np.pi
t = np.linspace(min_val, max_val, duration * sampling_freq)  # Generate audio
audio = np.sin(2 * np.pi * tone_freq * t)
noise = 0.4 * np.random.rand(duration * sampling_freq)  # Add some noise
audio += noise
scaling_factor = pow(2, 15) - 1  # Scale it to 16-bit integer values
audio_normalized = audio / np.max(np.abs(audio))
audio_scaled = np.int16(audio_normalized * scaling_factor)
write(output_file, sampling_freq, audio_scaled)  # Write to output file
audio = audio[:100]  # Extract first 100 values for plotting
x_values = np.arange(0, len(audio), 1) / float(sampling_freq)  # Build the time axis
x_values *= 1000  # Convert to seconds
plt.plot(x_values, audio, color="black")  # Plotting the chopped audio signal
plt.xlabel("Time (ms)")
plt.ylabel("Amplitude")
plt.title("Audio signal")
plt.show()
