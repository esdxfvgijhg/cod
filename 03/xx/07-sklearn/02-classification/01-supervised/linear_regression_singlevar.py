#!/usr/bin/python
import sys
import numpy as np

filename = sys.argv[1]
X = []
y = []
with open(filename, "r") as f:
    for line in f.readlines():
        xt, yt = [float(i) for i in line.split(",")]
        X.append(xt)
        y.append(yt)
num_training = int(0.8 * len(X))  # Train/test split
num_test = len(X) - num_training
X_train = np.array(X[:num_training]).reshape((num_training, 1))  # Training data
y_train = np.array(y[:num_training])
X_test = np.array(X[num_training:]).reshape((num_test, 1))  # Test data
y_test = np.array(y[num_training:])
from sklearn import linear_model  # Create linear regression object

linear_regressor = linear_model.LinearRegression()
linear_regressor.fit(X_train, y_train)  # Train the model using the training sets
y_test_pred = linear_regressor.predict(X_test)  # Predict the output
import matplotlib.pyplot as plt  # Plot outputs

plt.scatter(X_test, y_test, color="green")
plt.plot(X_test, y_test_pred, color="black", linewidth=4)
plt.xticks(())
plt.yticks(())
plt.show()
import sklearn.metrics as sm  # Measure performance

print("Mean absolute error =", round(sm.mean_absolute_error(y_test, y_test_pred), 2))
print("Mean squared error =", round(sm.mean_squared_error(y_test, y_test_pred), 2))
print("Median absolute error =", round(sm.median_absolute_error(y_test, y_test_pred), 2))
print("Explain variance score =", round(sm.explained_variance_score(y_test, y_test_pred), 2))
print("R2 score =", round(sm.r2_score(y_test, y_test_pred), 2))
import pickle as pickle  # Model persistence

output_model_file = "3_model_linear_regr.pkl"
with open(output_model_file, "w") as f:
    pickle.dump(linear_regressor, f)
with open(output_model_file, "r") as f:
    model_linregr = pickle.load(f)
y_test_pred_new = model_linregr.predict(X_test)
print("\nNew mean absolute error =", round(sm.mean_absolute_error(y_test, y_test_pred_new), 2))
