#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from scipy import signal
from sklearn.decomposition import PCA, FastICA

input_file = "mixture_of_signals.txt"  # Load data
X = np.loadtxt(input_file)
ica = FastICA(n_components=4)  # Compute ICA
signals_ica = ica.fit_transform(X)  # Reconstruct the signals
mixing_mat = ica.mixing_  # Get estimated mixing matrix
pca = PCA(n_components=4)  # Perform PCA
signals_pca = pca.fit_transform(X)  # Reconstruct signals based on orthogonal components
models = [X, signals_ica, signals_pca]  # Specify parameters for output plots
colors = ["blue", "red", "black", "green"]
plt.figure()  # Plotting input signal
plt.title("Input signal (mixture)")
for i, (sig, color) in enumerate(zip(X.T, colors), 1):
    plt.plot(sig, color=color)
plt.figure()  # Plotting ICA signals
plt.title("ICA separated signals")
plt.subplots_adjust(left=0.1, bottom=0.05, right=0.94, top=0.94, wspace=0.25, hspace=0.45)
for i, (sig, color) in enumerate(zip(signals_ica.T, colors), 1):
    plt.subplot(4, 1, i)
    plt.title("Signal " + str(i))
    plt.plot(sig, color=color)
plt.figure()  # Plotting PCA signals
plt.title("PCA separated signals")
plt.subplots_adjust(left=0.1, bottom=0.05, right=0.94, top=0.94, wspace=0.25, hspace=0.45)
for i, (sig, color) in enumerate(zip(signals_pca.T, colors), 1):
    plt.subplot(4, 1, i)
    plt.title("Signal " + str(i))
    plt.plot(sig, color=color)
plt.show()
