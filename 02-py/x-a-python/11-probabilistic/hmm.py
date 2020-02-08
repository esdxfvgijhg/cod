#!/usr/bin/python
import datetime
import numpy as np
import matplotlib.pyplot as plt
from hmmlearn.hmm import GaussianHMM
from timeseries import read_data

data = np.loadtxt("data_1D.txt", delimiter=",")  # Load input data
X = np.column_stack([data[:, 2]])  # Extract the data column (third column) for training
num_components = 5  # Create a Gaussian HMM
hmm = GaussianHMM(n_components=num_components, covariance_type="diag", n_iter=1000)
print("\nTraining the Hidden Markov Model...")  # Train the HMM
hmm.fit(X)
print("\nMeans and variances:")  # Print HMM stats
for i in range(hmm.n_components):
    print("\nHidden state", i + 1)
    print("Mean =", round(hmm.means_[i][0], 2))
    print("Variance =", round(np.diag(hmm.covars_[i])[0], 2))
num_samples = 1200  # Generate data using the HMM model
generated_data, _ = hmm.sample(num_samples)
plt.plot(np.arange(num_samples), generated_data[:, 0], c="black")
plt.title("Generated data")
plt.show()
