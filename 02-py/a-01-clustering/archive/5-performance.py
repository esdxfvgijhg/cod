#!/usr/bin/python

import numpy as np

from sklearn.cluster import DBSCAN
from sklearn.cluster import AffinityPropagation
from sklearn.preprocessing import StandardScaler
from sklearn import metrics
import matplotlib.pyplot as plt
from itertools import cycle
from fcmeans import FCM 
from sklearn.cluster import KMeans
import utilities



loraData        = np.genfromtxt("data/X.csv", delimiter=",", dtype="str", skip_header=1)  # load the CSV file as a numpy matrix
X               = loraData[:, 0:3].astype(int) #X              = StandardScaler().fit_transform(X)


#for k, col in zip(unique_labels, colors):
#    if k == -1:
#        col = [0, 0, 0, 1] # Black used for noise.
#    class_members = labels == k
#    xy = X[class_members & core_samples_mask]
#    plt.plot(xy[:, 0], xy[:, 1], "o", markerfacecolor=tuple(col), markeredgecolor="k", markersize=14)
#    xy = X[class_members & ~core_samples_mask]
#    plt.plot(xy[:, 0], xy[:, 1], "o", markerfacecolor=tuple(col), markeredgecolor="k", markersize=6)
#for k, col in zip(range(n_clusters_), colors):
#    class_members = labels == k
#    cluster_center = X[cluster_centers_indices[k]]
#    plt.plot(X[class_members, 0], X[class_members, 1], col)
#    plt.plot(cluster_center[0], cluster_center[1], "o", markerfacecolor=col, markeredgecolor="k", markersize=14)
#    for x in X[class_members]:
#        plt.plot([cluster_center[0], x[0]], [cluster_center[1], x[1]], col)
#plt.title("Estimated number of clusters: %d" % n_clusters_);plt.show()



# -----------------------------------------------------------------

silhouettes       = []
adjusted_mutuals  = []
rand_indexs       = []
v_measures        = []
completenesss     = []
homogeneities     = []
noises            = []
n_clusters        = []

range_values = np.arange(2, 10)

for i in range_values:
    kmeans = KMeans(init="k-means++", n_clusters=i, n_init=10).fit(X)  # Train the model
    labels_true = kmeans.labels_

    af                                          = AffinityPropagation(preference=-50).fit(X)
    cluster_centers_indices                     = af.cluster_centers_indices_
    labels                                      = af.labels_
    n_clusters_                                 = len(cluster_centers_indices)

    noise           = list(labels).count(-1)                                                              # Estimated number of noise points: %d"
    homogeneity     = metrics.homogeneity_score(labels_true, labels)                                       #"Homogeneity: %0.3f"
    completeness    = metrics.completeness_score(labels_true, labels)                                      # Completeness: %0.3f"
    v_measure       = metrics.v_measure_score(labels_true, labels)                                         # V-measure: %0.3f"
    rand_index      = metrics.adjusted_rand_score(labels_true, labels)                                     # Adjusted Rand Index: %0.3f"
    adjusted_mutual = metrics.adjusted_mutual_info_score(labels_true, labels, average_method="arithmetic") # Adjusted Mutual Information: %0.3f"
    silhouette      = metrics.silhouette_score(X, labels_true, metric="euclidean", sample_size=len(X))    # Silhouette Coefficient: %0.3f"

    silhouettes.append(silhouette)
    adjusted_mutuals.append(adjusted_mutual)
    rand_indexs.append(rand_index)
    v_measures.append(v_measure)
    completenesss.append(completeness)
    homogeneities.append(homogeneity)
    noises.append(noise)
    n_clusters.append(i)

plt.figure(); plt.bar(range_values, rand_indexs, width=0.6, color="k", align="center"); plt.title("Silhouette score vs number of clusters"); plt.figure(); plt.scatter(X[:, 0], X[:, 1], color="k", s=30, marker="o", facecolors="none")
x_min, x_max = min(X[:, 0]) - 1, max(X[:, 0]) + 1
y_min, y_max = min(X[:, 1]) - 1, max(X[:, 1]) + 1
plt.title("Input data");plt.xlim(x_min, x_max);plt.ylim(y_min, y_max);plt.xticks(());plt.yticks(());plt.show()


# Plot result # #############################################################################
unique_labels = set(labels) # Black removed and is used for noise instead.
colors        = [plt.cm.Spectral(each) for each in np.linspace(0, 1, len(unique_labels))] # colors = cycle("bgrcmykbgrcmykbgrcmykbgrcmyk")
plt.close("all");plt.figure(1);plt.clf()


# -----------------------------------------------------------------


silhouettes       = []
adjusted_mutuals  = []
rand_indexs       = []
v_measures        = []
completenesss     = []
homogeneities     = []
noises            = []
n_clusters        = []

range_values = np.arange(2, 10)

for i in range_values:
    fcm             = FCM(n_clusters=3, m=2).fit(X)
    labels_true     = fcm.u.argmax(axis=1)

    af                                          = AffinityPropagation(preference=-50).fit(X)
    cluster_centers_indices                     = af.cluster_centers_indices_
    labels                                      = af.labels_
    n_clusters_                                 = len(cluster_centers_indices)

    noise           = list(labels).count(-1)                                                              # Estimated number of noise points: %d"
    homogeneity     = metrics.homogeneity_score(labels_true, labels)                                       #"Homogeneity: %0.3f"
    completeness    = metrics.completeness_score(labels_true, labels)                                      # Completeness: %0.3f"
    v_measure       = metrics.v_measure_score(labels_true, labels)                                         # V-measure: %0.3f"
    rand_index      = metrics.adjusted_rand_score(labels_true, labels)                                     # Adjusted Rand Index: %0.3f"
    adjusted_mutual = metrics.adjusted_mutual_info_score(labels_true, labels, average_method="arithmetic") # Adjusted Mutual Information: %0.3f"
    silhouette      = metrics.silhouette_score(X, labels_true, metric="euclidean", sample_size=len(X))    # Silhouette Coefficient: %0.3f"

    silhouettes.append(silhouette)
    adjusted_mutuals.append(adjusted_mutual)
    rand_indexs.append(rand_index)
    v_measures.append(v_measure)
    completenesss.append(completeness)
    homogeneities.append(homogeneity)
    noises.append(noise)
    n_clusters.append(i)

plt.figure(); plt.bar(range_values, rand_indexs, width=0.6, color="k", align="center"); plt.title("Silhouette score vs number of clusters"); plt.figure(); plt.scatter(X[:, 0], X[:, 1], color="k", s=30, marker="o", facecolors="none")
x_min, x_max = min(X[:, 0]) - 1, max(X[:, 0]) + 1
y_min, y_max = min(X[:, 1]) - 1, max(X[:, 1]) + 1
plt.title("Input data");plt.xlim(x_min, x_max);plt.ylim(y_min, y_max);plt.xticks(());plt.yticks(());plt.show()












#db                                         = DBSCAN(eps=0.3, min_samples=10).fit(X)
#core_samples_mask                          = np.zeros_like(db.labels_, dtype=bool)
#core_samples_mask[db.core_sample_indices_] = True
#labels                                     = db.labels_
#n_clusters_                                = len(set(labels)) - (1 if -1 in labels else 0) # Number of clusters in labels, ignoring noise if present.




