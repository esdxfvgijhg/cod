#!/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt
from sklearn import preprocessing
from sklearn.svm import LinearSVC
from sklearn.multiclass import OneVsOneClassifier
from sklearn import model_selection

input_file = "income_data.txt"  # Input file containing data
X = []  # Read the data
y = []
count_class1 = 0
count_class2 = 0
max_datapoints = 25000
with open(input_file, "r") as f:
    for line in f.readlines():
        if count_class1 >= max_datapoints and count_class2 >= max_datapoints:
            break
        if "?" in line:
            continue
        data = line[:-1].split(", ")
        if data[-1] == "<=50K" and count_class1 < max_datapoints:
            X.append(data)
            count_class1 += 1
        if data[-1] == ">50K" and count_class2 < max_datapoints:
            X.append(data)
            count_class2 += 1
X = np.array(X)  # Convert to numpy array
label_encoder = []  # Convert string data to numerical data
X_encoded = np.empty(X.shape)
for i, item in enumerate(X[0]):
    if item.isdigit():
        X_encoded[:, i] = X[:, i]
    else:
        label_encoder.append(preprocessing.LabelEncoder())
        X_encoded[:, i] = label_encoder[-1].fit_transform(X[:, i])
X = X_encoded[:, :-1].astype(int)
y = X_encoded[:, -1].astype(int)
classifier = OneVsOneClassifier(LinearSVC(random_state=0))  # Create SVM classifier
classifier.fit(X, y)  # Train the classifier
X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.2, random_state=5)  # Cross validation
classifier = OneVsOneClassifier(LinearSVC(random_state=0))
classifier.fit(X_train, y_train)
y_test_pred = classifier.predict(X_test)
f1 = model_selection.cross_val_score(classifier, X, y, scoring="f1_weighted", cv=3)  # Compute the F1 score of the SVM classifier
print("F1 score: " + str(round(100 * f1.mean(), 2)) + "%")
input_data = ["37", "Private", "215646", "HS-grad", "9", "Never-married", "Handlers-cleaners", "Not-in-family", "White", "Male", "0", "0", "40", "United-States"]  # Predict output for a test datapoint
input_data_encoded = [-1] * len(input_data)  # Encode test datapoint
count = 0
for i, item in enumerate(input_data):
    if item.isdigit():
        input_data_encoded[i] = int(input_data[i])
    else:
        input_data_encoded[i] = int(label_encoder[count].transform(input_data[i]))
        count += 1
input_data_encoded = np.array(input_data_encoded)
predicted_class = classifier.predict(input_data_encoded)  # Run classifier on encoded datapoint and print output
print(label_encoder[-1].inverse_transform(predicted_class)[0])
