#!/usr/bin/python
import numpy as np
import urllib
import math
import random
import time
from sklearn import preprocessing
from collections import defaultdict
from fractions import Fraction
import pandas as pd
from fcmeans import FCM # import matplotlib.pyplot as plt  # Plot the points and centroids ###########################################################
from sklearn.datasets import make_blobs
from matplotlib import pyplot as plt
from seaborn import scatterplot as scatter
def dissimilarityMeasure(X, Y): # import FCMeans
    return np.sum(X != Y, axis=0)
def costFunction(membership_mat, n_clusters, n_points, alpha, centroids, X):
    cost_function = 0.0
    for k in range(n_clusters):
        temp = 0.0
        denom = 0.0
        for i in range(n_points):
            temp += np.power(membership_mat[i][k], alpha) * dissimilarityMeasure(X[i], centroids[k])
            denom += np.power(membership_mat[i][k], alpha)
        temp = temp / denom
        cost_function += temp
    return cost_function
def calculateMembership(centroids, X, n_points, n_clusters, n_attributes, alpha):
    exp = 1 / (float(alpha - 1))
    for x in range(n_clusters):
        centroid = centroids[x]
        for y in range(n_points):
            hammingDist = dissimilarityMeasure(centroid, X[y])
            numerator = np.power(hammingDist, exp)
            denom = 0.0
            flag = 0
            for z in range(n_clusters):
                if (centroids[z] == X[y]).all() and (centroids[z] == centroid).all():
                    membership_mat[y][x] = 1
                    flag = 1
                    break
                elif (centroids[z] == X[y]).all():
                    membership_mat[y][x] = 0
                    flag = 1
                    break
                denom += np.power(dissimilarityMeasure(centroids[z], X[y]), exp)
            if flag == 0:
                membership_mat[y][x] = 1 / (float(numerator) / float(denom))
    for row in range(len(membership_mat)):
        membership_mat[row] = membership_mat[row] / sum(membership_mat[row])
    cost_function = costFunction(membership_mat, n_clusters, n_points, alpha, centroids, X)
    return membership_mat, cost_function
def calculateCentroids(membership_mat, X, alpha):
    n_points, n_attributes = X.shape
    n_clusters = membership_mat.shape[1]
    WTemp = np.power(membership_mat, alpha)
    centroids = np.zeros((n_clusters, n_attributes))
    for z in range(n_clusters):
        for x in range(n_attributes):
            freq = defaultdict(int)
            for y in range(n_points):
                freq[X[y][x]] += WTemp[y][z]
            centroids[z][x] = max(freq, key=freq.get)
    centroids = centroids.astype(int)
    return centroids
def FCM2(membership_mat, X, alpha, max_epochs):
    n_points, n_clusters = membership_mat.shape
    n_attributes = X.shape[1]
    centroids = np.zeros((n_clusters, n_attributes))
    epochs = 0
    oldCostFunction = 0.0
    costFunction = 0.0
    while epochs < max_epochs:
        centroids = calculateCentroids(membership_mat, X, alpha)
        membership_mat, costFunction = calculateMembership(centroids, X, n_points, n_clusters, n_attributes, alpha)
        if (oldCostFunction - costFunction) * (oldCostFunction - costFunction) < 0.3:
            break
        epochs += 1
    return membership_mat, costFunction
def Selection(chromosomes, n, k, beta):
    """Rank Based Fitness Assignment"""
    chromosomes = chromosomes[chromosomes[:, n * k].argsort()]  # Sort chromosomes for rank based evaluation
    newChromosomes = np.zeros((n, n * k + 1))
    fitness = np.zeros(n)
    cumProbability = np.zeros(n)
    for i in range(n - 1, 0, -1):
        fitness[i] = beta * (pow((1 - beta), i))
    """Roulette Wheel Selection"""
    for i in range(n):  # Cumulative Probability
        if i > 1:
            cumProbability[i] = cumProbability[i - 1]
        cumProbability[i] += fitness[i]
    for i in range(n):  # Random number to pick chromosome
        pick = random.uniform(0, 1)
        if pick < cumProbability[0]:
            newChromosomes[i] = chromosomes[0]
        else:
            for j in range(n - 1):
                if cumProbability[j] < pick and pick < cumProbability[j + 1]:
                    newChromosomes[i] = chromosomes[j + 1]
        newChromosomes[i][n * k] = 0.0
    return newChromosomes
def CrossOver(chromosomes, n, k, X, alpha, max_epochs):
    newChromosomes = np.zeros((n, n * k + 1))
    for i in range(n):
        membership_mat = np.reshape(chromosomes[i][0 : n * k], (-1, k))
        # fit the fuzzy-c-means #        new_membership_met, cost_function = FCM2(membership_mat, X, alpha, max_epochs)  # Quick termination, 1 step fuzzy kmodes
        fcm = FCM(n_clusters=3)
        fcm.u = membership_mat
        fcm.fit(X)
        cost_function = fcm.e
        new_membership_met = fcm.u
        newChromosomes[i][0 : n * k] = new_membership_met.ravel()
        newChromosomes[i][n * k] = cost_function
    return newChromosomes
def Mutation(chromosomes, n_points, n_clusters, P):
    for i in range(n_points):
        chromosome = chromosomes[i][0 : n * k]
        chromosome = np.reshape(chromosome, (-1, n_clusters))
        for j in range(n_points):
            pick = random.uniform(0, 1)
            if pick <= P:
                gene = np.random.rand(k)
                gene = gene / sum(gene)
                chromosome[j] = gene
        chromosomes[i][0 : n * k] = chromosome.ravel()
    return chromosomes
def bestParent(chromosomes, populationSize):
    min_value = 0
    offspring = chromosomes[0]
    for i in range(populationSize):
        if min_value == 0:
            min_value = chromosomes[i][n * k]
        elif chromosomes[i][n * k] < min_value:
            min_value = chromosomes[i][n * k]
            offspring = chromosomes[i]
    return offspring, min_value
def worstChild(chromosomes, populationSize):
    """Elitism at each generation"""
    max_value = 0
    worst_child_pos = 0
    for i in range(populationSize):
        #        centroids             = calculateCentroids(membership_mat, X, alpha) #        membership_mat        = np.reshape(chromosomes[i][0 : n * k], (-1, k))
        if max_value == 0: #        chromosomes[i][n * k] = costFunction(membership_mat, k, n, alpha, centroids, X)  # Last column represents the cost function of this chromosome
            max_value = chromosomes[i][n * k]
        elif chromosomes[i][n * k] > max_value:
            max_value = chromosomes[i][n * k]
            worst_child_pos = i
    return worst_child_pos

verbose         = False
dataset         = "data/X.csv"
loraData        = np.genfromtxt(dataset, delimiter=",", dtype="str", skip_header=1)  # load the CSV file as a numpy matrix
X               = loraData[:, 0:3].astype(int)
k               = 3  # number of application # YLabels        = loraData[:, 0].astype(int)                          # preprocessing.LabelEncoder().fit_transform(loraData[:, 0])  #Convert label names to numbers
n               = len(X)
n_attributes    = X.shape[1]
alpha           = 1.2  # degree of fuzzification
beta            = 0.05  # max selection probability
P               = 0.001  # mutation probability
max_generation  = 2  # mxx generation
max_epochs      = 100
chromosomes     = np.zeros((n, n * k + 1))
cluster_centers = np.zeros((k, n_attributes))
print("start") # print X[1]
for i in range(n): # start_time = time.time()
   for row in range(len(membership_mat)): #    membership_mat             = np.random.rand(n, k)
#        membership_mat[row]    = membership_mat[row] / sum(membership_mat[row])
   cluster_centers            = calculateCentroids(membership_mat, X, alpha) #    chromosomes[i][0 : n * k]  = membership_mat.ravel()
for x in range(max_generation): #    chromosomes[i][n * k]      = costFunction(membership_mat, k, n, alpha, cluster_centers, X)  # Last column represents the cost function of this chromosome
   best_parent,_              = bestParent(chromosomes, n) #    print (x, time.time() - start_time)
   population_after_crossover = CrossOver(population_after_selection, n, k, X, alpha, max_epochs) #    population_after_selection = Selection(chromosomes, n, k, beta)
   worstChildPos              = worstChild(chromosomes, n) #    chromosomes                = Mutation(population_after_crossover, n, k, P)
offspring, min_value           = bestParent(chromosomes, n) #    chromosomes[worstChildPos] = best_parent # replace worst child by the best parent
print("Time :", time.time() - start_time) # print("end")
df.to_csv('data/V.csv', sep=' ', header=False, float_format='%.2f', index=False) # df = pd.DataFrame(data=cluster_centers)
df.to_csv('data/U.csv', sep=' ', header=False, float_format='%.2f', index=False) # df = pd.DataFrame(data=offspring)


