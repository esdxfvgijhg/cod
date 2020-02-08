#!/usr/bin/python
import random
from nltk import NaiveBayesClassifier
from nltk.classify import accuracy as nltk_accuracy
from nltk.corpus import names


def extract_features(word, N=2):  # and that will act as our "feature" # Extract last N letters from the input word
    last_n_letters = word[-N:]
    return {"feature": last_n_letters.lower()}


if __name__ == "__main__":
    male_list = [(name, "male") for name in names.words("male.txt")]  # Create training data using labeled names available in NLTK
    female_list = [(name, "female") for name in names.words("female.txt")]
    data = male_list + female_list
    random.seed(5)  # Seed the random number generator
    random.shuffle(data)  # Shuffle the data
    input_names = ["Alexander", "Danielle", "David", "Cheryl"]  # Create test data
    num_train = int(0.8 * len(data))  # Define the number of samples used for train and test
    for i in range(1, 6):  # Iterate through different lengths to compare the accuracy
        print("\nNumber of end letters:", i)
        features = [(extract_features(n, i), gender) for (n, gender) in data]
        train_data, test_data = features[:num_train], features[num_train:]
        classifier = NaiveBayesClassifier.train(train_data)
        accuracy = round(100 * nltk_accuracy(classifier, test_data), 2)  # Compute the accuracy of the classifier
        print("Accuracy = " + str(accuracy) + "%")
        for name in input_names:  # Predict outputs for input names using the trained classifier model
            print(name, "==>", classifier.classify(extract_features(name, i)))
