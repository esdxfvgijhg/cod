#!/usr/bin/python3
import numpy as np
from sklearn import preprocessing

input_data         = np.array([[5.1, -2.9, 3.3], [-1.2, 7.8, -6.1], [3.9, 0.4, 2.1], [7.3, -9.9, -4.5]])
data_binarized     = preprocessing.Binarizer(threshold=2.1).transform(input_data)  # Binarize data
data_scaled        = preprocessing.scale(input_data)  # Remove mean
data_scaler_minmax = preprocessing.MinMaxScaler(feature_range=(0, 1))  # Min max scaling
data_scaled_minmax = data_scaler_minmax.fit_transform(input_data)
data_normalized_l1 = preprocessing.normalize(input_data, norm="l1")  # Normalize data
data_normalized_l2 = preprocessing.normalize(input_data, norm="l2")

print("\nBinarized data:\n", data_binarized)
print("\nBEFORE:")  # Print mean and standard deviation
print("Mean =", input_data.mean(axis=0))
print("Std deviation =", input_data.std(axis=0))

print("\nAFTER:")
print("Mean =", data_scaled.mean(axis=0))
print("Std deviation =", data_scaled.std(axis=0))

print("\nMin max scaled data:\n", data_scaled_minmax)

print("\nL1 normalized data:\n", data_normalized_l1)
print("\nL2 normalized data:\n", data_normalized_l2)

