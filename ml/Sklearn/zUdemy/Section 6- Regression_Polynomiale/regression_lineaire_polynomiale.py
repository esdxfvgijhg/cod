# -*- coding: utf-8 -*-
"""
Created on Fri Jun  7 16:34:39 2019

@author: carlyna.bondiombouy
"""

#####################################################
#####################################################

#*************************************
########data preprocessing############
#*************************************

######################################
#import libraries
######################################

import numpy as np 

import matplotlib.pyplot as plt 

import pandas  as pd 

######################################
#import dataset
######################################

##import dataset 

dataset =pd.read_csv('Position_Salaries.csv')
X=dataset.iloc[:, 1:2].values #level=position . Matrice
y=dataset.iloc[:, -1].values  #salary . Vecteur


#####################################################
#####################################################

#*************************************
########Construction du modèle########
#*************************************

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train) #la methode fit, lie 1 objet à quelque chose. La methode des carrés ordinaires va s'executer pour trouver les coeffs optimaux de sorte que la droite de regression lineaire se rapproche le plus des points d'observations en terme des sommes de distance au carré entre les points d'observations et les points de predictions. 

#*************************************
y_pred= regressor.predict(X_test)#Contient les 10 observations du test set. Y test salaire réel des employés. Xtest nombre d'anées d'experience des observations du test set. Y pred : salaire prédit de chacun des employés 

regressor.predict([[15]]) 
#*************************************
#####visualisation des résultats#####
#*************************************
plt.scatter(X_test, y_test,color='red')# 
plt.plot(X_train, regressor.predict(X_train))
plt.title('Salaire vs Experience')
plt.xlabel('Experience')
plt.ylabel('Salaire')
plt.show()