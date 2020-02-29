#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
import utilities

input_file = "data_multivar.txt"  # Load input data
X, y = utilities.load_data(input_file)
class_0 = np.array([X[i] for i in range(len(X)) if y[i] == 0])  # Separate the data into classes based on 'y' ###############################################
class_1 = np.array([X[i] for i in range(len(X)) if y[i] == 1])
plt.figure()  # Plot the input data
plt.scatter(class_0[:, 0], class_0[:, 1], facecolors="black", edgecolors="black", marker="s")
plt.scatter(class_1[:, 0], class_1[:, 1], facecolors="None", edgecolors="black", marker="s")
plt.title("Input data")
from sklearn import model_selection  # Train test split and SVM training ###############################################
from sklearn.svm import SVC

X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.25, random_state=5)
params = {"kernel": "linear"}
classifier = SVC(**params)  # params = {'kernel': 'rbf'} # params = {'kernel': 'poly', 'degree': 3}
classifier.fit(X_train, y_train)
utilities.plot_classifier(classifier, X_train, y_train, "Training dataset")
y_test_pred = classifier.predict(X_test)
utilities.plot_classifier(classifier, X_test, y_test, "Test dataset")
from sklearn.metrics import classification_report  # Evaluate classifier performance ###############################################

target_names = ["Class-" + str(int(i)) for i in set(y)]
print("\n" + "#" * 30)
print("\nClassifier performance on training dataset\n")
print(classification_report(y_train, classifier.predict(X_train), target_names=target_names))
print("#" * 30 + "\n")
print("#" * 30)
print("\nClassification report on test dataset\n")
print(classification_report(y_test, y_test_pred, target_names=target_names))
print("#" * 30 + "\n")
plt.show()
