#!/usr/bin/python

import time as time
import numpy as np
import matplotlib.pyplot as plt
import mpl_toolkits.mplot3d.axes3d as p3
from sklearn.cluster import AgglomerativeClustering
from sklearn.datasets.samples_generator import make_swiss_roll

# Generate data (swiss roll dataset) # #############################################################################
n_samples        = 1500
noise            = 0.05
X, _             = make_swiss_roll(n_samples, noise)
X[:, 1]         *= 0.5 # Make it thinner

dataset         = "data/X.csv"
loraData        = np.genfromtxt(dataset, delimiter=",", dtype="str", skip_header=1)  # load the CSV file as a numpy matrix
X               = loraData[:, 0:3].astype(int)


# Compute clustering # #############################################################################
print("Compute unstructured hierarchical clustering...")
st = time.time()
ward = AgglomerativeClustering(n_clusters=6, linkage="ward").fit(X)
elapsed_time = time.time() - st
label = ward.labels_
print("Elapsed time: %.2fs" % elapsed_time)
print("Number of points: %i" % label.size)
# Plot result # #############################################################################
fig = plt.figure()
ax = p3.Axes3D(fig)
ax.view_init(7, -80)

for l in np.unique(label):
    ax.scatter(X[label == l, 0], X[label == l, 1], X[label == l, 2], color=plt.cm.jet(np.float(l) / np.max(label + 1)), s=20, edgecolor="k")
    ax.set_xlabel("BER")
    ax.set_ylabel("RSSI")
    ax.set_zlabel("ToA")
plt.title("Without connectivity constraints (time %.2fs)" % elapsed_time)
# Define the structure A of the data. Here a 10 nearest neighbors # #############################################################################
from sklearn.neighbors import kneighbors_graph
connectivity = kneighbors_graph(X, n_neighbors=10, include_self=False)
# Compute clustering # #############################################################################
print("Compute structured hierarchical clustering...")
st = time.time()
ward = AgglomerativeClustering(n_clusters=6, connectivity=connectivity, linkage="ward").fit(X)
elapsed_time = time.time() - st
label = ward.labels_
print("Elapsed time: %.2fs" % elapsed_time)
print("Number of points: %i" % label.size)
# Plot result # #############################################################################
fig = plt.figure()
ax = p3.Axes3D(fig)
ax.view_init(7, -80)
for l in np.unique(label):
    ax.scatter(X[label == l, 0], X[label == l, 1], X[label == l, 2], color=plt.cm.jet(float(l) / np.max(label + 1)), s=20, edgecolor="k")
    ax.set_xlabel("BER")
    ax.set_ylabel("RSSI")
    ax.set_zlabel("ToA")
plt.title("With connectivity constraints (time %.2fs)" % elapsed_time)
plt.show()

"""
===========================================================
Hierarchical clustering: structured vs unstructured ward
===========================================================
Example builds a swiss roll dataset and runshierarchical clustering on their position.For more information,
	see :ref:`hierarchical_clustering`.In a first step,
	the hierarchical clustering is performed without connectivityconstraints on the structure and is solely based on distance,
	whereas ina second step the clustering is restricted to the k-Nearest Neighborsgraph:
	it's a hierarchical clustering with structure prior.Some of the clusters learned without connectivity constraints do notrespect the structure of the swiss roll and extend across different folds ofthe manifolds.
On the opposite,
	when opposing connectivity constraints,the clusters form a nice parcellation of the swiss roll.
"""
print(__doc__)










import numpy as np # License: BSD 3 clause
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D
from sklearn.cluster import KMeans
from sklearn import datasets
np.random.seed(5)
iris = datasets.load_iris()
X = iris.data
y = iris.target
estimators = [("k_means_iris_8", KMeans(n_clusters=8)), ("k_means_iris_3", KMeans(n_clusters=3)), ("k_means_iris_bad_init", KMeans(n_clusters=3, n_init=1, init="random"))]
fignum = 1
titles = ["8 clusters", "3 clusters", "3 clusters, bad initialization"]
for name, est in estimators:
    fig = plt.figure(fignum, figsize=(4, 3))
    ax = Axes3D(fig, rect=[0, 0, 0.95, 1], elev=48, azim=134)
    est.fit(X)
    labels = est.labels_
    ax.scatter(X[:, 3], X[:, 0], X[:, 2], c=labels.astype(np.float), edgecolor="k")
    ax.w_xaxis.set_ticklabels([])
    ax.w_yaxis.set_ticklabels([])
    ax.w_zaxis.set_ticklabels([])
    ax.set_xlabel("Petal width")
    ax.set_ylabel("Sepal length")
    ax.set_zlabel("Petal length")
    ax.set_title(titles[fignum - 1])
    ax.dist = 12
    fignum = fignum + 1
fig = plt.figure(fignum, figsize=(4, 3)) # Plot the ground truth
ax = Axes3D(fig, rect=[0, 0, 0.95, 1], elev=48, azim=134)
for name, label in [("Setosa", 0), ("Versicolour", 1), ("Virginica", 2)]:
    ax.text3D(X[y == label, 3].mean(), X[y == label, 0].mean(), X[y == label, 2].mean() + 2, name, horizontalalignment="center", bbox=dict(alpha=0.2, edgecolor="w", facecolor="w"))
y = np.choose(y, [1, 2, 0]).astype(np.float) # Reorder the labels to have colors matching the cluster results
ax.scatter(X[:, 3], X[:, 0], X[:, 2], c=y, edgecolor="k")
ax.w_xaxis.set_ticklabels([])
ax.w_yaxis.set_ticklabels([])
ax.w_zaxis.set_ticklabels([])
ax.set_xlabel("Petal width")
ax.set_ylabel("Sepal length")
ax.set_zlabel("Petal length")
ax.set_title("Ground Truth")
ax.dist = 12
fig.show()





























import numpy as np
import matplotlib.pyplot as plt
from matplotlib import patches
from sklearn import datasets
from sklearn.mixture import GaussianMixture as GMM
from sklearn.model_selection import StratifiedKFold


iris                    = datasets.load_iris()       # Load the iris dataset
indices                 = StratifiedKFold(iris.target)  # Split dataset into training and testing (80/20 split)
train_index, test_index = next(iter(indices))       # Take the first fold
X_train                 = iris.data[train_index]    # Extract training data and labels
y_train                 = iris.target[train_index]
X_test                  = iris.data[test_index]     # Extract testing data and labels
y_test                  = iris.target[test_index]
num_classes             = len(np.unique(y_train))  # Extract the number of classes
classifier              = GMM(n_components=num_classes, covariance_type="full", init_params="wc", n_iter=20)  # Build GMM
classifier.means_       = np.array([X_train[y_train == i].mean(axis=0) for i in range(num_classes)])  # Initialize the GMM means

classifier.fit(X_train)  # Train the GMM classifier
plt.figure()             # Draw boundaries
colors = "bgr"
for i, color in enumerate(colors):
    eigenvalues, eigenvectors = np.linalg.eigh(classifier._get_covars()[i][:2, :2])  # Extract eigenvalues and eigenvectors
    norm_vec                  = eigenvectors[0] / np.linalg.norm(eigenvectors[0])  # Normalize the first eigenvector
    angle                     = np.arctan2(norm_vec[1], norm_vec[0])  # Extract the angle of tilt
    angle                     = 180 * angle / np.pi
    scaling_factor            = 8  # (random value chosen to suit our needs) # Scaling factor to magnify the ellipses
    eigenvalues              *= scaling_factor
    ellipse                   = patches.Ellipse(classifier.means_[i, :2], eigenvalues[0], eigenvalues[1], 180 + angle, color=color,)  # Draw the ellipse
    axis_handle               = plt.subplot(1, 1, 1)
    ellipse.set_clip_box(axis_handle.bbox)
    ellipse.set_alpha(0.6)
    axis_handle.add_artist(ellipse)
colors = "bgr"  # Plot the data
for i, color in enumerate(colors):
    cur_data      = iris.data[iris.target == i]
    plt.scatter(cur_data[:, 0], cur_data[:, 1], marker="o", facecolors="none", edgecolors="black", s=40, label=iris.target_names[i],)
    test_data     = X_test[y_test == i]
    plt.scatter(test_data[:, 0], test_data[:, 1], marker="s", facecolors="black", edgecolors="black", s=40, label=iris.target_names[i],)
y_train_pred      = classifier.predict(X_train)  # Compute predictions for training and testing data
accuracy_training = np.mean(y_train_pred.ravel() == y_train.ravel()) * 100
y_test_pred       = classifier.predict(X_test)
accuracy_testing  = np.mean(y_test_pred.ravel() == y_test.ravel()) * 100
plt.title("GMM classifier");plt.xticks(());plt.yticks(());plt.show()











