#!/usr/bin/python
import time
import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import AgglomerativeClustering
from sklearn.neighbors import kneighbors_graph
n_samples = 1500 # Generate sample data
np.random.seed(0)
t = 1.5 * np.pi * (1 + 3 * np.random.rand(1, n_samples))
x = t * np.cos(t)
y = t * np.sin(t)
X = np.concatenate((x, y))
X += 0.7 * np.random.randn(2, n_samples)
X = X.T
# will give more homogeneous clusters to the cost of computation # Create a graph capturing local connectivity. Larger number of neighbors
# cluster sizes, but may not impose the local manifold structure of # time. A very large number of neighbors gives more evenly distributed
knn_graph = kneighbors_graph(X, 30, include_self=False) # the data
for connectivity in (None, knn_graph):
    for n_clusters in (30, 3):
        plt.figure(figsize=(10, 4))
        for index, linkage in enumerate(("average", "complete", "ward", "single")):
            plt.subplot(1, 4, index + 1)
            model = AgglomerativeClustering(linkage=linkage, connectivity=connectivity, n_clusters=n_clusters)
            t0 = time.time()
            model.fit(X)
            elapsed_time = time.time() - t0
            plt.scatter(X[:, 0], X[:, 1], c=model.labels_, cmap=plt.cm.nipy_spectral)
            plt.title("linkage=%s\n(time %.2fs)" % (linkage, elapsed_time), fontdict=dict(verticalalignment="top"))
            plt.axis("equal")
            plt.axis("off")
            plt.subplots_adjust(bottom=0, top=0.89, wspace=0, left=0, right=1)
            plt.suptitle("n_cluster=%i, connectivity=%r" % (n_clusters, connectivity is not None), size=17)
plt.show()

"""
Agglomerative clustering with and without structure
===================================================
This example shows the effect of imposing a connectivity graph to capturelocal structure in the data.
The graph is simply the graph of 20 nearestneighbors.Two consequences of imposing a connectivity can be seen.
First clusteringwith a connectivity matrix is much faster.Second,
	when using a connectivity matrix,
	single,
	average and completelinkage are unstable and tend to create a few clusters that grow veryquickly.
Indeed,
	average and complete linkage fight this percolation behaviorby considering all the distances between two clusters when merging them (while single linkage exaggerates the behaviour by considering only theshortest distance between clusters).
The connectivity graph breaks thismechanism for average and complete linkage,
	making them resemble the morebrittle single linkage.
This effect is more pronounced for very sparse graphs(try decreasing the number of neighbors in kneighbors_graph) and withcomplete linkage.
In particular,
	having a very small number of neighbors inthe graph,
	imposes a geometry that is close to that of single linkage,which is well known to have this percolation instability. """




from time import time
import numpy as np
from scipy import ndimage
from matplotlib import pyplot as plt
from sklearn import manifold, datasets
digits = datasets.load_digits(n_class=10)
X = digits.data
y = digits.target
n_samples, n_features = X.shape
np.random.seed(0)
def nudge_images(X, y):
    # methods, but we multiply the size of the dataset only by 2, as the # Having a larger dataset shows more clearly the behavior of the super-linear in n_samples # cost of the hierarchical clustering methods are strongly
    shift = lambda x: ndimage.shift(x.reshape((8, 8)), 0.3 * np.random.normal(size=2), mode="constant",).ravel()
    X = np.concatenate([X, np.apply_along_axis(shift, 1, X)])
    Y = np.concatenate([y, y], axis=0)
    return X, Y
X, y = nudge_images(X, y)
# Visualize the clustering # ----------------------------------------------------------------------
def plot_clustering(X_red, labels, title=None):
    x_min, x_max = np.min(X_red, axis=0), np.max(X_red, axis=0)
    X_red = (X_red - x_min) / (x_max - x_min)
    plt.figure(figsize=(6, 4))
    for i in range(X_red.shape[0]):
        plt.text(X_red[i, 0], X_red[i, 1], str(y[i]), color=plt.cm.nipy_spectral(labels[i] / 10.0), fontdict={"weight": "bold", "size": 9})
    plt.xticks([])
    plt.yticks([])
    if title is not None:
        plt.title(title, size=17)
    plt.axis("off")
    plt.tight_layout(rect=[0, 0.03, 1, 0.95])
# 2D embedding of the digits dataset # ----------------------------------------------------------------------
print("Computing embedding")
X_red = manifold.SpectralEmbedding(n_components=2).fit_transform(X)
print("Done.")
from sklearn.cluster import AgglomerativeClustering
for linkage in ("ward", "average", "complete", "single"):
    clustering = AgglomerativeClustering(linkage=linkage, n_clusters=10)
    t0 = time()
    clustering.fit(X_red)
    print("%s :\t%.2fs" % (linkage, time() - t0))
    plot_clustering(X_red, clustering.labels_, "%s linkage" % linkage)
plt.show()

"""
=============================================================================
Various Agglomerative Clustering on a 2D embedding of digits
=============================================================================
An illustration of various linkage option for agglomerative clustering ona 2D embedding of the digits dataset.The goal of this example is to show intuitively how the metrics behave,
	andnot to find good clusters for the digits.
This is why the example works on a2D embedding.What this example shows us is the behavior "rich getting richer" ofagglomerative clustering that tends to create uneven cluster sizes.This behavior is pronounced for the average linkage strategy,that ends up with a couple of singleton clusters,
	while in the caseof single linkage we get a single central cluster with all other clustersbeing drawn from noise points around the fringes.
"""
# License: BSD 3 clause (C) INRIA 2014 # Authors: Gael Varoquaux
print(__doc__)




