# -*- coding: utf-8 -*-
"""
Created on Wed May 29 17:59:24 2019

@author: carlyna.bondiombouy
"""

# -*- coding: utf-8 -*-
"""
Created on Tue May 28 11:13:33 2019

@author: carlyna.bondiombouy
"""
#####################################################
#####################################################

#*************************************
########data preprocessing############
#*************************************

######################################
#import libraries :> cmd + enter
######################################


import numpy as np 

import matplotlib.pyplot as plt 

import pandas  as pd 

######################################
#import dataset, before doing this step it's mandatory to choose the good work directory
######################################

##import dataset 

dataset =pd.read_csv('Salary_Data.csv')
X=dataset.iloc[:, :-1].values #years_experience, 
y=dataset.iloc[:, -1].values  #salary 


######################################
#Diviser le dataset entre le training set et le test set 
######################################
 
from sklearn.model_selection import train_test_split  
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 1.0/3, random_state = 0)# la fonction reroutrne ses 4 entités
#20 observations dans le training set et 10 observations dans le test set

#####################################################
#####################################################

#*************************************
########Construction du modèle########
#*************************************

#Les modèles de Régression sont utilisés pour prédire une valeur réelle continue, comme par exemple le salaire. Si votre variable indépendante est le temps, alors votre modèle prédit des valeurs futures. Sinon, votre modèle prédit des valeurs présentes, mais inconnues.
#Régression linéaire simple: équation d'une droite dans le plan a 2 dimensions : Y= b0 + b1 * X1

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
#X=X.reshape(-1, 1)
#X_train=X_train.reshape(-1, 1)
regressor.fit(X_train, y_train) #la methode fit, lie 1 objet à quelque chose. La methode des carrés ordinaires va s'executer pour trouver les coeffs optimaux de sorte que la droite de regression lineaire se rapproche le plus des points d'observations en terme des sommes de distance au carré entre les points d'observations et les points de predictions. 

#l'objet de la classe est le regresseur en lui meme, i.e. le modèle de regression linéaire simple 
#La méthode relaiera notre regresseur à notre training set. Puisque le modèle se construit sur le training set 
#test set est composé de nouvelles observations sur lequel le modèle n'a pas appris quoi que ce soit. Il sera important de voir le nombre de prediction correcte que notre modèle va faire sur ces nouvelles observations du test set. 
#Visualisation: mettre sur un graphe les points d'observations et cette droite de regression lineaire simple pour voir comment elle se rapproche de ces points d'observations et surtout pour comparer les points d'observations réelles aux prédictions de notre modèle

#*************************************
####Faire de nouvelles prédictions####
#*************************************
#predictions du test set et des nouvelles valeurs n'existant pas dans le CSV
#X_test= X_test.reshape(-1, 1)
y_pred= regressor.predict(X_test)#Contient les 10 observations du test set. Y test salaire réel des employés. Xtest nombre d'anées d'experience des observations du test set. Y pred : salaire prédit de chacun des employés 

regressor.predict([[15]]) # salaire employé ayant 15 années d'experience

#*************************************
#####visualisation des résultats#####
#*************************************
plt.scatter(X_test, y_test,color='red')# 
plt.plot(X_train, regressor.predict(X_train))
plt.title('Salaire vs Experience')
plt.xlabel('Experience')
plt.ylabel('Salaire')
plt.show()