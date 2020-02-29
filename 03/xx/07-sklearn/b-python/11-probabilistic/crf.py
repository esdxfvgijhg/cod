#!/usr/bin/python
import os
import argparse
import string
import pickle
import numpy as np
import matplotlib.pyplot as plt
from pystruct.datasets import load_letters
from pystruct.models import ChainCRF
from pystruct.learners import FrankWolfeSSVM


def build_arg_parser():
    parser = argparse.ArgumentParser(description="Trains a Conditional Random Field classifier")
    parser.add_argument("--C", dest="c_val", required=False, type=float, default=1.0, help="C value to be used for training")
    return parser


class CRFModel(object):  # Class to model the CRF
    def __init__(self, c_val=1.0):
        self.clf = FrankWolfeSSVM(model=ChainCRF(), C=c_val, max_iter=50)

    def load_data(self):  # Load the training data
        alphabets = load_letters()
        X = np.array(alphabets["data"])
        y = np.array(alphabets["labels"])
        folds = alphabets["folds"]
        return X, y, folds

    def train(self, X_train, y_train):  # Train the CRF
        self.clf.fit(X_train, y_train)

    def evaluate(self, X_test, y_test):  # Evaluate the accuracy of the CRF
        return self.clf.score(X_test, y_test)

    def classify(self, input_data):  # Run the CRF on unknown data
        return self.clf.predict(input_data)[0]


def convert_to_letters(indices):  # Convert indices to alphabets
    alphabets = np.array(list(string.ascii_lowercase))  # Create a numpy array of all alphabets
    output = np.take(alphabets, indices)  # Extract the letters based on input indices
    output = "".join(output)
    return output


if __name__ == "__main__":
    args = build_arg_parser().parse_args()
    c_val = args.c_val
    crf = CRFModel(c_val)  # Create the CRF model
    X, y, folds = crf.load_data()  # Load the train and test data
    X_train, X_test = X[folds == 1], X[folds != 1]
    y_train, y_test = y[folds == 1], y[folds != 1]
    print("\nTraining the CRF model...")  # Train the CRF model
    crf.train(X_train, y_train)
    score = crf.evaluate(X_test, y_test)  # Evaluate the accuracy
    print("\nAccuracy score =", str(round(score * 100, 2)) + "%")
    indices = range(3000, len(y_test), 200)
    for index in indices:
        print("\nOriginal  =", convert_to_letters(y_test[index]))
        predicted = crf.classify([X_test[index]])
        print("Predicted =", convert_to_letters(predicted))
