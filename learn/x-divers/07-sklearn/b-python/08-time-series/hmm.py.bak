#!/usr/bin/python
import datetime
import numpy as np
import matplotlib.pyplot as plt
from hmmlearn.hmm import GaussianHMM
from convert_to_timeseries import convert_data_to_timeseries

input_file = "data_hmm.txt"  # Load data from input file
data = np.loadtxt(input_file, delimiter=",")
X = np.column_stack([data[:, 2]])  # Arrange data for training
print "\nTraining HMM...."  # Create and train Gaussian HMM
num_components = 4
model = GaussianHMM(n_components=num_components, covariance_type="diag", n_iter=1000)
model.fit(X)
hidden_states = model.predict(X)  # Predict the hidden states of HMM
print "\nMeans and variances of hidden states:"
for i in range(model.n_components):
    print "\nHidden state", i + 1
    print "Mean =", round(model.means_[i][0], 3)
    print "Variance =", round(np.diag(model.covars_[i])[0], 3)
num_samples = 1000  # Generate data using model
samples, _ = model.sample(num_samples)
plt.plot(np.arange(num_samples), samples[:, 0], c="black")
plt.title("Number of components = " + str(num_components))
plt.show()
