#!/usr/bin/python
import numpy as np
from sklearn import preprocessing

input_labels = ["red", "black", "red", "green", "black", "yellow", "white"]  # Sample input labels
encoder = preprocessing.LabelEncoder()  # Create label encoder and fit the labels
encoder.fit(input_labels)
print("\nLabel mapping:")  # Print the mapping
for i, item in enumerate(encoder.classes_):
    print(item, "-->", i)
test_labels = ["green", "red", "black"]  # Encode a set of labels using the encoder
encoded_values = encoder.transform(test_labels)
print("\nLabels =", test_labels)
print("Encoded values =", list(encoded_values))
encoded_values = [3, 0, 4, 1]  # Decode a set of values using the encoder
decoded_list = encoder.inverse_transform(encoded_values)
print("\nEncoded values =", encoded_values)
print("Decoded labels =", list(decoded_list))
