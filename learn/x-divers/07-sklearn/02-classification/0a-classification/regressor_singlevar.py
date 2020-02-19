#!/usr/bin/python
import pickle
import numpy as np
from sklearn import linear_model
import sklearn.metrics as sm
import matplotlib.pyplot as plt

input_file = "data_singlevar_regr.txt"  # Input file containing data
data = np.loadtxt(input_file, delimiter=",")  # Read data
X, y = data[:, :-1], data[:, -1]
num_training = int(0.8 * len(X))  # Train and test split
num_test = len(X) - num_training
X_train, y_train = X[:num_training], y[:num_training]  # Training data
X_test, y_test = X[num_training:], y[num_training:]  # Test data
regressor = linear_model.LinearRegression()  # Create linear regressor object
regressor.fit(X_train, y_train)  # Train the model using the training sets
y_test_pred = regressor.predict(X_test)  # Predict the output
plt.scatter(X_test, y_test, color="green")  # Plot outputs
plt.plot(X_test, y_test_pred, color="black", linewidth=4)
plt.xticks(())
plt.yticks(())
plt.show()
print("Linear regressor performance:")  # Compute performance metrics
print("Mean absolute error =", round(sm.mean_absolute_error(y_test, y_test_pred), 2))
print("Mean squared error =", round(sm.mean_squared_error(y_test, y_test_pred), 2))
print("Median absolute error =", round(sm.median_absolute_error(y_test, y_test_pred), 2))
print("Explain variance score =", round(sm.explained_variance_score(y_test, y_test_pred), 2))
print("R2 score =", round(sm.r2_score(y_test, y_test_pred), 2))
output_model_file = "model.pkl"  # Model persistence
with open(output_model_file, "wb") as f:  # Save the model
    pickle.dump(regressor, f)
with open(output_model_file, "rb") as f:  # Load the model
    regressor_model = pickle.load(f)
y_test_pred_new = regressor_model.predict(X_test)  # Perform prediction on test data
print("\nNew mean absolute error =", round(sm.mean_absolute_error(y_test, y_test_pred_new), 2))
