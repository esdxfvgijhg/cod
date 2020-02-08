#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy.io import wavfile
from features import mfcc, logfbank

sampling_freq, signal = wavfile.read("random_sound.wav")  # Read the input audio file
signal = signal[:10000]  # Take the first 10,000 samples for analysis
features_mfcc = mfcc(signal, sampling_freq)  # Extract the MFCC features
print("\nMFCC:\nNumber of windows =", features_mfcc.shape[0])  # Print the parameters for MFCC
print("Length of each feature =", features_mfcc.shape[1])
features_mfcc = features_mfcc.T  # Plot the features
plt.matshow(features_mfcc)
plt.title("MFCC")
features_fb = logfbank(signal, sampling_freq)  # Extract the Filter Bank features
print("\nFilter bank:\nNumber of windows =", features_fb.shape[0])  # Print the parameters for Filter Bank
print("Length of each feature =", features_fb.shape[1])
features_fb = features_fb.T  # Plot the features
plt.matshow(features_fb)
plt.title("Filter bank")
plt.show()
