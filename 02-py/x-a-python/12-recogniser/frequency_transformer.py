#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile

sampling_freq, signal = wavfile.read("spoken_word.wav")  # Read the audio file
signal = signal / np.power(2, 15)  # Normalize the values
len_signal = len(signal)  # Extract the length of the audio signal
len_half = np.ceil((len_signal + 1) / 2.0).astype(np.int)  # Extract the half length
freq_signal = np.fft.fft(signal)  # Apply Fourier transform
freq_signal = abs(freq_signal[0:len_half]) / len_signal  # Normalization
freq_signal **= 2  # Take the square
len_fts = len(freq_signal)  # Extract the length of the frequency transformed signal
if len_signal % 2:  # Adjust the signal for even and odd cases
    freq_signal[1:len_fts] *= 2
else:
    freq_signal[1 : len_fts - 1] *= 2
signal_power = 10 * np.log10(freq_signal)  # Extract the power value in dB
x_axis = np.arange(0, len_half, 1) * (sampling_freq / len_signal) / 1000.0  # Build the X axis
plt.figure()  # Plot the figure
plt.plot(x_axis, signal_power, color="black")
plt.xlabel("Frequency (kHz)")
plt.ylabel("Signal power (dB)")
plt.show()
