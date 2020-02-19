#!/usr/bin/python

import numpy as np
from sklearn.cluster import MeanShift, estimate_bandwidth
from sklearn.datasets.samples_generator import make_blobs
# Generate sample data # #############################################################################
centers = [[1, 1], [-1, -1], [1, -1]]
X, _ = make_blobs(n_samples=10000, centers=centers, cluster_std=0.6)
loraData = np.genfromtxt("data/X.csv", delimiter=",", dtype="str",skip_header=1)  # load the CSV file as a numpy matrix
X = loraData[:, 0:3].astype(int)
# Compute clustering with MeanShift # #############################################################################
bandwidth = estimate_bandwidth(X, quantile=0.2, n_samples=500) # The following bandwidth can be automatically detected using
ms = MeanShift(bandwidth=bandwidth, bin_seeding=True)
ms.fit(X)
labels = ms.labels_
cluster_centers = ms.cluster_centers_
labels_unique = np.unique(labels)
n_clusters_ = len(labels_unique)
print("number of estimated clusters : %d" % n_clusters_)
# Plot result # #############################################################################
import matplotlib.pyplot as plt
from itertools import cycle
plt.figure(1)
plt.clf()
colors = cycle("bgrcmykbgrcmykbgrcmykbgrcmyk")
for k, col in zip(range(n_clusters_), colors):
    my_members = labels == k
    cluster_center = cluster_centers[k]
    plt.plot(X[my_members, 0], X[my_members, 1], col + ".")
    plt.plot(cluster_center[0], cluster_center[1], "o", markerfacecolor=col, markeredgecolor="k", markersize=14)
plt.title("Estimated number of clusters: %d" % n_clusters_)
plt.show()


import numpy as np
from sklearn.cluster import MeanShift, estimate_bandwidth
from itertools import cycle
import matplotlib.pyplot as plt  # Plot the points and centroids ###########################################################
X = np.loadtxt("data/X.csv", delimiter=",",skiprows=1)  # Load data from input file
bandwidth_X = estimate_bandwidth(X, quantile=0.1, n_samples=len(X))  # Estimate the bandwidth of X
meanshift_model = MeanShift(bandwidth=bandwidth_X, bin_seeding=True)  # Cluster data with MeanShift
meanshift_model.fit(X)
cluster_centers = meanshift_model.cluster_centers_  # Extract the centers of clusters
labels = meanshift_model.labels_  # Estimate the number of clusters
num_clusters = len(np.unique(labels))
print("\nCenters of clusters:\n", cluster_centers)
print("\nNumber of clusters in input data =", num_clusters)
plt.figure()  # Plot the points and cluster centers
markers = "o*xvs"
for i, marker in zip(range(num_clusters), markers):
    plt.scatter(X[labels == i, 0], X[labels == i, 1], marker=marker, color="black")  # Plot points that belong to the current cluster
    cluster_center = cluster_centers[i]  # Plot the cluster center
    plt.plot(
        cluster_center[0], cluster_center[1], marker="o", markerfacecolor="black", markeredgecolor="black", markersize=15,
    )
plt.title("Clusters")
plt.show()


import numpy as np
import matplotlib.pyplot as plt
from time import time
from sklearn import metrics
def uniform_labelings_scores(score_func, n_samples, n_clusters_range, fixed_n_classes=None, n_runs=5, seed=42):
    """ Compute score for 2 random uniform cluster labelings. Both random labelings have the same number of clusters for each value    possible value in ``n_clusters_range``. When fixed_n_classes is not None the first labeling is considered a ground    truth class assignment with fixed number of classes."""
    random_labels = np.random.RandomState(seed).randint
    scores = np.zeros((len(n_clusters_range), n_runs))
    if fixed_n_classes is not None:
        labels_a = random_labels(low=0, high=fixed_n_classes, size=n_samples)
    for i, k in enumerate(n_clusters_range):
        for j in range(n_runs):
            if fixed_n_classes is None:
                labels_a = random_labels(low=0, high=k, size=n_samples)
            labels_b = random_labels(low=0, high=k, size=n_samples)
            scores[i, j] = score_func(labels_a, labels_b)
    return scores
def ami_score(U, V):
    return metrics.adjusted_mutual_info_score(U, V, average_method="arithmetic")
score_funcs = [
    metrics.adjusted_rand_score,
    metrics.v_measure_score,
    ami_score,
    metrics.mutual_info_score,
]
n_samples = 100 # 2 independent random clusterings with equal cluster number
n_clusters_range = np.linspace(2, n_samples, 10).astype(np.int)
plt.figure(1)
plots = []
names = []
for score_func in score_funcs:
    print("Computing %s for %d values of n_clusters and n_samples=%d" % (score_func.__name__, len(n_clusters_range), n_samples))
    t0 = time()
    scores = uniform_labelings_scores(score_func, n_samples, n_clusters_range)
    print("done in %0.3fs" % (time() - t0))
    plots.append(plt.errorbar(n_clusters_range, np.median(scores, axis=1), scores.std(axis=1))[0])
    names.append(score_func.__name__)
plt.title("Clustering measures for 2 random uniform labelings\n" "with equal number of clusters");plt.xlabel("Number of clusters (Number of samples is fixed to %d)" % n_samples);plt.ylabel("Score value");plt.legend(plots, names);plt.ylim(bottom=-0.05, top=1.05)
# with fixed number of clusters # Random labeling with varying n_clusters against ground class labels
n_samples = 1000
n_clusters_range = np.linspace(2, 100, 10).astype(np.int)
n_classes = 10
plt.figure(2)
plots = []
names = []
for score_func in score_funcs:
    print("Computing %s for %d values of n_clusters and n_samples=%d" % (score_func.__name__, len(n_clusters_range), n_samples))
    t0 = time()
    scores = uniform_labelings_scores(score_func, n_samples, n_clusters_range, fixed_n_classes=n_classes)
    print("done in %0.3fs" % (time() - t0))
    plots.append(plt.errorbar(n_clusters_range, scores.mean(axis=1), scores.std(axis=1))[0])
    names.append(score_func.__name__)
plt.title("Clustering measures for random uniform labeling\n" "against reference assignment with %d classes" % n_classes);plt.xlabel("Number of clusters (Number of samples is fixed to %d)" % n_samples);plt.ylabel("Score value");plt.ylim(bottom=-0.05, top=1.05);plt.legend(plots, names);plt.show()

"""
==========================================================
Adjustment for chance in clustering performance evaluation
==========================================================
The following plots demonstrate the impact of the number of clusters andnumber of samples on various clustering performance evaluation metrics.Non-adjusted measures such as the V-Measure show a dependency betweenthe number of clusters and the number of samples:
	the mean V-Measureof random labeling increases significantly as the number of clusters iscloser to the total number of samples used to compute the measure.Adjusted for chance measure such as ARI display some random variationscentered around a mean score of 0.0 for any number of samples andclusters.Only adjusted measures can hence safely be used as a consensus indexto evaluate the average stability of clustering algorithms for a givenvalue of k on various overlapping sub-samples of the dataset.
"""
print(__doc__)



from itertools import cycle #!/usr/bin/python
import numpy as np
from sklearn.cluster import DBSCAN
from sklearn import metrics
import matplotlib.pyplot as plt
from utilities import load_data
input_file = "data/data_perf.txt"  # Load input data
X = load_data(input_file)
eps_grid = np.linspace(0.3, 1.2, num=10)  # Find the best epsilon
silhouette_scores = []
eps_best = eps_grid[0]
silhouette_score_max = -1
model_best = None
labels_best = None
for eps in eps_grid:
    model = DBSCAN(eps=eps, min_samples=5).fit(X)  # Train DBSCAN clustering model
    labels = model.labels_  # Extract labels
    silhouette_score = round(metrics.silhouette_score(X, labels), 4)  # Extract performance metric
    silhouette_scores.append(silhouette_score)
    print("Epsilon:", eps, " --> silhouette score:", silhouette_score)
    if silhouette_score > silhouette_score_max:
        silhouette_score_max = silhouette_score
        eps_best = eps
        model_best = model
        labels_best = labels
plt.figure()  # Plot silhouette scores vs epsilon
plt.bar(eps_grid, silhouette_scores, width=0.05, color="k", align="center")
plt.title("Silhouette score vs epsilon")
print("\nBest epsilon =", eps_best)  # Best params
model = model_best  # Associated model and labels for best epsilon
labels = labels_best
offset = 0  # Check for unassigned datapoints in the labels
if -1 in labels:
    offset = 1
num_clusters = len(set(labels)) - offset  # Number of clusters in the data
print("\nEstimated number of clusters =", num_clusters)
mask_core = np.zeros(labels.shape, dtype=np.bool)  # Extracts the core samples from the trained model
mask_core[model.core_sample_indices_] = True
plt.figure()  # Plot resultant clusters
labels_uniq = set(labels)
markers = cycle("vo^s<>")
for cur_label, marker in zip(labels_uniq, markers):
    if cur_label == -1:  # Use black dots for unassigned datapoints
        marker = "."
    cur_mask = labels == cur_label  # Create mask for the current label
    cur_data = X[cur_mask & mask_core]
    plt.scatter(cur_data[:, 0], cur_data[:, 1], marker=marker, edgecolors="black", s=96, facecolors="none")
    cur_data = X[cur_mask & ~mask_core]
    plt.scatter(cur_data[:, 0], cur_data[:, 1], marker=marker, edgecolors="black", s=32)
plt.title("Data separated into clusters")
plt.show()








import csv
import numpy as np
from sklearn import cluster, covariance, manifold
from sklearn.cluster import MeanShift, estimate_bandwidth
import matplotlib.pyplot as plt



dataset         = "data/X.csv"
loraData        = np.genfromtxt(dataset, delimiter=",", dtype="str", skip_header=1)  # load the CSV file as a numpy matrix
X               = loraData[:, 0:3].astype(int)


print(X)
bandwidth = estimate_bandwidth(X, quantile=0.8, n_samples=len(X))  # Estimating the bandwidth
meanshift_estimator = MeanShift(bandwidth=bandwidth, bin_seeding=True)  # Compute clustering with MeanShift
meanshift_estimator.fit(X)
labels = meanshift_estimator.labels_
centroids = meanshift_estimator.cluster_centers_
num_clusters = len(np.unique(labels))
print("\nNumber of clusters in input data =", num_clusters)
print("\nCentroids of clusters:")
#print("\t".join([name[:3] for name in names]))
for centroid in centroids:
    print("\t".join([str(int(x)) for x in centroid]))
centroids_milk_groceries = centroids[:, 1:3]  # Visualizing data ################
plt.figure()  # Plot the nodes using the coordinates of our centroids_milk_groceries
plt.scatter(centroids_milk_groceries[:, 0], centroids_milk_groceries[:, 1], s=100, edgecolors="k", facecolors="none")
offset = 0.2
plt.xlim(centroids_milk_groceries[:, 0].min() - offset * centroids_milk_groceries[:, 0].ptp(), centroids_milk_groceries[:, 0].max() + offset * centroids_milk_groceries[:, 0].ptp(),)
plt.ylim(centroids_milk_groceries[:, 1].min() - offset * centroids_milk_groceries[:, 1].ptp(), centroids_milk_groceries[:, 1].max() + offset * centroids_milk_groceries[:, 1].ptp())
plt.title("Centroids of clusters for milk and groceries")
plt.show()


