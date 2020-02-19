#!/usr/bin/python
import os
import argparse
import warnings
import numpy as np
from scipy.io import wavfile
from hmmlearn import hmm
from features import mfcc


def build_arg_parser():  # Define a function to parse the input arguments
    parser = argparse.ArgumentParser(description="Trains the HMM-based speech  recognition system")
    parser.add_argument("--input-folder", dest="input_folder", required=True, help="Input folder containing the audio files for training")
    return parser


class ModelHMM(object):  # Define a class to train the HMM
    def __init__(self, num_components=4, num_iter=1000):
        self.n_components = num_components
        self.n_iter = num_iter
        self.cov_type = "diag"
        self.model_name = "GaussianHMM"
        self.models = []
        self.model = hmm.GaussianHMM(n_components=self.n_components, covariance_type=self.cov_type, n_iter=self.n_iter)

    def train(self, training_data):  # 'training_data' is a 2D numpy array where each row is 13-dimensional
        np.seterr(all="ignore")
        cur_model = self.model.fit(training_data)
        self.models.append(cur_model)

    def compute_score(self, input_data):  # Run the HMM model for inference on input data
        return self.model.score(input_data)


def build_models(input_folder):  # Define a function to build a model for each word
    speech_models = []  # Initialize the variable to store all the models
    for dirname in os.listdir(input_folder):  # Parse the input directory
        subfolder = os.path.join(input_folder, dirname)  # Get the name of the subfolder
        if not os.path.isdir(subfolder):
            continue
        label = subfolder[subfolder.rfind("/") + 1 :]  # Extract the label
        X = np.array([])  # Initialize the variables
        training_files = [x for x in os.listdir(subfolder) if x.endswith(".wav")][:-1]  # We will leave one file per folder for testing # Create a list of files to be used for training
        for filename in training_files:  # Iterate through the training files and build the models
            filepath = os.path.join(subfolder, filename)  # Extract the current filepath
            sampling_freq, signal = wavfile.read(filepath)  # Read the audio signal from the input file
            with warnings.catch_warnings():  # Extract the MFCC features
                warnings.simplefilter("ignore")
                features_mfcc = mfcc(signal, sampling_freq)
            if len(X) == 0:  # Append to the variable X
                X = features_mfcc
            else:
                X = np.append(X, features_mfcc, axis=0)
        model = ModelHMM()  # Create the HMM model
        model.train(X)  # Train the HMM
        speech_models.append((model, label))  # Save the model for the current word
        model = None  # Reset the variable
    return speech_models


def run_tests(test_files):  # Define a function to run tests on input files
    for test_file in test_files:  # Classify input data
        sampling_freq, signal = wavfile.read(test_file)  # Read input file
        with warnings.catch_warnings():  # Extract MFCC features
            warnings.simplefilter("ignore")
            features_mfcc = mfcc(signal, sampling_freq)
        max_score = -float("inf")  # Define variables
        output_label = None
        for item in speech_models:  # models and pick the one with the highest score # Run the current feature vector through all the HMM
            model, label = item
            score = model.compute_score(features_mfcc)
            if score > max_score:
                max_score = score
                predicted_label = label
        start_index = test_file.find("/") + 1  # Print the predicted output
        end_index = test_file.rfind("/")
        original_label = test_file[start_index:end_index]
        print("\nOriginal: ", original_label)
        print("Predicted:", predicted_label)


if __name__ == "__main__":
    args = build_arg_parser().parse_args()
    input_folder = args.input_folder
    speech_models = build_models(input_folder)  # Build an HMM model for each word
    test_files = []  # Test files -- the 15th file in each subfolder
    for root, dirs, files in os.walk(input_folder):
        for filename in (x for x in files if "15" in x):
            filepath = os.path.join(root, filename)
            test_files.append(filepath)
    run_tests(test_files)
