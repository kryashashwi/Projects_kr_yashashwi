# -*- coding: utf-8 -*-
"""
Created on Sun Sep  3 21:11:50 2017

@author: kumar yashashwi
"""

"""
Since each feature is of different unit, standardizing it by subtracting mean
and dividing by standard deviation
Input  -> Non standardized x_train
Output -> Standardized x_train
"""
import numpy as np
def standardize(x_train):
	for i in range( np.shape(x_train)[1]):
		feature = x_train[:,i]
		u = np.mean(feature)
		sig = np.std(feature)
		if sig != 0: #Don't standardize if sigma=0
			feature = (feature - u)/float(sig)
		x_train[:,i] = feature
	return x_train