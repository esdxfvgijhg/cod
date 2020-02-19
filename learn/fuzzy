#!/usr/bin/python
import numpy as np
import pandas as pd
BER = (0, 0.07)
RSSI = (-157.03, -111)
ToA = (0, 1.06)
def getFuzzy(x, List):
    M = 0
    if x >= List[0]:  # If a value is greater than the first item in a list..
        if x <= List[-1]:  # And if it is smaller than the last item in the list...
            top = float(x) - List[0]
            bottom = List[-1] - List[0]
            M = top / bottom
    #                return 9 #            if M >= 0.9:
    #                return 8 #            if M >= 0.8:
    #                return 7 #            if M >= 0.7:
    #                return 6 #            if M >= 0.6:
    #                return 5 #            if M >= 0.5:
    #                return 4 #            if M >= 0.4:
    #                return 3 #            if M >= 0.3:
    #                return 2 #            if M >= 0.2:
    #               return 1 #            if M >= 0.1:
    return M * 100 #            return 0
loraData = np.genfromtxt("data/S.csv", delimiter=",", dtype="str", skip_header=1)  # load the CSV file as a numpy matrix
X_Features = loraData[:, 4:7].astype(float)
n = len(X_Features)
for i in xrange(n):
    X_Features[i][0] = getFuzzy(X_Features[i][0], BER)
    X_Features[i][1] = getFuzzy(X_Features[i][1], RSSI)
    X_Features[i][2] = getFuzzy(X_Features[i][2], ToA)
df = pd.DataFrame(data=X_Features)
df.to_csv("data/X.csv", sep=",", header=True, float_format="%d", index=False)
# print getFuzzy(92, ToA) # print getFuzzy(208.14, BER)
# print X_Features # print getFuzzy(80, RSSI)
