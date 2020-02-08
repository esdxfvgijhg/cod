#!/usr/bin/python
import numpy as np
from matplotlib import pyplot as plt
from sklearn.datasets import make_checkerboard
from sklearn.datasets import samples_generator as sg
from sklearn.cluster.bicluster import SpectralBiclustering
from sklearn.metrics import consensus_score
n_clusters = (4, 3)
data, rows, columns = make_checkerboard(shape=(300, 300), n_clusters=n_clusters, noise=10, shuffle=False, random_state=0)
plt.matshow(data, cmap=plt.cm.Blues)
plt.title("Original dataset")
data, row_idx, col_idx = sg._shuffle(data, random_state=0)
plt.matshow(data, cmap=plt.cm.Blues)
plt.title("Shuffled dataset")
model = SpectralBiclustering(n_clusters=n_clusters, method="log", random_state=0)
model.fit(data)
score = consensus_score(model.biclusters_, (rows[:, row_idx], columns[:, col_idx]))
print("consensus score: {:.1f}".format(score))
fit_data = data[np.argsort(model.row_labels_)]
fit_data = fit_data[:, np.argsort(model.column_labels_)]
plt.matshow(fit_data, cmap=plt.cm.Blues)
plt.title("After biclustering; rearranged to show biclusters")
plt.matshow(np.outer(np.sort(model.row_labels_) + 1, np.sort(model.column_labels_) + 1), cmap=plt.cm.Blues)
plt.title("Checkerboard structure of rearranged data")
plt.show()

"""
=============================================
A demo of the Spectral Biclustering algorithm
=============================================
This example demonstrates how to generate a checkerboard dataset andbicluster it using the Spectral Biclustering algorithm.The data is generated with the ``make_checkerboard`` function,
	thenshuffled and passed to the Spectral Biclustering algorithm.
The rowsand columns of the shuffled matrix are rearranged to show thebiclusters found by the algorithm.The outer product of the row and column label vectors shows arepresentation of the checkerboard structure.
"""
print(__doc__)


import numpy as np
from matplotlib import pyplot as plt
from sklearn.datasets import make_biclusters
from sklearn.datasets import samples_generator as sg
from sklearn.cluster.bicluster import SpectralCoclustering
from sklearn.metrics import consensus_score
n_clusters = (4, 3)
data, rows, columns = make_biclusters(shape=(300, 300), n_clusters=5, noise=5, shuffle=False, random_state=0)
plt.matshow(data, cmap=plt.cm.Blues)
plt.title("Original dataset")
data, row_idx, col_idx = sg._shuffle(data, random_state=0)
plt.matshow(data, cmap=plt.cm.Blues)
plt.title("Shuffled dataset")
model = SpectralCoclustering(n_clusters=5, random_state=0)
model.fit(data)
score = consensus_score(model.biclusters_, (rows[:, row_idx], columns[:, col_idx]))
print("consensus score: {:.3f}".format(score))
fit_data = data[np.argsort(model.row_labels_)]
fit_data = fit_data[:, np.argsort(model.column_labels_)]
plt.matshow(fit_data, cmap=plt.cm.Blues)
plt.title("After biclustering; rearranged to show biclusters")
plt.show()

"""
==============================================
A demo of the Spectral Co-Clustering algorithm
==============================================
This example demonstrates how to generate a dataset and bicluster itusing the Spectral Co-Clustering algorithm.The dataset is generated using the ``make_biclusters`` function,
	whichcreates a matrix of small values and implants bicluster with largevalues.
The rows and columns are then shuffled and passed to theSpectral Co-Clustering algorithm.
Rearranging the shuffled matrix tomake biclusters contiguous shows how accurately the algorithm foundthe biclusters.
"""
print(__doc__)






#!/usr/bin/python3

from collections import defaultdict
import operator
from time import time
import numpy as np
from sklearn.cluster.bicluster import SpectralCoclustering
from sklearn.cluster import MiniBatchKMeans
from sklearn.datasets.twenty_newsgroups import fetch_20newsgroups
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.cluster import v_measure_score

def number_normalizer(tokens):
    """ Map all numeric tokens to a placeholder.For many applications, tokens that begin with a number are not directly useful, but the fact that such a token exists can be relevant.  By applying this form of dimensionality reduction, some methods may perform better."""
    return ("#NUMBER" if token[0].isdigit() else token for token in tokens)
class NumberNormalizingVectorizer(TfidfVectorizer):
    def build_tokenizer(self):
        tokenize = super().build_tokenizer()
        return lambda doc: list(number_normalizer(tokenize(doc)))
categories = ["alt.atheism", "comp.graphics", "comp.sys.ibm.pc.hardware", "comp.sys.mac.hardware", "comp.windows.x", "misc.forsale", "rec.autos", "rec.motorcycles", "rec.sport.baseball", "rec.sport.hockey", "sci.crypt", "sci.electronics", "sci.med", "sci.space", "soc.religion.christian", "talk.politics.guns", "talk.politics.mideast", "talk.politics.misc", "talk.religion.misc"] # exclude 'comp.os.ms-windows.misc'
newsgroups = fetch_20newsgroups(categories=categories)
y_true = newsgroups.target
vectorizer = NumberNormalizingVectorizer(stop_words="english", min_df=5)
cocluster = SpectralCoclustering(n_clusters=len(categories), svd_method="arpack", random_state=0)
kmeans = MiniBatchKMeans(n_clusters=len(categories), batch_size=20000, random_state=0)
print("Vectorizing...")
X = vectorizer.fit_transform(newsgroups.data)
print("Coclustering...")
start_time = time()
cocluster.fit(X)
y_cocluster = cocluster.row_labels_
print("Done in {:.2f}s. V-measure: {:.4f}".format(time() - start_time, v_measure_score(y_cocluster, y_true)))
print("MiniBatchKMeans...")
start_time = time()
y_kmeans = kmeans.fit_predict(X)
print("Done in {:.2f}s. V-measure: {:.4f}".format(time() - start_time, v_measure_score(y_kmeans, y_true)))
feature_names = vectorizer.get_feature_names()
document_names = list(newsgroups.target_names[i] for i in newsgroups.target)
def bicluster_ncut(i):
    rows, cols = cocluster.get_indices(i)
    if not (np.any(rows) and np.any(cols)):
        import sys
        return sys.float_info.max
    row_complement = np.nonzero(np.logical_not(cocluster.rows_[i]))[0]
    col_complement = np.nonzero(np.logical_not(cocluster.columns_[i]))[0]
    # cols].sum() but much faster in scipy <= 0.16 # Note: the following is identical to X[rows[:, np.newaxis],
    weight = X[rows][:, cols].sum()
    cut = X[row_complement][:, cols].sum() + X[rows][:, col_complement].sum()
    return cut / weight
def most_common(d):
    """Items of a defaultdict(int) with the highest values. Like Counter.most_common in Python >=2.7."""
    return sorted(d.items(), key=operator.itemgetter(1), reverse=True)
bicluster_ncuts = list(bicluster_ncut(i) for i in range(len(newsgroups.target_names)))
best_idx = np.argsort(bicluster_ncuts)[:5]
print()
print("Best biclusters:")
print("----------------")
for idx, cluster in enumerate(best_idx):
    n_rows, n_cols = cocluster.get_shape(cluster)
    cluster_docs, cluster_words = cocluster.get_indices(cluster)
    if not len(cluster_docs) or not len(cluster_words):
        continue
    counter = defaultdict(int) # categories
    for i in cluster_docs:
        counter[document_names[i]] += 1
    cat_string          = ", ".join("{:.0f}% {}".format(float(c) / n_rows * 100, name) for name, c in most_common(counter)[:3])
    out_of_cluster_docs = cocluster.row_labels_ != cluster # words
    out_of_cluster_docs = np.where(out_of_cluster_docs)[0]
    word_col            = X[:, cluster_words]
    word_scores         = np.array(word_col[cluster_docs, :].sum(axis=0) - word_col[out_of_cluster_docs, :].sum(axis=0))
    word_scores         = word_scores.ravel()
    important_words     = list(feature_names[cluster_words[i]] for i in word_scores.argsort()[:-11:-1])
    print("bicluster {} : {} documents, {} words".format(idx, n_rows, n_cols))
    print("categories   : {}".format(cat_string))
    print("words        : {}\n".format(", ".join(important_words)))
    
"""
================================================================
Biclustering documents with the Spectral Co-clustering algorithm
================================================================
This example demonstrates the Spectral Co-clustering algorithm on thetwenty newsgroups dataset.
The 'comp.os.ms-windows.misc' category isexcluded because it contains many posts containing nothing but data.The TF-IDF vectorized posts form a word frequency matrix,
	which isthen biclustered using Dhillon's Spectral Co-Clustering algorithm.
Theresulting document-word biclusters indicate subsets words used moreoften in those subsets documents.For a few of the best biclusters,
	its most common document categoriesand its ten most important words get printed.
The best biclusters aredetermined by their normalized cut.
The best words are determined bycomparing their sums inside and outside the bicluster.For comparison,
	the documents are also clustered usingMiniBatchKMeans.
The document clusters derived from the biclustersachieve a better V-measure than clusters found by MiniBatchKMeans.
"""
print(__doc__)


#!/usr/bin/python

from itertools import cycle
from time import time
import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors as colors
from sklearn.cluster import Birch, MiniBatchKMeans
from sklearn.datasets.samples_generator import make_blobs
xx        = np.linspace(-22, 22, 10) # Generate centers for the blobs so that it forms a 10 X 10 grid.
yy        = np.linspace(-22, 22, 10)
xx, yy    = np.meshgrid(xx, yy)
n_centres = np.hstack((np.ravel(xx)[:, np.newaxis], np.ravel(yy)[:, np.newaxis]))
X, y      = make_blobs(n_samples=100000, centers=n_centres, random_state=0) # Generate blobs to do a comparison between MiniBatchKMeans and Birch.
print(X)
dataset  = "data/X.csv"
loraData = np.genfromtxt(dataset, delimiter=",", dtype="str", skip_header=1)  # load the CSV file as a numpy matrix
X        = loraData[:, 0:3].astype(int)
print(X)
colors_ = cycle(colors.cnames.keys()) # Use all colors that matplotlib provides by default.
fig     = plt.figure(figsize=(12, 4))
fig.subplots_adjust(left=0.04, right=0.98, bottom=0.1, top=0.9)
# and plot. # Compute clustering with Birch with and without the final clustering step
birch_models = [Birch(threshold=1.7, n_clusters=None), Birch(threshold=1.7, n_clusters=100)]
final_step = ["without global clustering", "with global clustering"]
for ind, (birch_model, info) in enumerate(zip(birch_models, final_step)):
    t = time()
    birch_model.fit(X)
    time_ = time() - t
    print("Birch %s as the final step took %0.2f seconds" % (info, (time() - t)))
    labels = birch_model.labels_ # Plot result
    centroids = birch_model.subcluster_centers_
    n_clusters = np.unique(labels).size
    print("n_clusters : %d" % n_clusters)
    ax = fig.add_subplot(1, 3, ind + 1)
    for this_centroid, k, col in zip(centroids, range(n_clusters), colors_):
        mask = labels == k
        ax.scatter(X[mask, 0], X[mask, 1], c="w", edgecolor=col, marker=".", alpha=0.5)
        if birch_model.n_clusters is None:
            ax.scatter(this_centroid[0], this_centroid[1], marker="+", c="k", s=25)
    ax.set_ylim([-25, 25]);ax.set_xlim([-25, 25]);ax.set_autoscaley_on(False);ax.set_title("Birch %s" % info)
mbk = MiniBatchKMeans(init="k-means++", n_clusters=100, batch_size=100, n_init=10, max_no_improvement=10, verbose=0, random_state=0) # Compute clustering with MiniBatchKMeans.
t0 = time()
mbk.fit(X)
t_mini_batch = time() - t0
print("Time taken to run MiniBatchKMeans %0.2f seconds" % t_mini_batch)
mbk_means_labels_unique = np.unique(mbk.labels_)
ax = fig.add_subplot(1, 3, 3)
for this_centroid, k, col in zip(mbk.cluster_centers_, range(n_clusters), colors_):
    mask = mbk.labels_ == k
    ax.scatter(X[mask, 0], X[mask, 1], marker=".", c="w", edgecolor=col, alpha=0.5);ax.scatter(this_centroid[0], this_centroid[1], marker="+", c="k", s=25)
ax.set_xlim([-25, 25]);ax.set_ylim([-25, 25]);ax.set_title("MiniBatchKMeans");ax.set_autoscaley_on(False)
plt.show()


"""
=================================
Compare BIRCH and MiniBatchKMeans
=================================
This example compares the timing of Birch (with and without the global
clustering step) and MiniBatchKMeans on a synthetic dataset having
100,000 samples and 2 features generated using make_blobs.
If ``n_clusters`` is set to None, the data is reduced from 100,000
samples to a set of 158 clusters. This can be viewed as a preprocessing
step before the final (global) clustering step that further reduces these
158 clusters to 100 clusters.
"""

print(__doc__) # License: BSD 3 clause

