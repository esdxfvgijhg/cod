#!/usr/bin/python
import numpy as np
from scipy.io import wavfile
import matplotlib.pyplot as plt

sampling_freq, audio = wavfile.read("input_freq.wav")  # Read the input file
audio = audio / (2.0 ** 15)  # Normalize the values
len_audio = len(audio)  # Extract length
transformed_signal = np.fft.fft(audio)  # Apply Fourier transform
half_length = np.ceil((len_audio + 1) / 2.0)
transformed_signal = abs(transformed_signal[0:half_length])
transformed_signal /= float(len_audio)
transformed_signal **= 2
len_ts = len(transformed_signal)  # Extract length of transformed signal
if len_audio % 2:  # Take care of even/odd cases
    transformed_signal[1:len_ts] *= 2
else:
    transformed_signal[1 : len_ts - 1] *= 2
power = 10 * np.log10(transformed_signal)  # Extract power in dB
x_values = np.arange(0, half_length, 1) * (sampling_freq / len_audio) / 1000.0  # Build the time axis
plt.figure()  # Plot the figure
plt.plot(x_values, power, color="black")
plt.xlabel("Freq (in kHz)")
plt.ylabel("Power (in dB)")
plt.show()
