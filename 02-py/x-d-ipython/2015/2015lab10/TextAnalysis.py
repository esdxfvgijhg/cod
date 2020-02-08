#!/usr/bin/env python
# coding: utf-8

# # BOW model and Naive Bayes

# In[1]:


get_ipython().magic(u'matplotlib inline')
import numpy as np
import scipy as sp
import matplotlib as mpl
import matplotlib.cm as cm
import matplotlib.pyplot as plt
import pandas as pd
pd.set_option('display.width', 500)
pd.set_option('display.max_columns', 100)
pd.set_option('display.notebook_repr_html', True)
import seaborn as sns
sns.set_style("whitegrid")
sns.set_context("poster")


# #Table of Contents
# * [BOW model and Naive Bayes](#BOW-model-and-Naive-Bayes)
# 	* [Rotten Tomatoes data set](#Rotten-Tomatoes-data-set)
# 		* [Explore](#Explore)
# 	* [The Vector space model and a search engine.](#The-Vector-space-model-and-a-search-engine.)
# 		* [In Code](#In-Code)
# 	* [Naive Bayes](#Naive-Bayes)
# 		* [Cross-Validation and hyper-parameter fitting](#Cross-Validation-and-hyper-parameter-fitting)
# 		* [Work with the best params](#Work-with-the-best-params)
# 	* [Interpretation](#Interpretation)
# 	* [Callibration](#Callibration)
# 	* [To improve:](#To-improve:)
# 

# ##Rotten Tomatoes data set

# In[2]:


critics = pd.read_csv('./critics.csv')
#let's drop rows with missing quotes
critics = critics[~critics.quote.isnull()]
critics.head()


# ###Explore

# In[3]:


n_reviews = len(critics)
n_movies = critics.rtid.unique().size
n_critics = critics.critic.unique().size


print "Number of reviews: %i" % n_reviews
print "Number of critics: %i" % n_critics
print "Number of movies:  %i" % n_movies


# In[4]:


df = critics.copy()
df['fresh'] = df.fresh == 'fresh'
grp = df.groupby('critic')
counts = grp.critic.count()  # number of reviews by each critic
means = grp.fresh.mean()     # average freshness for each critic

means[counts > 100].hist(bins=10, edgecolor='w', lw=1)
plt.xlabel("Average rating per critic")
plt.ylabel("N")
plt.yticks([0, 2, 4, 6, 8, 10]);


# ##The Vector space model and a search engine.

# All the diagrams here are snipped from
# See http://nlp.stanford.edu/IR-book/ which is a great resource on Text processing.
# 
# Also check out Python packages nltk, spacy, and pattern, and their associated resources.
# 
# Let us define the vector derived from document d by $\bar V(d)$. What does this mean? Each document is considered to be a vector made up from a vocabulary, where there is one axis for each term in the vocabulary.
# 
# To define the vocabulary, we take a union of all words we have seen in all documents. We then just associate an array index with them. So "hello" may be at index 5 and "world" at index 99.
# 
# Then the document
# 
# "hello world world"
# 
# would be indexed as
# 
# `[(5,1),(99,2)]`
# 
# along with a dictionary
# 
# ``
# 5: Hello
# 99: World
# ``
# 
# so that you can see that our representation is one of a sparse array.
# 
# Then, a set of documents becomes, in the usual `sklearn` style, a sparse matrix with rows being sparse arrays and columns "being" the features, ie the vocabulary. I put "being" in quites as the layout in memort is that of a matrix with many 0's, but, rather, we use the sparse representation we talked about above.
# 
# Notice that this representation loses the relative ordering of the terms in the document. That is "cat ate rat" and "rat ate cat" are the same. Thus, this representation is also known as the Bag-Of-Words representation.
# 
# Here is another example, from the book quoted above, although the matrix is transposed here so that documents are columns:
# 
# ![novel terms](terms.png)
# 
# Such a matrix is also catted a Term-Document Matrix. Here, the terms being indexed could be stemmed before indexing; for instance, jealous and jealousy after stemming are the same feature. One could also make use of other "Natural Language Processing" transformations in constructing the vocabulary. We could use Lemmatization, which reduces words to lemmas: work, working, worked would all reduce to work. We could remove "stopwords" from our vocabulary, such as common words like "the". We could look for particular parts of speech, such as adjectives. This is often done in Sentiment Analysis. And so on. It all deoends on our application.
# 
# From the book:
# >The standard way of quantifying the similarity between two documents $d_1$ and $d_2$  is to compute the cosine similarity of their vector representations $\bar V(d_1)$ and $\bar V(d_2)$:
# 
# $$S_{12} = \frac{\bar V(d_1) \cdot \bar V(d_2)}{|\bar V(d_1)| \times |\bar V(d_2)|}$$
# 
# ![Vector Space Model](vsm.png)
# 
# 
# >There is a far more compelling reason to represent documents as vectors: we can also view a query as a vector. Consider the query q = jealous gossip. This query turns into the unit vector $\bar V(q)$ = (0, 0.707, 0.707) on the three coordinates below. 
# 
# ![novel terms](terms2.png)
# 
# >The key idea now: to assign to each document d a score equal to the dot product:
# 
# $$\bar V(q) \cdot \bar V(d)$$
# 
# This we can use this simple Vector Model as a Search engine.

# ###In Code

# In[5]:


from sklearn.feature_extraction.text import CountVectorizer

text = ['Hop on pop', 'Hop off pop', 'Hop Hop hop']
print "Original text is\n", '\n'.join(text)

vectorizer = CountVectorizer(min_df=0)

# call `fit` to build the vocabulary
vectorizer.fit(text)

# call `transform` to convert text to a bag of words
x = vectorizer.transform(text)

# CountVectorizer uses a sparse array to save memory, but it's easier in this assignment to 
# convert back to a "normal" numpy array
x = x.toarray()

print
print "Transformed text vector is \n", x

# `get_feature_names` tracks which word is associated with each column of the transformed x
print
print "Words for each feature:"
print vectorizer.get_feature_names()

# Notice that the bag of words treatment doesn't preserve information about the *order* of words, 
# just their frequency


# In[6]:


def make_xy(critics, vectorizer=None):
    #Your code here    
    if vectorizer is None:
        vectorizer = CountVectorizer()
    X = vectorizer.fit_transform(critics.quote)
    X = X.tocsc()  # some versions of sklearn return COO format
    y = (critics.fresh == 'fresh').values.astype(np.int)
    return X, y
X, y = make_xy(critics)


# ##Naive Bayes

# This discussion follows that of HW3 in 2013's cs109 class.
# 
# $$P(c|d) \propto P(d|c) P(c) $$
# 
# $$P(d|c)  = \prod_k P(t_k | c) $$
# 
# the conditional independence assumption.
# 
# Then we see that for which c is $P(c|d)$ higher.
# 
# For floating point underflow we change the product into a sum by going into log space. So:
# 
# $$log(P(d|c))  = \sum_k log (P(t_k | c)) $$
# 
# But we must also handle non-existent terms, we cant have 0's for them:
# 
# $$P(t_k|c) = \frac{N_{kc}+\alpha}{N_c+\alpha N_{feat}}$$

# In[7]:


from sklearn.naive_bayes import MultinomialNB
from sklearn.cross_validation import train_test_split
xtrain, xtest, ytrain, ytest = train_test_split(X, y)
clf = MultinomialNB().fit(xtrain, ytrain)
print "MN Accuracy: %0.2f%%" % (100 * clf.score(xtest, ytest))


# In[8]:


training_accuracy = clf.score(xtrain, ytrain)
test_accuracy = clf.score(xtest, ytest)

print "Accuracy on training data: %0.2f" % (training_accuracy)
print "Accuracy on test data:     %0.2f" % (test_accuracy)


# Clearly this is an overfit classifier.

# ###Cross-Validation and hyper-parameter fitting

# We use `KFold` instead of `GridSearchCV` here as we will want to also set parameters in the CountVectorizer.

# In[9]:


from sklearn.cross_validation import KFold
def cv_score(clf, X, y, scorefunc):
    result = 0.
    nfold = 5
    for train, test in KFold(y.size, nfold): # split data into train/test groups, 5 times
        clf.fit(X[train], y[train]) # fit
        result += scorefunc(clf, X[test], y[test]) # evaluate score function on held-out data
    return result / nfold # average


# We use the log-likelihood as the score here. Remember how in HW3 we were able to set different scores in `do_classify`. We do the same thing explicitly here in `scorefunc`. Indeed, what we do in `cv_score` above is to implement the cross-validation part of `GridSearchCV`.
# 
# Since Naive Bayes classifiers are often used in asymmetric situations, it might help to actually maximize probability on the validation folds rather than just accuracy.
# 
# Notice something else about using a custom score function. It allows us to do a lot of the choices with the Decision risk we care about (-profit for example) directly on the validation set, rather than comparing ROC curves on the test set as we did in HW3. You will often find people using `roc_auc`, precision, recall, or `F1-score` as risks or scores.

# In[10]:


def log_likelihood(clf, x, y):
    prob = clf.predict_log_proba(x)
    rotten = y == 0
    fresh = ~rotten
    return prob[rotten, 0].sum() + prob[fresh, 1].sum()


# We'll cross-validate over the regularization parameter $\alpha$ and the `min_df` of the `CountVectorizer`.
# 
# >min_df: When building the vocabulary ignore terms that have a document frequency strictly lower than the given threshold. This value is also called cut-off in the literature. If float, the parameter represents a proportion of documents, integer absolute counts. This parameter is ignored if vocabulary is not None.

# Lets set up the train and test masks first:

# In[11]:


from sklearn.cross_validation import train_test_split
itrain, itest = train_test_split(xrange(critics.shape[0]), train_size=0.7)
mask=np.ones(critics.shape[0], dtype='int')
mask[itrain]=1
mask[itest]=0
mask = (mask==1)


# In[12]:


#the grid of parameters to search over
alphas = [0, .1, 1, 5, 10, 50]
min_dfs = [1e-5, 1e-4, 1e-3, 1e-2, 1e-1]

#Find the best value for alpha and min_df, and the best classifier
best_alpha = None
best_min_df = None
maxscore=-np.inf
for alpha in alphas:
    for min_df in min_dfs:         
        vectorizer = CountVectorizer(min_df = min_df)       
        Xthis, ythis = make_xy(critics, vectorizer)
        Xtrainthis=Xthis[mask]
        ytrainthis=ythis[mask]
        #your code here
        clf = MultinomialNB(alpha=alpha)
        cvscore = cv_score(clf, Xtrainthis, ytrainthis, log_likelihood)

        if cvscore > maxscore:
            maxscore = cvscore
            best_alpha, best_min_df = alpha, min_df


# In[13]:


print "alpha: %f" % best_alpha
print "min_df: %f" % best_min_df


# ###Work with the best params

# In[14]:


vectorizer = CountVectorizer(min_df=best_min_df)
X, y = make_xy(critics, vectorizer)
xtrain=X[mask]
ytrain=y[mask]
xtest=X[~mask]
ytest=y[~mask]

clf = MultinomialNB(alpha=best_alpha).fit(xtrain, ytrain)

# Your code here. Print the accuracy on the test and training dataset
training_accuracy = clf.score(xtrain, ytrain)
test_accuracy = clf.score(xtest, ytest)

print "Accuracy on training data: %0.2f" % (training_accuracy)
print "Accuracy on test data:     %0.2f" % (test_accuracy)


# We might be less accurate bit we are certainly not overfit.

# In[15]:


from sklearn.metrics import confusion_matrix
print confusion_matrix(ytest, clf.predict(xtest))


# ##Interpretation

# What are the strongly predictive features?

# In[16]:


words = np.array(vectorizer.get_feature_names())

x = np.eye(xtest.shape[1])
probs = clf.predict_log_proba(x)[:, 0]
ind = np.argsort(probs)

good_words = words[ind[:10]]
bad_words = words[ind[-10:]]

good_prob = probs[ind[:10]]
bad_prob = probs[ind[-10:]]

print "Good words\t     P(fresh | word)"
for w, p in zip(good_words, good_prob):
    print "%20s" % w, "%0.2f" % (1 - np.exp(p))
    
print "Bad words\t     P(fresh | word)"
for w, p in zip(bad_words, bad_prob):
    print "%20s" % w, "%0.2f" % (1 - np.exp(p))


# We can see mis-predictions as well.

# In[17]:


x, y = make_xy(critics, vectorizer)

prob = clf.predict_proba(x)[:, 0]
predict = clf.predict(x)

bad_rotten = np.argsort(prob[y == 0])[:5]
bad_fresh = np.argsort(prob[y == 1])[-5:]

print "Mis-predicted Rotten quotes"
print '---------------------------'
for row in bad_rotten:
    print critics[y == 0].quote.irow(row)
    print

print "Mis-predicted Fresh quotes"
print '--------------------------'
for row in bad_fresh:
    print critics[y == 1].quote.irow(row)
    print


# In[18]:


clf.predict_proba(vectorizer.transform(['This movie is not remarkable, touching, or superb in any way']))


# ## Callibration

# Probabilistic models like the Naive Bayes classifier have the nice property that they compute probabilities of a particular classification -- the predict_proba and predict_log_proba methods of MultinomialNB compute these probabilities.
# 
# You should always assess whether these probabilities are calibrated -- that is, whether a prediction made with a confidence of x% is correct approximately x% of the time.
# 
# Let's make a plot to assess model calibration. Schematically, we want something like this:
# 
# ![callibration](callibration.png)
# 
# In words, we want to:
# 
# - Take a collection of examples, and compute the freshness probability for each using clf.predict_proba
# - Gather examples into bins of similar freshness probability (the diagram shows 5 groups -- you should use something closer to 20)
# - For each bin, count the number of examples in that bin, and compute the fraction of examples in the bin which are fresh
# - In the upper plot, graph the expected P(Fresh) (x axis) and observed freshness fraction (Y axis). Estimate the uncertainty in observed freshness fraction F via the equation 
# 
# $$\sigma = \sqrt{\frac{F(1-F)}{N}}$$
# 
# - Overplot the line y=x. This is the trend we would expect if the model is perfectly calibrated
# - In the lower plot, show the number of examples in each bin

# In[19]:


"""
Function
--------
calibration_plot

Builds a plot like the one above, from a classifier and review data

Inputs
-------
clf : Classifier object
    A MultinomialNB classifier
X : (Nexample, Nfeature) array
    The bag-of-words data
Y : (Nexample) integer array
    1 if a review is Fresh
"""    
#your code here

def calibration_plot(clf, xtest, ytest):
    prob = clf.predict_proba(xtest)[:, 1]
    outcome = ytest
    data = pd.DataFrame(dict(prob=prob, outcome=outcome))

    #group outcomes into bins of similar probability
    bins = np.linspace(0, 1, 20)
    cuts = pd.cut(prob, bins)
    binwidth = bins[1] - bins[0]
    
    #freshness ratio and number of examples in each bin
    cal = data.groupby(cuts).outcome.agg(['mean', 'count'])
    cal['pmid'] = (bins[:-1] + bins[1:]) / 2
    cal['sig'] = np.sqrt(cal.pmid * (1 - cal.pmid) / cal['count'])
        
    #the calibration plot
    ax = plt.subplot2grid((3, 1), (0, 0), rowspan=2)
    p = plt.errorbar(cal.pmid, cal['mean'], cal['sig'])
    plt.plot(cal.pmid, cal.pmid, linestyle='--', lw=1, color='k')
    plt.ylabel("Empirical P(Fresh)")
    
    #the distribution of P(fresh)
    ax = plt.subplot2grid((3, 1), (2, 0), sharex=ax)
    
    plt.bar(left=cal.pmid - binwidth / 2, height=cal['count'],
            width=.95 * (bins[1] - bins[0]),
            fc=p[0].get_color())
    
    plt.xlabel("Predicted P(Fresh)")
    plt.ylabel("Number")


# In[20]:


calibration_plot(clf, xtest, ytest)


# The model is still slightly over-confident when making low P(Fresh) predictions. However, the calibration plot shows the model is usually within 1 error bar of the expected performance where P(Fresh) >= 0.2. Finally, the model makes less-conclusive predictions on average -- the histogram in the calibration plot is more uniformly distributed, with fewer predictions clustered around P(Fresh) = 0 or 1.
# 
# To think about/play with: What would happen if you tried this again using a function besides the log-likelihood -- for example, the classification accuracy?

# ##To improve:

# There are many things worth trying. Some examples:
# 
# - You could try to build a NB model where the features are word pairs instead of words. This would be smart enough to realize that "not good" and "so good" mean very different things. This technique doesn't scale very well, since these features are much more sparse (and hence harder to detect repeatable patterns within).
# - You could try a model besides NB, that would allow for interactions between words -- for example, a Random Forest classifier.
# - You could consider adding supplemental features -- information about genre, director, cast, etc.
# - You could build a visualization that prints word reviews, and visually encodes each word with size or color to indicate how that word contributes to P(Fresh). For example, really bad words could show up as big and red, good words as big and green, common words as small and grey, etc.

# ### Better features
# 
# We could use TF-IDF instead. What is this? It stands for 
# 
# `Term-Frequency X Inverse Document Frequency`.
# 
# In the standard `CountVectorizer` model above, we used just the term frequency in a document of words in our vocabulary. In TF-IDF, we weigh this term frequency by the inverse of its popularity in all document. For example, if the word "movie" showed up in all the documents, it would not have much predictive value. By weighing its counts by 1 divides by its overall frequency, we down-weight it. We can then use this tfidf weighted features as inputs to any classifier.

# In[21]:


#http://scikit-learn.org/dev/modules/feature_extraction.html#text-feature-extraction
#http://scikit-learn.org/dev/modules/classes.html#text-feature-extraction-ref
from sklearn.feature_extraction.text import TfidfVectorizer
tfidfvectorizer = TfidfVectorizer(min_df=1, stop_words='english')
Xtfidf=tfidfvectorizer.fit_transform(critics.quote)


# In[22]:


Xtfidf[0].toarray()


# In[23]:


Xtfidf.shape


# ## Clustering

# We can do an unsupervized learning analysis of text as well. Algorithms like LDA are especially good for this purpose. we use the gensim library for this purpose. 
# 
# Install it with conda, not with pip.
# 
# `$ conda install gensim`
# 
# on the command line.

# In[24]:


import gensim


# In[25]:


vectorizer = CountVectorizer(min_df=1, stop_words='english')
X=vectorizer.fit_transform(critics.quote)


# In[26]:


corpus=vectorizer.get_feature_names()
id2words = dict((v, k) for k, v in vectorizer.vocabulary_.iteritems())
corpus_gensim = gensim.matutils.Sparse2Corpus(X, documents_columns=False)


# In[27]:


lda = gensim.models.ldamodel.LdaModel(corpus_gensim, id2word=id2words, num_topics=5, update_every=1, chunksize=1000, passes=1)


# In[29]:


lda.print_topics()


# We can see how each document fits in with the topics. You will see this in the homework.

# ###Generative Models redux.
# 
# LDA is a generative model.
# 
# When we talked about generative models earlier, we said that we'd need to model P(x|y), the features belonging to one class. And in general, we might want to model the input feature distribution P(x). How do we solve either of these problems? These fall under the rubric of density estimation.

# ### Density estimation and Unsupervized learning
# 
# $$
# \renewcommand{\like}{{\cal L}}
# \renewcommand{\loglike}{{\ell}}
# \renewcommand{\err}{{\cal E}}
# \renewcommand{\dat}{{\cal D}}
# \renewcommand{\hyp}{{\cal H}}
# \renewcommand{\Ex}[2]{E_{#1}[#2]}
# \renewcommand{\x}{{\mathbf x}}
# \renewcommand{\v}[1]{{\mathbf #1}}
# $$
# 
# The basic idea in unsupervised learning is to find a compact representation of the data $\{\v{x}_1, \v{x}_2, ..., \v{x}_n\}$, whether these $\v{x}$ come from a class conditional probability distribution like those for males or females, or from all the samples. In other words, we are trying to *estimate a feature distribution* in one case or the other. This is, of course the fundamental problem of statistics, the estimation of probability distributions from data. 
# 
# We saw an example of this where we used the maximum likelihood method in logistic regression. There we were trying to estimate $P(y|\v{x}, \v{w})$, a 1-D distribution in y, by finding the most appropriate parameters $\v{w}$. Here we are trying to find some parametrization $\theta_y$ for $P(x|y, \theta_y)$ or $\v{\theta}$ in general for $P(x)$. 
# 
# But the basic method we will use remains the same: find the maximum likelihood, or, choose some probability distributions with parameters $\v{\theta}$, find the probability of each point of data if the data had come from this distribution, multiply these probabilities, and maximize the whole thing with respect to the parameters. (Equivalently we minimize the risk defined as the negative of the log-likelihood). 
# 
# Consider our heights and weights problem again. Suppose I did not tell you the labels: ie which samples were males and which samples were females. The data would then look like this:

# In[30]:


df=pd.read_csv("https://dl.dropboxusercontent.com/u/75194/stats/data/01_heights_weights_genders.csv")
df.head()


# In[31]:


plt.plot(df.Weight, df.Height, '.', alpha=0.08);


# The data looks vaguely elliptical and has two "clusters". Besides we know that heights and weights have normal distributions associated with them. So we decide to fit these features, with no knowledge of labels, with a mixture of two 2-D normal distributions. 
# 
# $$P(x) = \lambda G_0(\v{x},\theta_0) + (1 - \lambda) G_1(\v{x},\theta_1) $$
# 
# What we are doing is a probability distribution estimation on these height and weight features, by fitting for the parameters of whats known as a "mixture of gaussians". Note these are not the per label gaussians we fit before in LDA: rather, there are no labels any more, so this is just a mixture of gaussians. This is just a density estimation.
# 
# At this point, you may object, saying that we know from generative classifiers that we can find $P(x)$ as:
# 
# $$P(x) = \sum_y P(x|y, \theta_y) P(y).$$
# 
# You are right, if you knew the labels. But remember, I have taken these labels away from you, and thus there are no $y$'s, and this formula does not hold any more.
# 
# But your objection also makes sense: why not right the input density $P(x)$ as a sum of components, each of which is some other probability distribution. This is the notion of **clustering**: an attempt to find hidden structure in the data. So we can always write:
# 
# $$P(x) = \sum_z \lambda_z P(x|z, \theta_z),$$
# 
# where $z$ is some **hidden** variable which indexes the number of clusters in our problem. This is a variant of the idea behind the famous **kmeans** clustering algorithm, which we shall encounter in class.
# 
# So thats what we do below here, using two clusters based on our visual reconnoiter of the density in the graph above:

# In[32]:


Xall=df[['Height', 'Weight']].values
from sklearn.mixture import GMM
n_clusters=2
clfgmm = GMM(n_components=n_clusters, covariance_type="tied")
clfgmm.fit(Xall)
print clfgmm
gmm_means=clfgmm.means_
gmm_covar=clfgmm.covars_
print gmm_means, gmm_covar


# How do we use these gaussians to assign clusters? Just like we did in the generative case with LDA, we can ask, which Gaussian is higher at a particular sample. We'll cluster that sample under an artificial label created by that cluster. 
# 
# We plot the results below.

# In[33]:


from scipy import linalg

def plot_ellipse(splot, mean, cov, color):
    v, w = linalg.eigh(cov)
    u = w[0] / linalg.norm(w[0])
    angle = np.arctan(u[1] / u[0])
    angle = 180 * angle / np.pi  # convert to degrees
    # filled Gaussian at 2 standard deviation
    ell = mpl.patches.Ellipse(mean, 2 * v[0] ** 0.5, 2 * v[1] ** 0.5,
                              180 + angle, color=color, lw=3, fill=False)
    ell.set_clip_box(splot.bbox)
    ell1 = mpl.patches.Ellipse(mean, 1 * v[0] ** 0.5, 1 * v[1] ** 0.5,
                              180 + angle, color=color, lw=3, fill=False)
    ell1.set_clip_box(splot.bbox)
    ell3 = mpl.patches.Ellipse(mean, 3 * v[0] ** 0.5, 3 * v[1] ** 0.5,
                              180 + angle, color=color, lw=3, fill=False)
    ell3.set_clip_box(splot.bbox)
    #ell.set_alpha(0.2)
    splot.add_artist(ell)
    splot.add_artist(ell1)
    splot.add_artist(ell3)


# In[34]:


plt.figure()
ax=plt.gca()
plot_ellipse(ax, gmm_means[0], gmm_covar, 'k')
plot_ellipse(ax, gmm_means[1], gmm_covar, 'k')
gmm_labels=clfgmm.predict(Xall)
for k, col in zip(range(n_clusters), ['blue','red']):
    my_members = gmm_labels == k
    ax.plot(Xall[my_members, 0], Xall[my_members, 1], 'w',
            markerfacecolor=col, marker='.', alpha=0.05)


# How do we know, a-priori, that two is the right number of clusters? We can try and fit a mixture of 3 gaussians

# In[35]:


n_clusters=3
clfgmm3 = GMM(n_components=n_clusters, covariance_type="tied")
clfgmm3.fit(Xall)
print clfgmm
gmm_means=clfgmm3.means_
gmm_covar=clfgmm3.covars_
print gmm_means, gmm_covar
plt.figure()
ax=plt.gca()
plot_ellipse(ax, gmm_means[0], gmm_covar, 'k')
plot_ellipse(ax, gmm_means[1], gmm_covar, 'k')
plot_ellipse(ax, gmm_means[2], gmm_covar, 'k')
gmm_labels=clfgmm3.predict(Xall)
for k, col in zip(range(n_clusters), ['blue','red', 'green']):
    my_members = gmm_labels == k
    ax.plot(Xall[my_members, 0], Xall[my_members, 1], 'w',
            markerfacecolor=col, marker='.', alpha=0.05)


# Which is better? Unless we have some prior knowledge, we dont know, and rely on intuition and goodness of fit estimates standard in statistics. But thinking more about how we might use prior knowledge takes us into semi-supervized learning and such, and also evaluation measures for clustering, which is not what this lab is about. 
