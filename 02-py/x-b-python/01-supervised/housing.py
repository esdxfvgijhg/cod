#!/usr/bin/python
import numpy as np
from sklearn.ensemble import RandomForestRegressor, AdaBoostRegressor
from sklearn.tree import DecisionTreeRegressor
from sklearn import datasets
from sklearn.metrics import mean_squared_error, explained_variance_score
from sklearn.utils import shuffle
import matplotlib.pyplot as plt


def plot_feature_importances(feature_importances, title, feature_names):
    feature_importances = 100.0 * (feature_importances / max(feature_importances))  # Normalize the importance values
    index_sorted = np.flipud(np.argsort(feature_importances))  # Sort the values and flip them
    pos = np.arange(index_sorted.shape[0]) + 0.5  # Arrange the X ticks
    plt.figure()  # Plot the bar graph
    plt.bar(pos, feature_importances[index_sorted], align="center")
    plt.xticks(pos, feature_names[index_sorted])
    plt.ylabel("Relative Importance")
    plt.title(title)
    plt.show()


if __name__ == "__main__":
    housing_data = datasets.load_boston()  # Load housing data
    X, y = shuffle(housing_data.data, housing_data.target, random_state=7)  # Shuffle the data
    num_training = int(0.8 * len(X))  # Split the data 80/20 (80% for training, 20% for testing)
    X_train, y_train = X[:num_training], y[:num_training]
    X_test, y_test = X[num_training:], y[num_training:]
    dt_regressor = DecisionTreeRegressor(max_depth=4)  # Fit decision tree regression model
    dt_regressor.fit(X_train, y_train)
    ab_regressor = AdaBoostRegressor(DecisionTreeRegressor(max_depth=4), n_estimators=400, random_state=7)  # Fit decision tree regression model with AdaBoost
    ab_regressor.fit(X_train, y_train)
    y_pred_dt = dt_regressor.predict(X_test)  # Evaluate performance of Decision Tree regressor
    mse = mean_squared_error(y_test, y_pred_dt)
    evs = explained_variance_score(y_test, y_pred_dt)
    print "\n#### Decision Tree performance ####"
    print "Mean squared error =", round(mse, 2)
    print "Explained variance score =", round(evs, 2)
    y_pred_ab = ab_regressor.predict(X_test)  # Evaluate performance of AdaBoost
    mse = mean_squared_error(y_test, y_pred_ab)
    evs = explained_variance_score(y_test, y_pred_ab)
    print "\n#### AdaBoost performance ####"
    print "Mean squared error =", round(mse, 2)
    print "Explained variance score =", round(evs, 2)
    plot_feature_importances(dt_regressor.feature_importances_, "Decision Tree regressor", housing_data.feature_names)  # Plot relative feature importances
    plot_feature_importances(ab_regressor.feature_importances_, "AdaBoost regressor", housing_data.feature_names)
