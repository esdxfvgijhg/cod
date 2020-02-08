#!/usr/bin/python
import os
import argparse
import numpy as np
from scipy.io import wavfile
from hmmlearn import hmm
from features import mfcc


def build_arg_parser():  # Function to parse input arguments
    parser = argparse.ArgumentParser(description="Trains the HMM classifier")
    parser.add_argument("--input-folder", dest="input_folder", required=True, help="Input folder containing the audio files in subfolders")
    return parser


class HMMTrainer(object):  # Class to handle all HMM related processing
    def __init__(self, model_name="GaussianHMM", n_components=4, cov_type="diag", n_iter=1000):
        self.model_name = model_name
        self.n_components = n_components
        self.cov_type = cov_type
        self.n_iter = n_iter
        self.models = []
        if self.model_name == "GaussianHMM":
            self.model = hmm.GaussianHMM(n_components=self.n_components, covariance_type=self.cov_type, n_iter=self.n_iter)
        else:
            raise TypeError("Invalid model type")

    def train(self, X):  # X is a 2D numpy array where each row is 13D
        np.seterr(all="ignore")
        self.models.append(self.model.fit(X))

    def get_score(self, input_data):  # Run the model on input data
        return self.model.score(input_data)


if __name__ == "__main__":
    args = build_arg_parser().parse_args()
    input_folder = args.input_folder
    hmm_models = []
    for dirname in os.listdir(input_folder):  # Parse the input directory
        subfolder = os.path.join(input_folder, dirname)  # Get the name of the subfolder
        if not os.path.isdir(subfolder):
            continue
        label = subfolder[subfolder.rfind("/") + 1 :]  # Extract the label
        X = np.array([])  # Initialize variables
        y_words = []
        for filename in [x for x in os.listdir(subfolder) if x.endswith(".wav")][:-1]:  # Iterate through the audio files (leaving 1 file for testing in each class)
            filepath = os.path.join(subfolder, filename)  # Read the input file
            sampling_freq, audio = wavfile.read(filepath)
            mfcc_features = mfcc(audio, sampling_freq)  # Extract MFCC features
            if len(X) == 0:  # Append to the variable X
                X = mfcc_features
            else:
                X = np.append(X, mfcc_features, axis=0)
            y_words.append(label)  # Append the label
        print "X.shape =", X.shape
        hmm_trainer = HMMTrainer()  # Train and save HMM model
        hmm_trainer.train(X)
        hmm_models.append((hmm_trainer, label))
        hmm_trainer = None
    input_files = ["data/pineapple/pineapple15.wav", "data/orange/orange15.wav", "data/apple/apple15.wav", "data/kiwi/kiwi15.wav"]  # Test files
    for input_file in input_files:  # Classify input data
        sampling_freq, audio = wavfile.read(input_file)  # Read input file
        mfcc_features = mfcc(audio, sampling_freq)  # Extract MFCC features
        max_score = None  # Define variables
        output_label = None
        for item in hmm_models:  # the one with the highest score # Iterate through all HMM models and pick
            hmm_model, label = item
            score = hmm_model.get_score(mfcc_features)
            if score > max_score:
                max_score = score
                output_label = label
        print "\nTrue:", input_file[input_file.find("/") + 1 : input_file.rfind("/")]  # Print the output
        print "Predicted:", output_label
