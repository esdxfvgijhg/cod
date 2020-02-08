#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.naive_bayes import GaussianNB
from logistic_regression import plot_classifier

input_file = "data_multivar.txt"
X = []
y = []
with open(input_file, "r") as f:
    for line in f.readlines():
        data = [float(x) for x in line.split(",")]
        X.append(data[:-1])
        y.append(data[-1])
X = np.array(X)
y = np.array(y)
classifier_gaussiannb = GaussianNB()
classifier_gaussiannb.fit(X, y)
y_pred = classifier_gaussiannb.predict(X)
accuracy = 100.0 * (y == y_pred).sum() / X.shape[0]  # compute accuracy of the classifier
print "Accuracy of the classifier =", round(accuracy, 2), "%"
plot_classifier(classifier_gaussiannb, X, y)
from sklearn import model_selection  # Train test split ###############################################

X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.25, random_state=5)
classifier_gaussiannb_new = GaussianNB()
classifier_gaussiannb_new.fit(X_train, y_train)
y_test_pred = classifier_gaussiannb_new.predict(X_test)
accuracy = 100.0 * (y_test == y_test_pred).sum() / X_test.shape[0]  # compute accuracy of the classifier
print "Accuracy of the classifier =", round(accuracy, 2), "%"
plot_classifier(classifier_gaussiannb_new, X_test, y_test)
num_validations = 5  # Cross validation and scoring functions ###############################################
accuracy = model_selection.cross_val_score(classifier_gaussiannb, X, y, scoring="accuracy", cv=num_validations)
print "Accuracy: " + str(round(100 * accuracy.mean(), 2)) + "%"
f1 = model_selection.cross_val_score(classifier_gaussiannb, X, y, scoring="f1_weighted", cv=num_validations)
print "F1: " + str(round(100 * f1.mean(), 2)) + "%"
precision = model_selection.cross_val_score(classifier_gaussiannb, X, y, scoring="precision_weighted", cv=num_validations)
print "Precision: " + str(round(100 * precision.mean(), 2)) + "%"
recall = model_selection.cross_val_score(classifier_gaussiannb, X, y, scoring="recall_weighted", cv=num_validations)
print "Recall: " + str(round(100 * recall.mean(), 2)) + "%"
