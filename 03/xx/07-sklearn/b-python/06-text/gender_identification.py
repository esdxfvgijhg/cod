#!/usr/bin/python
import random
from nltk.corpus import names
from nltk import NaiveBayesClassifier
from nltk.classify import accuracy as nltk_accuracy


def gender_features(word, num_letters=2):  # Extract features from the input word
    return {"feature": word[-num_letters:].lower()}


if __name__ == "__main__":
    labeled_names = [(name, "male") for name in names.words("male.txt")] + [(name, "female") for name in names.words("female.txt")]  # Extract labeled names
    random.seed(7)
    random.shuffle(labeled_names)
    input_names = ["Leonardo", "Amy", "Sam"]
    for i in range(1, 5):  # Sweeping the parameter space
        print "\nNumber of letters:", i
        featuresets = [(gender_features(n, i), gender) for (n, gender) in labeled_names]
        train_set, test_set = featuresets[500:], featuresets[:500]
        classifier = NaiveBayesClassifier.train(train_set)
        print "Accuracy ==>", str(100 * nltk_accuracy(classifier, test_set)) + str("%")  # Print classifier accuracy
        for name in input_names:  # Predict outputs for new inputs
            print name, "==>", classifier.classify(gender_features(name, i))
