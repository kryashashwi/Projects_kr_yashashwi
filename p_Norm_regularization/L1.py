# -*- coding: utf-8 -*-
"""
Created on Sun Sep  3 21:37:07 2017

@author: kumar yashashwi
"""

"""
This function fits a linear regression model with L1 Norm regularization. 
"""

"""
Input : x_train      -> Training data input
        y_train      -> Training data output
        lambda_reg   -> Regulariztion hyperparameter

Return : (m x 1) Final coefficients(weights) for the linear model 
          m is the number of features
"""
import numpy as np
import copy
#Since L1 norm is not derivable so sub gradient needs to be used
def sub_gradient(x,lr): 
	sub_grad = (np.abs(x)-lr)*(np.abs(x)>lr)*(np.sign(x))
	return sub_grad

def L1(x_train,y_train,lambda_reg):
    phiTphi=np.dot(np.transpose(x_train), x_train)
    phiTY=np.dot(np.transpose(x_train), y_train)
    w_old=np.random.rand(np.shape(x_train)[1]) 
    eig,v=np.linalg.eig(phiTphi)
    t = 1/(eig[0])
    for i in range(65):
        w_new=sub_gradient(w_old - t*(np.dot(phiTphi,w_old)-phiTY), lambda_reg*t/2)
        w_old=copy.deepcopy(w_new)
    w_final = w_new
    return w_final
    
    