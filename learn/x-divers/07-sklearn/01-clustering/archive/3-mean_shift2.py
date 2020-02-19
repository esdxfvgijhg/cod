#!/usr/bin/python3
import numpy as np
from sklearn.cluster import MeanShift, estimate_bandwidth
from sklearn.datasets.samples_generator import make_blobs
from itertools import cycle
import matplotlib.pyplot as plt
from time import time
from sklearn import metrics
from sklearn.cluster import DBSCAN
from utilities import load_data
import csv
from sklearn import cluster, covariance, manifold
import matplotlib.pyplot as plt
from fcmeans import FCM 
from sklearn.cluster import AffinityPropagation


loraData                              = np.genfromtxt("data/X.csv", delimiter=",", dtype="str",skip_header=1)  # load the CSV file as a numpy matrix
X                                     = loraData[:, 0:3].astype(int)

eps_grid                              = np.linspace(0.3, 1.2, num=10)  # Find the best epsilon


bandwidth                             = estimate_bandwidth(X, quantile=0.1, n_samples=len(X))  # Estimate the bandwidth of X
meanshift_model                       = MeanShift(bandwidth=bandwidth, bin_seeding=True).fit(X)  # Cluster data with MeanShift
cluster_centers                       = meanshift_model.cluster_centers_  # Extract the centers of clusters
labels                                = meanshift_model.labels_  # Estimate the number of clusters

dbscan_model                          = DBSCAN(eps=eps_grid[0], min_samples=5).fit(X)
dbscan_labels                         = dbscan_model.labels_

labels_uniq                           = set(labels)
num_clusters                          = len(np.unique(labels)) # len(set(labels)) - offset  # Number of clusters in the data
mask_core                             = np.zeros(labels.shape, dtype=np.bool)  # Extracts the core samples from the trained model

eps_best                              = eps_grid[0]

offset                                = 0.2
labels_best                           = None
markers                               = cycle("vo^s<>") # "o*xvs"
model_best                            = None
names                                 = []
n_classes                             = 10
n_samples                             = 100
plots                                 = []
silhouette_score_max                  = -1
silhouette_scores                     = []
n_clusters_range                      = [2,1.2,1.6,2,2.4,2.8] # np.linspace(3, n_samples, 3).astype(np.int)
print(n_clusters_range)


def uniform_labelings_scores(score_func, n_clusters_range, n_runs=5, seed=42):
    scores  = np.zeros((len(n_clusters_range), n_runs))
    for i,k in enumerate(n_clusters_range):
        print(i,k)
        for j in range(n_runs):
            labels_a     = FCM(n_clusters=3, m=k).fit(X).u.argmax(axis=1)

            affinity_model  = AffinityPropagation(preference=-50).fit(X)
            labels_b        = affinity_model.labels_

            bandwidth       = estimate_bandwidth(X, quantile=0.1, n_samples=len(X))
            meanshift_model = MeanShift(bandwidth=bandwidth, bin_seeding=True).fit(X)  # Cluster data with MeanShift
            labels_b        = meanshift_model.labels_

            dbscan_model    = DBSCAN(eps=eps_grid[0], min_samples=5).fit(X)
            labels_b        = dbscan_model.labels_

            scores[i, j] = score_func(labels_a, labels_b) #  round(metrics.silhouette_score(X, labels), 4)
    return scores
def ami_score(U, V):
    return metrics.adjusted_mutual_info_score(U, V, average_method="arithmetic")
score_funcs = [metrics.adjusted_rand_score,metrics.v_measure_score,ami_score,metrics.mutual_info_score,]

plt.figure(1)
for score_func in score_funcs:
    scores          = uniform_labelings_scores(score_func, n_clusters_range)
    plots.append(plt.errorbar(n_clusters_range, np.mean(scores, axis=1), scores.std(axis=1))[0]) # plt.bar(eps_grid, silhouette_scores, width=0.05, color="k", align="center");plt.title("Silhouette score vs epsilon")
    names.append(score_func.__name__)
plt.title("Clustering measures for random uniform labeling against reference assignment with %d classes" % n_classes);plt.xlabel("Number of clusters (Number of samples is fixed to %d)" % n_samples);plt.ylabel("Score value");plt.ylim(bottom=-0.05, top=1.05);plt.legend(plots, names);plt.show()


plt.figure(4); plt.clf()
colors = cycle("bgrcmykbgrcmykbgrcmykbgrcmyk")
for k, col in zip(range(num_clusters), colors):
    my_members     = labels == k
    cluster_center = cluster_centers[k]
    plt.plot(X[my_members, 0], X[my_members, 1], col + ".")
    plt.plot(cluster_center[0], cluster_center[1], "o", markerfacecolor=col, markeredgecolor="k", markersize=14)
plt.title("Estimated number of clusters: %d" % num_clusters);plt.show()


mask_core[dbscan_model.core_sample_indices_] = True
plt.figure(6)
for cur_label, marker in zip(labels_uniq, markers):
    if cur_label == -1:
        marker = "."
    cur_mask = labels == cur_label
    cur_data = X[cur_mask & mask_core]
    plt.scatter(cur_data[:, 0], cur_data[:, 1], marker=marker, edgecolors="black", s=96, facecolors="none")
    cur_data = X[cur_mask & ~mask_core]
    plt.scatter(cur_data[:, 0], cur_data[:, 1], marker=marker, edgecolors="black", s=32)
plt.title("Data separated into clusters");plt.show()





















