#!/usr/bin/python3
import time
import warnings
import numpy as np

import matplotlib.pyplot as plt
from seaborn import scatterplot as scatter
import mpl_toolkits.mplot3d.axes3d as p3

from sklearn import cluster, datasets, mixture
from sklearn.neighbors import kneighbors_graph
from sklearn.preprocessing import StandardScaler
from sklearn.cluster import bicluster
from itertools import cycle, islice
from fcmeans import FCM
from sklearn.base import BaseEstimator, clone
from sklearn.ensemble import RandomForestClassifier
from sklearn.utils.metaestimators import if_delegate_has_method

from sklearn import metrics

np.random.seed(0)

# plt.figure(figsize = (9 * 2 + 3, 12.5))
# plt.subplots_adjust(left=0.02, right=0.98, bottom=0.001, top=0.96, wspace=0.05, hspace=0.01)
# plot_num           = 1



class InductiveClusterer(BaseEstimator):
    def __init__(self, clusterer, classifier):
        self.clusterer = clusterer
        self.classifier = classifier
    def fit(self, X, y=None):
        self.clusterer_ = clone(self.clusterer)
        self.classifier_ = clone(self.classifier)
        y = self.clusterer_.fit_predict(X)
        self.classifier_.fit(X, y)
        return self
    @if_delegate_has_method(delegate="classifier_")
    def predict(self, X):
        return self.classifier_.predict(X)
    @if_delegate_has_method(delegate="classifier_")
    def decision_function(self, X):
        return self.classifier_.decision_function(X)





def get_labels(algorithm, X):
    t0 = time.time()
    with warnings.catch_warnings(): # catch warnings related to kneighbors_graph
        algorithm.fit(X)
    t1 = time.time()
    
    if hasattr(algorithm, "labels_"):
          labels = algorithm.labels_.astype(np.int)
    elif hasattr(algorithm, "row_labels_"):
          labels = algorithm.row_labels_.astype(np.int)
    else:
          labels = algorithm.predict(X)
    num_clusters = len(np.unique(labels))
    if hasattr(algorithm, "cluster_centers_"):
          cluster_centerx = algorithm.cluster_centers_
    elif hasattr(algorithm, "affinity_matrix_"):
          cluster_centerx = algorithm.affinity_matrix_
    elif hasattr(algorithm, "components_"):
          cluster_centerx = algorithm.components_
    elif hasattr(algorithm, "centers"):
          cluster_centerx = algorithm.centers
    else:
        cluster_centerx=np.zeros((num_clusters,len(X[1])))
    timex=t1-t0
    return timex, algorithm, labels, cluster_centerx

def ami_score(U, V):
    return metrics.adjusted_mutual_info_score(U, V, average_method="arithmetic")
score_funcs = [metrics.adjusted_rand_score,metrics.v_measure_score,ami_score,metrics.mutual_info_score] # metrics.consensus_score
 
#score = consensus_score(model.biclusters_, (rows[:, row_idx], columns[:, col_idx]))

def plot3D(labels,cluster_center,name):
    ax = p3.Axes3D(plt.figure())
    ax.view_init(7, -80)
    for l in np.unique(labels):
          colors = next(cycol)
          ax.scatter(cluster_center[l,0], cluster_center[l,1], cluster_center[l,2], color=colors, s=100, edgecolor="k")
          ax.scatter(X[labels == l, 0]  , X[labels == l, 1]  , X[labels == l, 2]  , color=colors, s=20 , edgecolor="k")
          ax.set_xlabel("BER");ax.set_ylabel("RSSI");ax.set_zlabel("ToA")
    plt.title(name)
    plt.show()


























loraData              = np.genfromtxt("data/X.csv", delimiter=",", dtype="str", skip_header=1)          # load the CSV file as a numpy matrix
X                     = loraData[:, 0:3].astype(int)                                                    # X = StandardScaler().fit_transform(X)



n_fuzzification       = [0.9, 1.1, 1.4, 1.6, 1.8, 2, 5]                        ;i_fuzzification=0
n_clusters            = [3]                                          ;i_cluster=0
n_neighbors           = [10]                                         ;i_neighbors=0
n_preference          = [-200]                                       ;i_preference=0
n_damping             = [0.9]                                        ;i_damping=0
n_eps                 = [0.3]                                        ;i_eps=0
n_linkage             = ["single","average","complete","ward","",""] ;i_linkage=0
n_affinity            = ["nearest_neighbors","cityblock"]            ;i_affinity=0
n_quantile            = [0.3]                                        ;i_quantile=0

bandwidth             = cluster.estimate_bandwidth(X, quantile=n_quantile[i_quantile])                      # estimate bandwidth for mean shift
connectivity          = kneighbors_graph(X, n_neighbors=n_neighbors[i_neighbors], include_self=False)   # connectivity matrix for structured Ward
connectivity          = 0.5 * (connectivity + connectivity.T)                                           # make connectivity symmetric


fcm                   = FCM(n_clusters=n_clusters[i_cluster], m=n_fuzzification[i_fuzzification]) # print(min_value)
ms                    = cluster.MeanShift(bandwidth=bandwidth, bin_seeding=True)
two_means             = cluster.MiniBatchKMeans(n_clusters=  n_clusters[i_cluster])
spectral              = cluster.SpectralClustering(n_clusters=  n_clusters[i_cluster], eigen_solver="arpack", affinity=n_affinity[i_affinity])
dbscan                = cluster.DBSCAN(eps=n_eps[i_eps])
affinity_propagation  = cluster.AffinityPropagation(damping=n_damping[i_damping], preference=n_preference[i_preference])
average_linkage       = cluster.AgglomerativeClustering(linkage=n_linkage[i_linkage], affinity=n_affinity[1], n_clusters=  n_clusters[i_cluster], connectivity=connectivity)
birch                 = cluster.Birch(n_clusters=  n_clusters[i_cluster])
gmm                   = mixture.GaussianMixture(n_components=  n_clusters[i_cluster], covariance_type="full")

spectralBiclustering  = bicluster.SpectralBiclustering(n_clusters=n_clusters[i_cluster], method="log", random_state=0)
spectralCoclustering  = bicluster.SpectralCoclustering(n_clusters=n_clusters[i_cluster], random_state=0)


n_algorithms = [fcm, ms, two_means, spectral, dbscan, affinity_propagation, average_linkage, birch, gmm, spectralBiclustering, spectralCoclustering]; i_algorithms=0
x_algorithms = ["FCM", "MiniBatchKMeans", "AffinityPropagation", "MeanShift", "SpectralClustering", "AgglomerativeClustering", "DBSCAN", "Birch", "GaussianMixture", "spectralBiclustering", "spectralCoclustering"]


clustering_algorithms = (("FCM", fcm), ("MiniBatchKMeans", two_means), ("AffinityPropagation", affinity_propagation), ("MeanShift", ms), ("SpectralClustering", spectral), ("AgglomerativeClustering", average_linkage), ("DBSCAN", dbscan), ("Birch", birch), ("GaussianMixture", gmm))

plots                 = []
names                 = []
cycol                 = cycle('bgrcmk')

scores    = np.zeros(len(n_algorithms))
alllabels = np.zeros((len(n_algorithms),len(X)))

i=0
for algorithm in n_algorithms:
    timex, algorithm, labels, cluster_center = get_labels(algorithm,X)
#    randomForest          = RandomForestClassifier(random_state=540)
#    inductive_learner     = InductiveClusterer(algorithm, randomForest).fit(X)
#    labels_a              = inductive_learner.predict(X_new)
    print(x_algorithms[i])
    alllabels[i] = labels
    plot3D(labels,cluster_center, x_algorithms[i])
    i+=1

#for score_func in score_funcs:
#    i=0
#    for name, algorithm in clustering_algorithms:
#        j=0
#        for jl in clustering_algorithms:
#            scores          = score_func(alllabels[i], alllabels[j]) #  round(metrics.silhouette_score(X, labels), 4)
#            print(scores)
#            j+=1
#        i+=1

timex, algorithm, labels_b, cluster_center   = get_labels(affinity_propagation,X)
for i in n_fuzzification:
    fcm                                      = FCM(n_clusters=n_clusters[i_cluster], m=i) # print(min_value)
    timex, algorithm, labels, cluster_center = get_labels(fcm,X)
    scores                                   = metrics.mutual_info_score(labels, labels_b) #  round(metrics.silhouette_score(X, labels), 4)
    print(scores)


#score_funcs = [metrics.adjusted_rand_score,metrics.v_measure_score,ami_score,metrics.mutual_info_score] # metrics.consensus_score

#fcm.u.argmax(axis=1)

#plt.figure()  # Plot the points and cluster centers
#plt.ylabel("BER")
#plt.xlabel("RSSI")
#plt.title("Clusters")
##scatter(X[:, 1], X[:, 0], marker="o")
#scatter(X[:, 1], X[:, 0], hue=fcm_labels, marker="o", palette=['red','black','blue'])
#scatter(cluster_centers[:, 1], cluster_centers[:, 0], marker="o", s=200, palette='green')
#plt.show()
#plt.figure()  # Plot the points and cluster centers
#plt.xlabel("ToA")
#plt.ylabel("BER")
#plt.title("Clusters")
##scatter(X[:, 0], X[:, 2])
#scatter(X[:, 0], X[:, 2], hue=fcm_labels, palette=['red','black','blue'])
#scatter(cluster_centers[:, 0], cluster_centers[:, 2], marker="o", s=200, palette='green')
#plt.show()
#plt.figure()  # Plot the points and cluster centers
#plt.ylabel("ToA")
#plt.xlabel("RSSI")
#plt.title("Clusters")
##scatter(X[:, 1], X[:, 2])
#scatter(X[:, 1], X[:, 2], hue=fcm_labels, palette=['red','black','blue'])
#scatter(cluster_centers[:, 1], cluster_centers[:, 2], marker="o", s=200, palette='green')
#plt.show()






















