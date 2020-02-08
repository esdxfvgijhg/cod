#!/usr/bin/python
import numpy as np
from sklearn import preprocessing

label_encoder = preprocessing.LabelEncoder()
input_classes = ["audi", "ford", "audi", "toyota", "ford", "bmw"]
label_encoder.fit(input_classes)
print "\nClass mapping:"  # print classes
for i, item in enumerate(label_encoder.classes_):
    print item, "-->", i
labels = ["toyota", "ford", "audi"]  # transform a set of classes
encoded_labels = label_encoder.transform(labels)
print "\nLabels =", labels
print "Encoded labels =", list(encoded_labels)
encoded_labels = [2, 1, 0, 3, 1]  # inverse transform
decoded_labels = label_encoder.inverse_transform(encoded_labels)
print "\nEncoded labels =", encoded_labels
print "Decoded labels =", list(decoded_labels)
