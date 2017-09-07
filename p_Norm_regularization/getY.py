
# -*- coding: utf-8 -*-
"""
Created on Sun Sep  3 21:19:01 2017

@author: kumar yashashwi
"""

"""
Get output of the training data set
Output -> Give y_train
"""
def getY(filepath):
    import pandas as pd
    df=pd.read_csv(filepath, sep=',', delimiter=None)
    df1 =df.as_matrix()
    df2=df1[:,2:]
    y_train=df2[0:len(df2),-1]
    return y_train