#!/usr/bin/python
import argparse
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import classification_report
from sklearn import model_selection
from sklearn.ensemble import RandomForestClassifier, ExtraTreesClassifier
from sklearn import model_selection
from sklearn.metrics import classification_report
from utilities import visualize_classifier


def build_arg_parser():  # Argument parser
    parser = argparse.ArgumentParser(description="Classify data using  Ensemble Learning techniques")
    parser.add_argument("--classifier-type", dest="classifier_type", required=True, choices=["rf", "erf"], help="Type of classifier  to use; can be either 'rf' or 'erf'")
    return parser


if __name__ == "__main__":
    args = build_arg_parser().parse_args()  # Parse the input arguments
    classifier_type = args.classifier_type
    input_file = "data_random_forests.txt"  # Load input data
    data = np.loadtxt(input_file, delimiter=",")
    X, y = data[:, :-1], data[:, -1]
    class_0 = np.array(X[y == 0])  # Separate input data into three classes based on labels
    class_1 = np.array(X[y == 1])
    class_2 = np.array(X[y == 2])
    plt.figure()  # Visualize input data
    plt.scatter(class_0[:, 0], class_0[:, 1], s=75, facecolors="white", edgecolors="black", linewidth=1, marker="s")
    plt.scatter(class_1[:, 0], class_1[:, 1], s=75, facecolors="white", edgecolors="black", linewidth=1, marker="o")
    plt.scatter(class_2[:, 0], class_2[:, 1], s=75, facecolors="white", edgecolors="black", linewidth=1, marker="^")
    plt.title("Input data")
    X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.25, random_state=5)  # Split data into training and testing datasets
    params = {"n_estimators": 100, "max_depth": 4, "random_state": 0}  # Ensemble Learning classifier
    if classifier_type == "rf":
        classifier = RandomForestClassifier(**params)
    else:
        classifier = ExtraTreesClassifier(**params)
    classifier.fit(X_train, y_train)
    visualize_classifier(classifier, X_train, y_train, "Training dataset")
    y_test_pred = classifier.predict(X_test)
    visualize_classifier(classifier, X_test, y_test, "Test dataset")
    class_names = ["Class-0", "Class-1", "Class-2"]  # Evaluate classifier performance
    print("\n" + "#" * 40)
    print("\nClassifier performance on training dataset\n")
    print(classification_report(y_train, classifier.predict(X_train), target_names=class_names))
    print("#" * 40 + "\n")
    print("#" * 40)
    print("\nClassifier performance on test dataset\n")
    print(classification_report(y_test, y_test_pred, target_names=class_names))
    print("#" * 40 + "\n")
    test_datapoints = np.array([[5, 5], [3, 6], [6, 4], [7, 2], [4, 4], [5, 2]])  # Compute confidence
    print("\nConfidence measure:")
    for datapoint in test_datapoints:
        probabilities = classifier.predict_proba([datapoint])[0]
        predicted_class = "Class-" + str(np.argmax(probabilities))
        print("\nDatapoint:", datapoint)
        print("Predicted class:", predicted_class)
    visualize_classifier(classifier, test_datapoints, [0] * len(test_datapoints), "Test datapoints")  # Visualize the datapoints
    plt.show()
