#!/usr/bin/python
import numpy as np
import matplotlib.pyplot as plt
from sklearn import svm, grid_search, model_selection
from sklearn.metrics import classification_report
import utilities

input_file = "data_multivar.txt"  # Load input data
X, y = utilities.load_data(input_file)
X_train, X_test, y_train, y_test = model_selection.train_test_split(X, y, test_size=0.25, random_state=5)  # Train test split ###############################################
parameter_grid = [  # Set the parameters by cross-validation
    {"kernel": ["linear"], "C": [1, 10, 50, 600]},
    {"kernel": ["poly"], "degree": [2, 3]},
    {"kernel": ["rbf"], "gamma": [0.01, 0.001], "C": [1, 10, 50, 600]},
]
metrics = ["precision", "recall_weighted"]
for metric in metrics:
    print("\n#### Searching optimal hyperparameters for", metric)
    classifier = grid_search.GridSearchCV(svm.SVC(C=1), parameter_grid, cv=5, scoring=metric)
    classifier.fit(X_train, y_train)
    print("\nScores across the parameter grid:")
    for params, avg_score, _ in classifier.grid_scores_:
        print(params, "-->", round(avg_score, 3))
    print("\nHighest scoring parameter set:", classifier.best_params_)
    y_true, y_pred = y_test, classifier.predict(X_test)
    print("\nFull performance report:\n")
    print(classification_report(y_true, y_pred))
