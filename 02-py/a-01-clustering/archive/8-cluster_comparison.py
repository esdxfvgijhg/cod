#!/usr/bin/python3
import time
import warnings
import numpy as np
import matplotlib.pyplot as plt
from sklearn import cluster, datasets, mixture
from sklearn.neighbors import kneighbors_graph
from sklearn.preprocessing import StandardScaler
from itertools import cycle, islice
np.random.seed(0)
# Generate datasets. We choose the size big enough to see the scalability of the algorithms, but not too big to avoid too long running times
n_samples      = 1500
noisy_circles  = datasets.make_circles(n_samples=n_samples, factor=0.5, noise=0.05)
noisy_moons    = datasets.make_moons(n_samples=n_samples, noise=0.05)
blobs          = datasets.make_blobs(n_samples=n_samples, random_state=8)
no_structure   = np.random.rand(n_samples, 2), None
random_state   = 170 # Anisotropicly distributed data
X, y           = datasets.make_blobs(n_samples=n_samples, random_state=random_state)
transformation = [[0.6, -0.6], [-0.4, 0.8]]
X_aniso        = np.dot(X, transformation)
aniso          = (X_aniso, y)
varied         = datasets.make_blobs(n_samples=n_samples, cluster_std=[1.0, 2.5, 0.5], random_state=random_state) # blobs with varied variances
# Set up cluster parameters
plt.figure(figsize=(9 * 2 + 3, 12.5))
plt.subplots_adjust(left=0.02, right=0.98, bottom=0.001, top=0.96, wspace=0.05, hspace=0.01)
plot_num       = 1
default_base   = {"quantile": 0.3, "eps": 0.3, "damping": 0.9, "preference": -200, "n_neighbors": 10, "n_clusters": 3}
datasets       = [(noisy_circles, {"damping": 0.77, "preference": -240, "quantile": 0.2, "n_clusters": 2}), (noisy_moons, {"damping": 0.75, "preference": -220, "n_clusters": 2}), (varied, {"eps": 0.18, "n_neighbors": 2}), (aniso, {"eps": 0.15, "n_neighbors": 2}), (blobs, {}), (no_structure, {})]

for i_dataset, (dataset, algo_params) in enumerate(datasets):
    params       = default_base.copy() # update parameters with dataset-specific values
    params.update(algo_params)
    X, y         = dataset
    X            = StandardScaler().fit_transform(X) # normalize dataset for easier parameter selection
    bandwidth    = cluster.estimate_bandwidth(X, quantile=params["quantile"]) # estimate bandwidth for mean shift
    connectivity = kneighbors_graph(X, n_neighbors=params["n_neighbors"], include_self=False) # connectivity matrix for structured Ward
    connectivity = 0.5 * (connectivity + connectivity.T) # make connectivity symmetric
    # Create cluster objects # ============
    ms                    = cluster.MeanShift(bandwidth                 =bandwidth, bin_seeding               =True) #                =                                  =             ==========
    two_means             = cluster.MiniBatchKMeans(n_clusters          =params["n_clusters"])                
    ward                  = cluster.AgglomerativeClustering(n_clusters  =params["n_clusters"], linkage        ="ward", connectivity   =connectivity)                     
    spectral              = cluster.SpectralClustering(n_clusters       =params["n_clusters"], eigen_solver   ="arpack", affinity     ="nearest_neighbors")              
    dbscan                = cluster.DBSCAN(eps                          =params["eps"])                       
    affinity_propagation  = cluster.AffinityPropagation(damping         =params["damping"], preference        =params["preference"])  
    average_linkage       = cluster.AgglomerativeClustering(linkage     ="average", affinity                  ="cityblock", n_clusters=params["n_clusters"], connectivity=connectivity)
    birch                 = cluster.Birch(n_clusters                    =params["n_clusters"])                
    gmm                   = mixture.GaussianMixture(n_components        =params["n_clusters"], covariance_type="full")                
    clustering_algorithms=(("MiniBatchKMeans", two_means), ("AffinityPropagation", affinity_propagation), ("MeanShift", ms), ("SpectralClustering", spectral), ("Ward", ward), ("AgglomerativeClustering", average_linkage), ("DBSCAN", dbscan), ("Birch", birch), ("GaussianMixture", gmm))
    for name, algorithm in clustering_algorithms:
        t0 = time.time()
        with warnings.catch_warnings(): # catch warnings related to kneighbors_graph
            warnings.filterwarnings("ignore", message="the number of connected components of the " + "connectivity matrix is [0-9]{1,2}" + " > 1. Completing it to avoid stopping the tree early.", category=UserWarning)
            warnings.filterwarnings("ignore", message="Graph is not fully connected, spectral embedding" + " may not work as expected.", category=UserWarning)
            algorithm.fit(X)
        t1 = time.time()
        if hasattr(algorithm, "labels_"):
            y_pred = algorithm.labels_.astype(np.int)
        else:
            y_pred = algorithm.predict(X)
        plt.subplot(len(datasets), len(clustering_algorithms), plot_num)
        if i_dataset == 0:
            plt.title(name, size=18)
        colors = np.array(list(islice(cycle(["#377eb8", "#ff7f00", "#4daf4a", "#f781bf", "#a65628", "#984ea3", "#999999", "#e41a1c", "#dede00"]), int(max(y_pred) + 1))))
        colors = np.append(colors, ["#000000"]) # add black color for outliers (if any)
        plt.scatter(X[:, 0], X[:, 1], s=10, color=colors[y_pred]);plt.xlim(-2.5, 2.5);plt.ylim(-2.5, 2.5);plt.xticks(());plt.yticks(());plt.text(0.99, 0.01, ("%.2fs" % (t1 - t0)).lstrip("0"), transform=plt.gca().transAxes, size=15, horizontalalignment="right");plot_num += 1
plt.show()

"""
=========================================================
Comparing different clustering algorithms on toy datasets
=========================================================
This example shows characteristics of differentclustering algorithms on datasets that are "interesting"but still in 2D.
With the exception of the last dataset,the parameters of each of these dataset-algorithm pairshas been tuned to produce good clustering results.
Somealgorithms are more sensitive to parameter values thanothers.The last dataset is an example of a 'null' situation forclustering:
	the data is homogeneous,
	and there is no goodclustering.
For this example,
	the null dataset uses thesame parameters as the dataset in the row above it,
	whichrepresents a mismatch in the parameter values and thedata structure.While these examples give some intuition about thealgorithms,
	this intuition might not apply to very highdimensional data.
"""
print(__doc__)



















import numpy as np #!/usr/bin/python
import matplotlib.pyplot as plt
from matplotlib import patches
from sklearn import datasets
from sklearn.mixture import GaussianMixture as GMM
from sklearn.model_selection import StratifiedKFold
iris = datasets.load_iris()  # Load the iris dataset
indices = StratifiedKFold(iris.target)  # Split dataset into training and testing (80/20 split)
train_index, test_index = next(iter(indices))  # Take the first fold
X_train = iris.data[train_index]  # Extract training data and labels
y_train = iris.target[train_index]
X_test = iris.data[test_index]  # Extract testing data and labels
y_test = iris.target[test_index]
num_classes = len(np.unique(y_train))  # Extract the number of classes
classifier = GMM(n_components=num_classes, covariance_type="full", init_params="wc", n_iter=20)  # Build GMM
classifier.means_ = np.array([X_train[y_train == i].mean(axis=0) for i in range(num_classes)])  # Initialize the GMM means
classifier.fit(X_train)  # Train the GMM classifier
plt.figure()  # Draw boundaries
colors = "bgr"
for i, color in enumerate(colors):
    eigenvalues, eigenvectors = np.linalg.eigh(classifier._get_covars()[i][:2, :2])  # Extract eigenvalues and eigenvectors
    norm_vec = eigenvectors[0] / np.linalg.norm(eigenvectors[0])  # Normalize the first eigenvector
    angle = np.arctan2(norm_vec[1], norm_vec[0])  # Extract the angle of tilt
    angle = 180 * angle / np.pi
    scaling_factor = 8  # (random value chosen to suit our needs) # Scaling factor to magnify the ellipses
    eigenvalues *= scaling_factor
    ellipse = patches.Ellipse(classifier.means_[i, :2], eigenvalues[0], eigenvalues[1], 180 + angle, color=color,)  # Draw the ellipse
    axis_handle = plt.subplot(1, 1, 1)
    ellipse.set_clip_box(axis_handle.bbox)
    ellipse.set_alpha(0.6)
    axis_handle.add_artist(ellipse)
colors = "bgr"  # Plot the data
for i, color in enumerate(colors):
    cur_data = iris.data[iris.target == i]
    plt.scatter(
        cur_data[:, 0], cur_data[:, 1], marker="o", facecolors="none", edgecolors="black", s=40, label=iris.target_names[i],
    )
    test_data = X_test[y_test == i]
    plt.scatter(
        test_data[:, 0], test_data[:, 1], marker="s", facecolors="black", edgecolors="black", s=40, label=iris.target_names[i],
    )
y_train_pred = classifier.predict(X_train)  # Compute predictions for training and testing data
accuracy_training = np.mean(y_train_pred.ravel() == y_train.ravel()) * 100
print("Accuracy on training data =", accuracy_training)
y_test_pred = classifier.predict(X_test)
accuracy_testing = np.mean(y_test_pred.ravel() == y_test.ravel()) * 100
print("Accuracy on testing data =", accuracy_testing)
plt.title("GMM classifier")
plt.xticks(())
plt.yticks(())
plt.show()
