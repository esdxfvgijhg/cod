#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import classification_report
from sklearn import model_selection
from sklearn.tree import DecisionTreeClassifier
from utilities import visualize_classifier

input_file = "data_decision_trees.txt"  # Load input data
data = np.loadtxt(input_file, delimiter=",")
X, y = data[:, :-1], data[:, -1]
class_0 = np.array(X[y == 0])  # Separate input data into two classes based on labels
class_1 = np.array(X[y == 1])
plt.figure()  # Visualize input data
plt.scatter(class_0[:, 0], class_0[:, 1], s=75, facecolors="black", edgecolors="black", linewidth=1, marker="x")
plt.scatter(class_1[:, 0], class_1[:, 1], s=75, facecolors="white", edgecolors="black", linewidth=1, marker="o")
plt.title("Input data")
X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.25, random_state=5)  # Split data into training and testing datasets
params = {"random_state": 0, "max_depth": 4}  # Decision Trees classifier
classifier = DecisionTreeClassifier(**params)
classifier.fit(X_train, y_train)
visualize_classifier(classifier, X_train, y_train, "Training dataset")
y_test_pred = classifier.predict(X_test)
visualize_classifier(classifier, X_test, y_test, "Test dataset")
class_names = ["Class-0", "Class-1"]  # Evaluate classifier performance
print("\n" + "#" * 40)
print("\nClassifier performance on training dataset\n")
print(classification_report(y_train, classifier.predict(X_train), target_names=class_names))
print("#" * 40 + "\n")
print("#" * 40)
print("\nClassifier performance on test dataset\n")
print(classification_report(y_test, y_test_pred, target_names=class_names))
print("#" * 40 + "\n")
plt.show()
