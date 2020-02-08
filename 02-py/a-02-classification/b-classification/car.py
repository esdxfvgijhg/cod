#!/usr/bin/python
import numpy as np
from sklearn import preprocessing
from sklearn.ensemble import RandomForestClassifier
import matplotlib.pyplot as plt

input_file = "car.data.txt"
X = []  # Reading the data
y = []
count = 0
with open(input_file, "r") as f:
    for line in f.readlines():
        data = line[:-1].split(",")
        X.append(data)
X = np.array(X)
label_encoder = []  # Convert string data to numerical data
X_encoded = np.empty(X.shape)
for i, item in enumerate(X[0]):
    label_encoder.append(preprocessing.LabelEncoder())
    X_encoded[:, i] = label_encoder[-1].fit_transform(X[:, i])
X = X_encoded[:, :-1].astype(int)
y = X_encoded[:, -1].astype(int)
params = {"n_estimators": 200, "max_depth": 8, "random_state": 7}  # Build a Random Forest classifier
classifier = RandomForestClassifier(**params)
classifier.fit(X, y)
from sklearn import model_selection  # Cross validation

accuracy = model_selection.cross_val_score(classifier, X, y, scoring="accuracy", cv=3)
print "Accuracy of the classifier: " + str(round(100 * accuracy.mean(), 2)) + "%"
input_data = ["vhigh", "vhigh", "2", "2", "small", "low"]  # Testing encoding on single data instance
input_data_encoded = [-1] * len(input_data)
for i, item in enumerate(input_data):
    input_data_encoded[i] = int(label_encoder[i].transform(input_data[i]))
input_data_encoded = np.array(input_data_encoded)
output_class = classifier.predict(input_data_encoded)  # Predict and print output for a particular datapoint
print "Output class:", label_encoder[-1].inverse_transform(output_class)[0]
from sklearn.learning_curve import validation_curve  # Validation curves ########################

classifier = RandomForestClassifier(max_depth=4, random_state=7)
parameter_grid = np.linspace(25, 200, 8).astype(int)
train_scores, validation_scores = validation_curve(classifier, X, y, "n_estimators", parameter_grid, cv=5)
print "\n##### VALIDATION CURVES #####"
print "\nParam: n_estimators\nTraining scores:\n", train_scores
print "\nParam: n_estimators\nValidation scores:\n", validation_scores
plt.figure()  # Plot the curve
plt.plot(parameter_grid, 100 * np.average(train_scores, axis=1), color="black")
plt.title("Training curve")
plt.xlabel("Number of estimators")
plt.ylabel("Accuracy")
plt.show()
classifier = RandomForestClassifier(n_estimators=20, random_state=7)
parameter_grid = np.linspace(2, 10, 5).astype(int)
train_scores, valid_scores = validation_curve(classifier, X, y, "max_depth", parameter_grid, cv=5)
print "\nParam: max_depth\nTraining scores:\n", train_scores
print "\nParam: max_depth\nValidation scores:\n", validation_scores
plt.figure()  # Plot the curve
plt.plot(parameter_grid, 100 * np.average(train_scores, axis=1), color="black")
plt.title("Validation curve")
plt.xlabel("Maximum depth of the tree")
plt.ylabel("Accuracy")
plt.show()
from sklearn.learning_curve import learning_curve  # Learning curves ########################

classifier = RandomForestClassifier(random_state=7)
parameter_grid = np.array([200, 500, 800, 1100])
train_sizes, train_scores, validation_scores = learning_curve(classifier, X, y, train_sizes=parameter_grid, cv=5)
print "\n##### LEARNING CURVES #####"
print "\nTraining scores:\n", train_scores
print "\nValidation scores:\n", validation_scores
plt.figure()  # Plot the curve
plt.plot(parameter_grid, 100 * np.average(train_scores, axis=1), color="black")
plt.title("Learning curve")
plt.xlabel("Number of training samples")
plt.ylabel("Accuracy")
plt.show()
