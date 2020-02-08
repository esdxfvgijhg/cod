#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.naive_bayes import GaussianNB
from sklearn import model_selection
from utilities import visualize_classifier

input_file = "data_multivar_nb.txt"  # Input file containing data
data = np.loadtxt(input_file, delimiter=",")  # Load data from input file
X, y = data[:, :-1], data[:, -1]
classifier = GaussianNB()  # Create Naive Bayes classifier
classifier.fit(X, y)  # Train the classifier
y_pred = classifier.predict(X)  # Predict the values for training data
accuracy = 100.0 * (y == y_pred).sum() / X.shape[0]  # Compute accuracy
print("Accuracy of Naive Bayes classifier =", round(accuracy, 2), "%")
visualize_classifier(classifier, X, y)  # Visualize the performance of the classifier
X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.2, random_state=3)  # Split data into training and test data # Cross validation ###############################################
classifier_new = GaussianNB()
classifier_new.fit(X_train, y_train)
y_test_pred = classifier_new.predict(X_test)
accuracy = 100.0 * (y_test == y_test_pred).sum() / X_test.shape[0]  # compute accuracy of the classifier
print("Accuracy of the new classifier =", round(accuracy, 2), "%")
visualize_classifier(classifier_new, X_test, y_test)  # Visualize the performance of the classifier
num_folds = 3  # Scoring functions ###############################################
accuracy_values = model_selection.cross_val_score(classifier, X, y, scoring="accuracy", cv=num_folds)
print("Accuracy: " + str(round(100 * accuracy_values.mean(), 2)) + "%")
precision_values = model_selection.cross_val_score(classifier, X, y, scoring="precision_weighted", cv=num_folds)
print("Precision: " + str(round(100 * precision_values.mean(), 2)) + "%")
recall_values = model_selection.cross_val_score(classifier, X, y, scoring="recall_weighted", cv=num_folds)
print("Recall: " + str(round(100 * recall_values.mean(), 2)) + "%")
f1_values = model_selection.cross_val_score(classifier, X, y, scoring="f1_weighted", cv=num_folds)
print("F1: " + str(round(100 * f1_values.mean(), 2)) + "%")
