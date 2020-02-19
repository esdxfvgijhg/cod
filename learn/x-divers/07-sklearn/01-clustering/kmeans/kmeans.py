#!/usr/bin/python

import numpy as np #!/usr/bin/python
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from sklearn import metrics
X = np.loadtxt("data/X.csv", delimiter=",", skiprows=1)  # Load input data
num_clusters = 3
plt.figure(); plt.scatter(X[:, 0], X[:, 2], marker="o", facecolors="none", edgecolors="black", s=80)
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
plt.title("Input data");plt.xlim(x_min, x_max);plt.ylim(y_min, y_max);plt.xticks(());plt.yticks(())
kmeans = KMeans(init="k-means++", n_clusters=num_clusters, n_init=10)
kmeans.fit(X)
cluster_centers = kmeans.cluster_centers_
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1  # Define the grid of points to plot the boundaries # 
step_size = 0.01  # Step size of the mesh
x_vals, y_vals = np.meshgrid(np.arange(x_min, x_max, step_size), np.arange(y_min, y_max, step_size)) # 
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
output = kmeans.predict(np.c_[x_vals.ravel(), y_vals.ravel()])  # Predict output labels for all the points on the grid
#output = output.reshape(x_vals.shape)  # Plot different regions and color them # 
plt.clf(); plt.figure(); plt.scatter(X[:, 0], X[:, 1], marker="o", facecolors="none", edgecolors="black", s=80); plt.imshow(output, interpolation="nearest", extent=(x_vals.min(), x_vals.max(), y_vals.min(), y_vals.max()), cmap=plt.cm.Paired, aspect="auto", origin="lower",); plt.scatter(cluster_centers[:, 0], cluster_centers[:, 1], marker="o", s=210, linewidths=4, color="black", zorder=12, facecolors="black",) #
cluster_centers = kmeans.cluster_centers_  # Plot the centers of clusters
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1 # 
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
plt.xlim(x_min, x_max); plt.title("Boundaries of clusters");plt.xticks(()); plt.ylim(y_min, y_max);plt.show(); plt.yticks(())



import numpy as np #!/usr/bin/python
import matplotlib.pyplot as plt
from sklearn.cluster import KMeans
from sklearn import metrics
X = np.loadtxt("data/X.csv", delimiter=",",skiprows=1)  # Load input data
num_clusters = 5
plt.figure(); plt.scatter(X[:, 0], X[:, 1], marker="o", facecolors="none", edgecolors="black", s=80)
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
plt.title("Input data"); plt.xlim(x_min, x_max); plt.ylim(y_min, y_max); plt.xticks(()); plt.yticks(())
kmeans = KMeans(init="k-means++", n_clusters=num_clusters, n_init=10)  # Create KMeans object
kmeans.fit(X)  # Train the KMeans clustering model
step_size = 0.01  # Step size of the mesh
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1  # Define the grid of points to plot the boundaries
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
x_vals, y_vals = np.meshgrid(np.arange(x_min, x_max, step_size), np.arange(y_min, y_max, step_size))
output = kmeans.predict(np.c_[x_vals.ravel(), y_vals.ravel()])  # Predict output labels for all the points on the grid
output = output.reshape(x_vals.shape)  # Plot different regions and color them
plt.figure(); plt.clf(); plt.imshow(output, interpolation="nearest", extent=(x_vals.min(), x_vals.max(), y_vals.min(), y_vals.max()), cmap=plt.cm.Paired, aspect="auto", origin="lower",); plt.scatter(X[:, 0], X[:, 1], marker="o", facecolors="none", edgecolors="black", s=80)  # Overlay input points
cluster_centers = kmeans.cluster_centers_  # Plot the centers of clusters
plt.scatter(cluster_centers[:, 0], cluster_centers[:, 1], marker="o", s=210, linewidths=4, color="black", zorder=12, facecolors="black",)
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
plt.title("Boundaries of clusters");plt.xlim(x_min, x_max);plt.ylim(y_min, y_max);plt.xticks(());plt.yticks(());plt.show()



