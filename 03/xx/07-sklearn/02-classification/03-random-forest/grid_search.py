#!/usr/bin/python3
import numpy as np
import matplotlib.pyplot as plt
from sklearn.metrics import classification_report
from sklearn import model_selection, grid_search
from sklearn.ensemble import ExtraTreesClassifier
from sklearn import model_selection
from sklearn.metrics import classification_report
from utilities import visualize_classifier

input_file = "data_random_forests.txt"  # Load input data
data = np.loadtxt(input_file, delimiter=",")
X, y = data[:, :-1], data[:, -1]
class_0 = np.array(X[y == 0])  # Separate input data into three classes based on labels
class_1 = np.array(X[y == 1])
class_2 = np.array(X[y == 2])
X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.25, random_state=5)  # Split the data into training and testing datasets
parameter_grid = [{"n_estimators": [100], "max_depth": [2, 4, 7, 12, 16]}, {"max_depth": [4], "n_estimators": [25, 50, 100, 250]}]  # Define the parameter grid
metrics = ["precision_weighted", "recall_weighted"]
for metric in metrics:
    print("\n##### Searching optimal parameters for", metric)
    classifier = grid_search.GridSearchCV(ExtraTreesClassifier(random_state=0), parameter_grid, cv=5, scoring=metric)
    classifier.fit(X_train, y_train)
    print("\nGrid scores for the parameter grid:")
    for params, avg_score, _ in classifier.grid_scores_:
        print(params, "-->", round(avg_score, 3))
    print("\nBest parameters:", classifier.best_params_)
    y_pred = classifier.predict(X_test)
    print("\nPerformance report:\n")
    print(classification_report(y_test, y_pred))
