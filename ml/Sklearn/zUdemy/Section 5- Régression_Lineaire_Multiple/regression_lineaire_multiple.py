# -*- coding: utf-8 -*-
"""
Created on Wed Jun  5 15:33:37 2019

@author: carlyna.bondiombouy
"""
#https://machinelearningmastery.com/visualize-machine-learning-data-python-pandas/
#https://www.kaggle.com/airbnb/boston/kernels
#https://github.com/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/05.06-Linear-Regression.ipynb
#https://github.com/ageron
#https://github.com/jakevdp

 

 


#####################################################
#####################################################

#*************************************
########data preprocessing############
#*************************************

import numpy as np 

import matplotlib.pyplot as plt 

import pandas  as pd 

######################################
#import dataset, before doing this step it's mandatory to choose the good work directory
######################################

dataset =pd.read_csv('50_Startups.csv')

X=dataset.iloc[:, :-1].values # vecteur var indep: R&D spend, Administration, Marketing spend, state
y=dataset.iloc[:, -1].values  #Var dep : profit

######################################
#gerer les variables catégoriques
######################################

#print(X)
from sklearn.preprocessing import LabelEncoder, OneHotEncoder
labelencoder_X = LabelEncoder() #encode state
X[:, 3] = labelencoder_X.fit_transform(X[:, 3]) # labelEncoder transforme le texte en numérique 
onehotencoder = OneHotEncoder(categorical_features=[3])
X= onehotencoder.fit_transform(X).toarray()#transforme la colonne de x en france, germany, spain et les fit aussi #Encode sous forme de démi variable

#Retrieve one dummy variable
X=  X[:, 1:] #Nous avons enlevé la dummy variable Californie.on prend toutes les colonnes de X sauf la premiere. On prend donc les colonnes à partir de la deuxième colonne, puisque la deuxième colonne a pour indice 1.

######################################
#Diviser le dataset entre le training set et le test set 
######################################
#Cette step va nous enable de construire un modèle de ML, et cette step est compulsory. On doit faire cette step, parce que le modèle prend des corrélations des variables indépendantes et dépendantes, il va le faire dans le sous dataset du dataset originale. ce sous dataset c'est le training set (c'est là ou le modele va faire son training il va apprendre des corrélations). Mais pour vérifier qu'il n'y a pas de suraprentissage c'est à dire qu'il n'est pas appris par coeur les corrélations on doit aussi avoir un test set qui va etre que 20 pourcent du dataset originale alors que le training set va répresenter 80 pourcent. On va tester le modèle sur les observations du test set. Car les observations du test set vont etre des nouvelles observations. Les observations sur lesquelles le modèle n'a pas été construit.   

from sklearn.model_selection import train_test_split   #train_test_split est une fonction du module model_selection
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.2, random_state = 0)# la fonction reroutrne ses 4 entités

######################################
#Appliquer feature scaling 
######################################

#Variable dep est combinaison lineaire des var indep , les coeffs peuvent adapter leurs echelles pour que les produits coeff fois var indep puisse etre sur la meme echelle. Donc pas besoin de feature scaling 

#####################################################
#####################################################

#*************************************
########Régresion ############
#*************************************

from sklearn.linear_model import LinearRegression
regressor = LinearRegression()
regressor.fit(X_train, y_train)#lire le regresseur


#*************************************
####Faire de nouvelles prédictions####
#*************************************
y_pred= regressor.predict(X_test)# contient les val de la la var indep
#after check y_pred and y_test. Profit reel et le profit reel
regressor.predict(np.array([[1, 0, 130000, 140000, 300000]])) # on a plusieur val il faut rentrer sous forme de tableau sinon cela ne veut rien dire pour Python
#Ce qu'on souhaite prédire: R&D: 131876.9, Admin:99814.71, Marketing: 362861.36, State:New York
#predict attend les elts de x_test. 1 pour l'appartenanace à NY et 0 pour l'appartenance à Floride
#on ajoute np.array pour le vecteur ligne 


#*************************************
########Test
#*************************************
#*https://datatofish.com/statsmodels-linear-regression/
from pandas import DataFrame
import statsmodels.api as sm
Startups = {'Floride': [0,0,1,0,1,0,0,1,0,0,1,0,1,0,1,0,0,0,1,0,0,0,1,1,0,0,1,0,1,0,1,0,0,1,0,0,1,0,0,0,0,1,0,0,0,0,1,0,0,0],
            'New_York': [1,0,0,1,0,1,0,0,1,0,0,0,0,0,0,1,0,1,0,1,0,1,0,0,1,0,0,1,0,1,0,1,0,0,0,1,0,0,1,0,0,0,0,1,0,1,0,0,1,0],
            'R&D': [165349.200000,162597.700000,153441.510000,144372.410000,142107.340000,131876.900000,134615.460000,130298.130000,120542.520000,123334.880000,101913.080000,100671.960000,93863.750000,91992.390000,119943.240000,114523.610000,78013.110000,94657.160000,91749.160000,86419.700000,76253.860000,78389.470000,73994.560000,67532.530000,77044.010000,64664.710000,75328.870000,72107.600000,66051.520000,65605.480000,61994.480000,61136.380000,63408.860000,55493.950000,46426.070000,46014.020000,28663.760000,44069.950000,20229.590000,38558.510000,28754.330000,27892.920000,23640.930000,15505.730000,22177.740000,1000.230000,1315.460000,0.000000,542.050000,0.000000],
            'Administration': [136897.800000,151377.590000,101145.550000,118671.850000,91391.770000,99814.710000,147198.870000,145530.060000,148718.950000,108679.170000,110594.110000,91790.610000,127320.380000,135495.070000,156547.420000,122616.840000,121597.550000,145077.580000,114175.790000,153514.110000,113867.300000,153773.430000,122782.750000,105751.030000,99281.340000,139553.160000,144135.980000,127864.550000,182645.560000,153032.060000,115641.280000,152701.920000,129219.610000,103057.490000,157693.920000,85047.440000,127056.210000,51283.140000,65947.930000,82982.090000,118546.050000,84710.770000,96189.630000,127382.300000,154806.140000,124153.040000,115816.210000,135426.920000,51743.150000,116983.800000],
            'Marketing': [471784.100000,443898.530000,407934.540000,383199.620000,366168.420000,362861.360000,127716.820000,323876.680000,311613.290000,304981.620000,229160.950000,249744.550000,249839.440000,252664.930000,256512.920000,261776.230000,264346.060000,282574.310000,294919.570000,0.000000,298664.470000,299737.290000,303319.260000,304768.730000,140574.810000,137962.620000,134050.070000,353183.810000,118148.200000,107138.380000,91131.240000,88218.230000,46085.250000,214634.810000,210797.670000,205517.640000,201126.820000,197029.420000,185265.100000,174999.300000,172795.670000,164470.710000,148001.110000,35534.170000,28334.720000,1903.930000,297114.460000,0.000000,0.000000,45173.060000],        
            'Profit':[192261.83,191792.06,191050.39,182901.99,166187.94,156991.12,156122.51,155752.6,152211.77,149759.96,146121.95,144259.4,141585.52,134307.35,132602.65,129917.04,126992.93,125370.37,124266.9,122776.86,118474.03,111313.02,110352.25,108733.99,108552.04,107404.34,105733.54,105008.31,103282.38,101004.64,99937.59,97483.56,97427.84,96778.92,96712.8,96479.51,90708.19,89949.14,81229.06,81005.76,78239.91,77798.83,71498.49,69758.98,65200.33,64926.08,49490.75,42559.73,35673.41,14681.4]    
            }
dataset = pd.concat([dataset, pd.get_dummies(dataset['State'])], axis=1)
dataset.columns

df = DataFrame(Startups,columns=['Floride','New_York','R&D','Administration','Marketing','Profit']) 

X = df[['Floride','New_York','R&D','Administration','Marketing']] # here we have 2 variables for multiple regression. If you just want to use one variable for simple linear regression, then use X = df['Interest_Rate'] for example.Alternatively, you may add additional variables within the brackets
Y = df['Profit']
print (X)
print (Y)

X = sm.add_constant(X) # adding a constant

model = sm.OLS(Y, X.astype(float)).fit() # Entrainement du modèle
predictions = model.predict(X) 

print_model = model.summary()
print(print_model)# Résumé des statistiques du modèle


#*************************************
####Test 2
#*************************************

#When concatenating along the columns (axis=1), a DataFrame is returned.
#When concatenating all Series along the index (axis=0), a Series is returned.


dataset =pd.read_csv('50_Startups.csv') # Importation d'un dataset sur des données sur la startup
dataset = pd.concat([dataset, pd.get_dummies(dataset['State'])], axis=1)
dataset.columns
dataset.head()

z = sm.add_constant(H) # Une constante pour notre prédiction
est = sm.OLS(o, z) # Simple modèle des moindre carrés
est2 = est.fit() # Entrainement du modèle
 
print(est2.summary()) # Résumé des statistiques du modèle


#*************************************
#####visualisation des résultats#####
#*************************************



################################
########Visualiser la sortie
################################

# Importation des packages
import pandas as pd
import numpy as np
#from sklearn import datasets, linear_model
from mpl_toolkits.mplot3d import Axes3D
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression
#import statsmodels.api as sm
#from scipy import stats

#dataset =pd.read_csv('50_Startups.csv')
# Récupérer l'ensemble des valeurs de la variable cible
#Y = dataset["Profit"]
# Récupérer les variables prédictives (on en a 2)
#x = dataset[['R&D Spend','Administration','Marketing Spend','State']]

#Répresentation des données
#x,y,z,v = np.loadtxt("50_Startups.csv", skiprows=1, unpack=True)

fig = plt.figure()
plt = fig.add_subplot(111, projection='3d')
#plt.plot_trisurf(x,y,z, edgecolor="gray", color="None")
#plt.scatter(x,y,z,v, s=100)
plt.scatter(X_test, y_test,color='red')# 
plt.plot(X_train, regressor.predict(X_train))
plt.show()

#ax.scatter(dataset["R&D Spend"], dataset["Administration"], dataset["Marketing Spend"], dataset["State"],dataset["profit"],c='r', marker='^')
#ax.scatter(dataset["R&D Spend"], dataset["Administration"], dataset["Marketing Spend"],c='r', marker='^')




################################
########Visualiser la sortie 2
################################
#startups = datasets.load_startups() # Importation d'un dataset sur des données sur le diabète
#X = diabetes.data # Nos variables indépendantes
#y = diabetes.target # Notre variable dépendante
#X2 = sm.add_constant(X) # Une constante pour notre prédiction
#est = sm.OLS(y, X2) # Simple modèle des moindre carrés
#est2 = est.fit() # Entrainement du modèle
 
#print(est2.summary()) # Résumé des statistiques du modèle




def countdown (n):
    while n > 0 :
        print (n)
       # n = n - 1
    print (Blastoff)
    
"""
while True:
    line = raw_input('>')
    if line =='done':
        break
    print (line)
print (Done)
"""
"""
def fibonacci(n) :
    if n in [0,1] :
        result = n
    else :
        result = fibonacci(n-1) + fibonacci(n-2)
    return result
    """
    
#print( [1, 2, 3] + [4, 5, 6]) :>[1, 2, 3, 4, 5, 6]
    

#print ([0] * 4)
#print ([1, 2, 3] * 4)