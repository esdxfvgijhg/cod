#!/usr/bin/env python
# coding: utf-8

# #Classification, Probabilities, ROC curves, and Cost

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
from PIL import Image


# In[2]:


from sklearn.grid_search import GridSearchCV
from sklearn.cross_validation import train_test_split
from sklearn.metrics import confusion_matrix
def cv_optimize(clf, parameters, X, y, n_jobs=1, n_folds=5, score_func=None):
    if score_func:
        gs = GridSearchCV(clf, param_grid=parameters, cv=n_folds, n_jobs=n_jobs, scoring=score_func)
    else:
        gs = GridSearchCV(clf, param_grid=parameters, n_jobs=n_jobs, cv=n_folds)
    gs.fit(X, y)
    print "BEST", gs.best_params_, gs.best_score_, gs.grid_scores_
    best = gs.best_estimator_
    return best
def do_classify(clf, parameters, indf, featurenames, targetname, target1val, mask=None, reuse_split=None, score_func=None, n_folds=5, n_jobs=1):
    subdf=indf[featurenames]
    X=subdf.values
    y=(indf[targetname].values==target1val)*1
    if mask !=None:
        print "using mask"
        Xtrain, Xtest, ytrain, ytest = X[mask], X[~mask], y[mask], y[~mask]
    if reuse_split !=None:
        print "using reuse split"
        Xtrain, Xtest, ytrain, ytest = reuse_split['Xtrain'], reuse_split['Xtest'], reuse_split['ytrain'], reuse_split['ytest']
    if parameters:
        clf = cv_optimize(clf, parameters, Xtrain, ytrain, n_jobs=n_jobs, n_folds=n_folds, score_func=score_func)
    clf=clf.fit(Xtrain, ytrain)
    training_accuracy = clf.score(Xtrain, ytrain)
    test_accuracy = clf.score(Xtest, ytest)
    print "############# based on standard predict ################"
    print "Accuracy on training data: %0.2f" % (training_accuracy)
    print "Accuracy on test data:     %0.2f" % (test_accuracy)
    print confusion_matrix(ytest, clf.predict(Xtest))
    print "########################################################"
    return clf, Xtrain, ytrain, Xtest, ytest


# In[43]:


from matplotlib.colors import ListedColormap
cmap_light = ListedColormap(['#FFAAAA', '#AAFFAA', '#AAAAFF'])
cmap_bold = ListedColormap(['#FF0000', '#00FF00', '#0000FF'])
cm = plt.cm.RdBu
cm_bright = ListedColormap(['#FF0000', '#0000FF'])

def points_plot(ax, Xtr, Xte, ytr, yte, clf, mesh=True, colorscale=cmap_light, cdiscrete=cmap_bold, alpha=0.3, psize=10, zfunc=False):
    h = .02
    X=np.concatenate((Xtr, Xte))
    x_min, x_max = X[:, 0].min() - .5, X[:, 0].max() + .5
    y_min, y_max = X[:, 1].min() - .5, X[:, 1].max() + .5
    xx, yy = np.meshgrid(np.linspace(x_min, x_max, 100),
                         np.linspace(y_min, y_max, 100))

    #plt.figure(figsize=(10,6))
    if mesh:
        if zfunc:
            p0 = clf.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:, 0]
            p1 = clf.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:, 1]
            Z=zfunc(p0, p1)
        else:
            Z = clf.predict(np.c_[xx.ravel(), yy.ravel()])
        Z = Z.reshape(xx.shape)
        plt.pcolormesh(xx, yy, Z, cmap=cmap_light, alpha=alpha, axes=ax)
    ax.scatter(Xtr[:, 0], Xtr[:, 1], c=ytr-1, cmap=cmap_bold, s=psize, alpha=alpha,edgecolor="k")
    # and testing points
    yact=clf.predict(Xte)
    ax.scatter(Xte[:, 0], Xte[:, 1], c=yte-1, cmap=cmap_bold, alpha=alpha, marker="s", s=psize+10)
    ax.set_xlim(xx.min(), xx.max())
    ax.set_ylim(yy.min(), yy.max())
    return ax,xx,yy


# In[72]:


def points_plot_prob(ax, Xtr, Xte, ytr, yte, clf, colorscale=cmap_light, cdiscrete=cmap_bold, ccolor=cm, psize=10, alpha=0.1, prob=True):
    ax,xx,yy = points_plot(ax, Xtr, Xte, ytr, yte, clf, mesh=False, colorscale=colorscale, cdiscrete=cdiscrete, psize=psize, alpha=alpha) 
    if prob:
        Z = clf.predict_proba(np.c_[xx.ravel(), yy.ravel()])[:, 1]
    else:
        Z = clf.decision_function(np.c_[xx.ravel(), yy.ravel()])
    Z = Z.reshape(xx.shape)
    plt.contourf(xx, yy, Z, cmap=ccolor, alpha=.2, axes=ax)
    cs2 = plt.contour(xx, yy, Z, cmap=ccolor, alpha=.6, axes=ax)
    plt.clabel(cs2, fmt = '%2.1f', colors = 'k', fontsize=14, axes=ax)
    return ax 


# ##Setting up the data
# 
# (I encountered this dataset in Conway, Drew, and John White. Machine learning for hackers. " O'Reilly Media, Inc.", 2012.)

# In[77]:


dfhw=pd.read_csv("https://dl.dropboxusercontent.com/u/75194/stats/data/01_heights_weights_genders.csv")
print dfhw.shape
dfhw.head()


# We sample 500 points from 10,000, since we actually want to see trends clearly on the plots

# In[78]:


df=dfhw.sample(500, replace=False)
np.sum(df.Gender=="Male")


# We split the data into training and test sets...

# In[79]:


itrain, itest = train_test_split(xrange(df.shape[0]), train_size=0.6)
mask=np.ones(df.shape[0], dtype='int')
mask[itrain]=1
mask[itest]=0
mask = (mask==1)
mask[:10]


# ##Logistic regression
# 
# Notice that its L2 regularized....

# In[80]:


from sklearn.linear_model import LogisticRegression
clflog = LogisticRegression()
parameters = {"C": [0.001, 0.01, 0.1, 1, 10, 100, 1000, 10000]}
clflog, Xtrain, ytrain, Xtest, ytest=do_classify(clflog, parameters, df, ['Height','Weight'],'Gender', "Male", mask=mask)
Xtr=np.concatenate((Xtrain, Xtest))
plt.figure()
ax=plt.gca()
points_plot(ax, Xtrain, Xtest, ytrain, ytest, clflog);


# In `sklearn`, `clf.predict(test_data)` makes predictions on the assumption that a 0.5 probability threshold is the appropriate thing to do.

# In[81]:


clflog.predict(Xtest)


# The probabilities output by the classifier can be accessed as below. The second column (`[:,1]` in numpy parlance, google numpy indexing to understand the syntax) gives the probability that the sample is a 1 (or +ive), here Male.

# In[82]:


clflog.predict_proba(Xtest)


# In[109]:


clflog.predict_proba(Xtest)[:,1]


# Lots of sure females and sure males when you plot the probability of being a male:

# In[83]:


plt.hist(clflog.predict_proba(Xtest)[:,1]*100);


# We can plot the probability contours: these are rather tight!

# In[84]:


plt.figure()
ax=plt.gca()
points_plot(ax, Xtrain, Xtest, ytrain, ytest, clflog, mesh=False, alpha=0.001);
points_plot_prob(ax, Xtrain, Xtest, ytrain, ytest, clflog);


# The score function of the estimator is used to evaluate a parameter setting. These are the sklearn.metrics.accuracy_score for classification and sklearn.metrics.r2_score for regression. For some applications, other scoring functions are better suited (for example in unbalanced classification, the accuracy score is often uninformative). We can pass other scorers to `GridSearchCV`.

# In[66]:


clflog.score(Xtest, ytest)


# ##SVM
# 
# Lets do a linear SVM instead. As mentioned in the last lab, SVM is a discriminant classifier..it is not probabilistic.

# In[85]:


from sklearn.svm import SVC
clfsvm = SVC(kernel="linear")
parameters = {"C": [0.001, 0.01, 0.1, 1, 10, 100, 1000]}
clfsvm, Xtrain, ytrain, Xtest, ytest=do_classify(clfsvm, parameters, df, ['Height','Weight'],'Gender', "Male", mask=mask)
Xtr=np.concatenate((Xtrain, Xtest))
plt.figure()
ax=plt.gca()
points_plot(ax, Xtrain, Xtest, ytrain, ytest, clfsvm);


# This there is no `predict_proba`. Instead, we get to use `decision_function`, which give us whatever the said classifier is using to discriminate...

# In[86]:


clfsvm.decision_function(Xtest)


# We can plt a histogram. In terms of distance from the separator, we can see that most samples on either side are a middling distance away. This is different from the probability diagram

# In[87]:


plt.hist(clfsvm.decision_function(Xtest));


# Its clearer when u plot the `decision_function` on the plane...

# In[95]:


plt.figure()
ax=plt.gca()
points_plot(ax, Xtrain, Xtest, ytrain, ytest, clfsvm, mesh=False);
points_plot_prob(ax, Xtrain, Xtest, ytrain, ytest, clfsvm, prob=False);


# The decision function can be used to plot the margins of the SVM.

# In[89]:


#From Jake Vanderplas's ESAC notebook
def plot_svc_decision_function(clf, ax=None):
    """Plot the decision function for a 2D SVC"""
    if ax is None:
        ax = plt.gca()
    x = np.linspace(plt.xlim()[0], plt.xlim()[1], 30)
    y = np.linspace(plt.ylim()[0], plt.ylim()[1], 30)
    Y, X = np.meshgrid(y, x)
    P = np.zeros_like(X)
    for i, xi in enumerate(x):
        for j, yj in enumerate(y):
            P[i, j] = clf.decision_function([xi, yj])
    return ax.contour(X, Y, P, colors='k',
                      levels=[-1, 0, 1], alpha=0.5,
                      linestyles=['--', '-', '--'])


# and we can also access the support vectors....

# In[97]:


plt.figure()
ax=plt.gca()
points_plot(ax, Xtrain, Xtest, ytrain, ytest, clfsvm);
plot_svc_decision_function(clfsvm, ax)
ax.scatter(clfsvm.support_vectors_[:, 0], clfsvm.support_vectors_[:, 1],s=200, facecolors='none')
plt.ylim([125,225])


# ##The confusion Matrix

# We have written two classifiers. A classifier will get some samples right, and some wrong. Generally we see which ones it gets right and which ones it gets wrong on the test set. There,
# 
# - the samples that are +ive and the classifier predicts as +ive are called True Positives (TP)
# - the samples that are -ive and the classifier predicts (wrongly) as +ive are called False Positives (FP)
# - the samples that are -ive and the classifier predicts as -ive are called True Negatives (TN)
# - the samples that are +ive and the classifier predicts as -ive are called False Negatives (FN)
# 
# A classifier produces a confusion matrix from these which lookslike this:
# 
# ![hwimages](./images/confusionmatrix.png)
# 
# 
# IMPORTANT NOTE: In sklearn, to obtain the confusion matrix in the form above, always have the observed `y` first, i.e.: use as `confusion_matrix(y_true, y_pred)`

# In[99]:


confusion_matrix(ytest, clflog.predict(Xtest))


# Given these definitions, we typically calculate a few metrics for our classifier. First, the **True Positive Rate**:
# 
# $$TPR = Recall = \frac{TP}{OP} = \frac{TP}{TP+FN},$$
# 
# also called the Hit Rate: the fraction of observed positives (1s) the classifier gets right, or how many true positives were recalled. Maximizing the recall towards 1 means keeping down the false negative rate. In a classifier try to find cancer patients, this is the number we want to maximize.
# 
# The **False Positive Rate** is defined as
# 
# $$FPR = \frac{FP}{ON} = \frac{FP}{FP+TN},$$
# 
# also called the False Alarm Rate, the fraction of observed negatives (0s) the classifier gets wrong. In general, you want this number to be low. Instead, you might want to maximize the
# **Precision**,which tells you how many of the predicted positive(1) hits were truly positive
# 
# $$Precision = \frac{TP}{PP} = \frac{TP}{TP+FP}.$$
# 
# Finally the **F1** score gives us the Harmonic Score of Precision and Recall. Many analysts will try and find a classifier that maximizes this score, since it tries to minimize both false positives and false negatives simultaneously, and is thus a bit more precise in what it is trying to do than the accuracy.
# 
# $$F1 =  \frac{2*Recall*Precision}{Recall + Precision}$$
# 
# However, in a case like that of a cancer classifier, we will wish to minimize false nagatives at the expense of false positives: it is ok to send perfectly healthy patients for cancer folloup if that is the price we must pay for not missing any sick ones.
# 
# `scikit-learn` helpfully gives us a classification report with all these numbers

# In[98]:


from sklearn.metrics import classification_report
print classification_report(ytest, clflog.predict(Xtest))


# ####The cancer doctor
# 
# Do you really want to be setting a threshold of 0.5 probability to predict if a patient has cancer or not? The false negative problem: ie the chance you predict someone dosent have cancer who has cancer is much higher for such a threshold. You could kill someone by telling them not to get a biopsy. Why not play it safe and assume a much lower threshold: for eg, if the probability of 1(cancer) is greater than 0.05, we'll call it a 1.

# In[100]:


def t_repredict(est,t, xtest):
    probs=est.predict_proba(xtest)
    p0 = probs[:,0]
    p1 = probs[:,1]
    ypred = (p1 > t)*1
    return ypred


# See how the false negatives get suppressed?

# In[102]:


confusion_matrix(ytest, t_repredict(clflog, 0.1, Xtest))


# ##ROC Curve
# 
# The images in this section are from Provost, Foster; Fawcett, Tom (2013-07-27). Data Science for Business: What you need to know about data mining and data-analytic thinking  O'Reilly Media. Great book!
# 
# We can check on the thresholds we talked about in the previous section and compare our classifiers to each other and the baseline models using the ROC curves you learned about in class. 
# 
# Remember that ROC curves are actually a set of classifiers, in which we move the threshold for classifying a sample as positive from 1 to 0. Each point on a ROC curve is a separate classifier obtained by considering a different threshold. (In the standard scenario, where we used the  classifier accuracy, this threshold is implicitly set at 0.5, and we have only one classifier).
# 
# ![m:roc curve](images/roc-curve.png)
# 
# The way ROC curves are calulated is this. We start with a large threshold, something like 0.99 or so. This means that only samples with a probability of being positive higher than that threshold are classified as positive. That is the really really really positive ones! The idea then is to decrease this threshold, such that more and more samples get classified as positive.
# 
# ![howto roc](images/howtoroc.png)
# 
# The practical way to do this is to order the samples by probability of being positive, or in the case of the SVM, by the `decision_function` or distance from the separating hyperplane. Then consider the sample with the highest score or highest probability of being positive. At first, only this sample is positive. Then, we take the sample with the next highest score, and call it positive. As we go down the list, we go down a threshold in score or probability. 
# 
# Now, for each such situation: only 1 positive, now 2 positive,....you can imagine a different classifier with a different confusion matrix. It will have its own false positives, tre positives, etc. Its actually the same original classifier, but with a different threshold each time.
# 
# As we keep going down the list, decreasing the threshold, more and more samples become positive, and at first, the true positives rise faster than the false positives. Once past a certain point, false positives increase faster than true positives. Now, if you want a balanced classifier, you look at this turn-around point...the northwest corner, so to speak. But if you want a classifier which penalizes false positives and false negatives differently, the point you want is different.
# 
# Here is the confusion matrix again:
# 
# ![hwimages](./images/confusionmatrix.png)
# 
# 
# To make a ROC curve you plot the True Positive Rate, 
# 
# $$TPR=\frac{TP}{OP}$$
# 
# against the False Positive Rate,
# 
# $$FPR=\frac{FP}{ON}$$
# 
# as you go through this process of going down the list of samples. ROC curves are useful because they calculate one classifier per threshold and show you where you are in TPR/FPR space without making any assumptions about the utility matrix or which threshold is appropriate.
# 
# Notice that the ROC curve has a very interesting property: if you look at the confusion matrix above, TPR is only calculated from the observed "1" row while FPR is calculated from the observed '0' row. This means that the ROC curve is independent of the class balance/imbalance on the test set, and thus works for all ratios of positive to negative samples. The balance picks a point on the curve, as you can read below.
# 
# A rote reading of the ROC curve (go to the "northwest" corner) is a bad idea: you must fold in the curve with any assumptions you are making about costs. More on this in the next lab. Still, on the whole, a curve with a greater AUC (area under curve), or further away from the line of randomness, will give us a rough idea of what might be a better classifier.
# 

# In[103]:


def make_roc(name, clf, ytest, xtest, ax=None, labe=5, proba=True, skip=0):
    initial=False
    if not ax:
        ax=plt.gca()
        initial=True
    if proba:
        fpr, tpr, thresholds=roc_curve(ytest, clf.predict_proba(xtest)[:,1])
    else:
        fpr, tpr, thresholds=roc_curve(ytest, clf.decision_function(xtest))
    roc_auc = auc(fpr, tpr)
    if skip:
        l=fpr.shape[0]
        ax.plot(fpr[0:l:skip], tpr[0:l:skip], '.-', alpha=0.3, label='ROC curve for %s (area = %0.2f)' % (name, roc_auc))
    else:
        ax.plot(fpr, tpr, '.-', alpha=0.3, label='ROC curve for %s (area = %0.2f)' % (name, roc_auc))
    label_kwargs = {}
    label_kwargs['bbox'] = dict(
        boxstyle='round,pad=0.3', alpha=0.2,
    )
    for k in xrange(0, fpr.shape[0],labe):
        #from https://gist.github.com/podshumok/c1d1c9394335d86255b8
        threshold = str(np.round(thresholds[k], 2))
        ax.annotate(threshold, (fpr[k], tpr[k]), **label_kwargs)
    if initial:
        ax.plot([0, 1], [0, 1], 'k--')
        ax.set_xlim([0.0, 1.0])
        ax.set_ylim([0.0, 1.05])
        ax.set_xlabel('False Positive Rate')
        ax.set_ylabel('True Positive Rate')
        ax.set_title('ROC')
    ax.legend(loc="lower right")
    return ax


# We plot ROC curves for both our classifiers:

# In[107]:


from sklearn.metrics import roc_curve, auc
ax=make_roc("logistic", clflog, ytest, Xtest, labe=10)


# In[110]:


make_roc("svm", clfsvm, ytest, Xtest, labe=10, proba=False)


# ##Loss Functions
# 
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
# ###Estimation Loss
# In the previous lab, we'd introduced the log loss that is used in Logistic regression and noted that it is a loss for probability estimation...and not a loss for making decisions. We'll go into these dual losses (we alluded to these in the previous lab as well) in the other notebook in this lab.
# 
# $$R_{\cal{D}}(h(x)) = -\loglike = -log \like = - log(P(y|\v{x},\v{w})).$$
# 
# 
# Thus
# 
# \begin{eqnarray*}
# R_{\cal{D}}(h(x)) &=& -log\left(\prod_{y_i \in \cal{D}} h(\v{w}\cdot\v{x_i})^{y_i} \left(1 - h(\v{w}\cdot\v{x_i}) \right)^{(1-y_i)}\right)\\
#                   &=& -\sum_{y_i \in \cal{D}} log\left(h(\v{w}\cdot\v{x_i})^{y_i} \left(1 - h(\v{w}\cdot\v{x_i}) \right)^{(1-y_i)}\right)\\                  
#                   &=& -\sum_{y_i \in \cal{D}} log\,h(\v{w}\cdot\v{x_i})^{y_i} + log\,\left(1 - h(\v{w}\cdot\v{x_i}) \right)^{(1-y_i)}\\
#                   &=& - \sum_{y_i \in \cal{D}} \left ( y_i log(h(\v{w}\cdot\v{x})) + ( 1 - y_i) log(1 - h(\v{w}\cdot\v{x})) \right )
# \end{eqnarray*}
# 
# where
# 
# $$h(z) = \frac{1}{1 + e^{-z}}.$$
# 
# ###Decision Loss
# 
# When doing cross-validation, `sklearn` will instead use the 1-0 loss or the attendant `accuracy_score` as a way of finding the best model.
# 
# From the last lab:
# 
# The 1-0 loss:
# 
# $$l = \mathbf{1}_{h \ne y}.$$
# 
# where $h$ is the classification **decision** we make (for regression we used $l = (h-y)^2$). The symbol $\mathbf{1}$ means that if $h$ is not equal to the "true" value of the point $y$, penalize by 1. Then the risk is:
# 
# $$ R_{\cal{D}}(h(x)) = \frac{1}{N} \sum_{y_i \in \cal{D}} l = \frac{1}{N} \sum_{y_i \in \cal{D}} \mathbf{1}_{h \ne y_i} $$
# 
# Thus if 5 out of 50 samples are misclassified, then the risk is 0.1. This of course means that 90% of the samples are correctly classified. This number is called the **accuracy score** or **utility**:
# 
# $$ U_{\cal{D}}(h(x))  = \frac{1}{N} \sum_{y_i \in \cal{D}} \mathbf{1}_{h = y_i} $$
# 
# ###SVM
# 
# The SVM, being a classifier, uses by default the 1-0 loss in the validation part. But the estimation loss for the SVM is called the hinge loss. A bunch of losses are shown below: the red log loss, the black 1-0 loss, the green L2 loss (used in regression), and the blue hinge loss. so called, because of its shape.

# ![losses](./images/losses.png)
# 
# (The image is from Bishop: Pattern recognition and Machine learning)

# The hinge loss comes from inspecting the structure of the minimization problem the SVM solves:
# 
# $$\cal{l}(y) = \max(0, 1 - y \cdot h) $$
# 
# where Note that $h$ should be the "raw" output of the classifier's decision function, not the predicted class label. E.g., in linear SVMs, 
# 
# $$ h = \mathbf{w} \cdot \mathbf{x}$$
# 
# (taken from https://en.wikipedia.org/wiki/Hinge_loss)

# This is the solution of the optimization problem(taken from http://math.stackexchange.com/questions/327807/why-hinge-loss-is-equivalent-to-0-1-loss-in-svm):
# 
# $$\min_{\mathbf{w}} \sum_{i=1}^N [1-y_i h(x_i)]_+ +\frac{\lambda}{2}\|\mathbf{w}\|^2 $$
# 
# Setting  $\lambda=\frac{1}{C}$, this is the same minimization problem as
# 
# $$\min_{\mathbf{w}} \frac{1}{2}\|\mathbf{w}\|^2 +C \sum_{i=1}^N \xi_i$$
# 
# where
# 
# $$ \xi_i \geq 0,y_i h(x_i)\geq 1-\xi_i ~ \forall i, $$
# 
# the $\xi_i$ are the slack vectors.
