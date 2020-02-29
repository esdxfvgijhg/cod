#!/usr/bin/python
import numpy as np  # SVM regressor to estimate traffic
from sklearn import preprocessing
from sklearn.svm import SVR

input_file = "traffic_data.txt"
X = []  # Reading the data
count = 0
with open(input_file, "r") as f:
    for line in f.readlines():
        data = line[:-1].split(",")
        X.append(data)
X = np.array(X)
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
params = {"kernel": "rbf", "C": 10.0, "epsilon": 0.2}  # Build SVR
regressor = SVR(**params)
regressor.fit(X, y)
import sklearn.metrics as sm  # Cross validation

y_pred = regressor.predict(X)
print("Mean absolute error =", round(sm.mean_absolute_error(y, y_pred), 2))
input_data = ["Tuesday", "13:35", "San Francisco", "yes"]  # Testing encoding on single data instance
input_data_encoded = [-1] * len(input_data)
count = 0
for i, item in enumerate(input_data):
    if item.isdigit():
        input_data_encoded[i] = int(input_data[i])
    else:
        input_data_encoded[i] = int(label_encoder[count].transform(input_data[i]))
        count = count + 1
input_data_encoded = np.array(input_data_encoded)
print("Predicted traffic:", int(regressor.predict(input_data_encoded)[0]))  # Predict and print output for a particular datapoint
