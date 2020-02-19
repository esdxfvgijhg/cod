#!/usr/bin/python
import sys
import csv
import numpy as np
from sklearn.ensemble import RandomForestRegressor
from sklearn import preprocessing
from sklearn.metrics import mean_squared_error, explained_variance_score
from sklearn.utils import shuffle
import matplotlib.pyplot as plt
from housing import plot_feature_importances


def load_dataset(filename):
    file_reader = csv.reader(open(filename, "rb"), delimiter=",")
    X, y = [], []
    for row in file_reader:
        X.append(row[2:13])
        y.append(row[-1])
    feature_names = np.array(X[0])  # Extract feature names
    return np.array(X[1:]).astype(np.float32), np.array(y[1:]).astype(np.float32), feature_names  # Remove the first row because they are feature names


if __name__ == "__main__":
    X, y, feature_names = load_dataset(sys.argv[1])  # Load the dataset from the input file
    X, y = shuffle(X, y, random_state=7)
    num_training = int(0.9 * len(X))  # Split the data 80/20 (80% for training, 20% for testing)
    X_train, y_train = X[:num_training], y[:num_training]
    X_test, y_test = X[num_training:], y[num_training:]
    rf_regressor = RandomForestRegressor(n_estimators=1000, max_depth=10, min_samples_split=1)  # Fit Random Forest regression model
    rf_regressor.fit(X_train, y_train)
    y_pred = rf_regressor.predict(X_test)  # Evaluate performance of Random Forest regressor
    mse = mean_squared_error(y_test, y_pred)
    evs = explained_variance_score(y_test, y_pred)
    print("\n#### Random Forest regressor performance ####")
    print(("Mean squared error =", round(mse, 2)))
    print(("Explained variance score =", round(evs, 2)))
    plot_feature_importances(rf_regressor.feature_importances_, "Random Forest regressor", feature_names)  # Plot relative feature importances
