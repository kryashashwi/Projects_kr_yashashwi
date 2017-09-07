# -*- coding: utf-8 -*-
"""
Created on Sun Sep  3 20:59:18 2017

@author: kumar yashashwi
"""

"""
This function fits a linear regression model with L2 Norm regularization. 
"""

import numpy as np 
"""
Input : x_train      -> Training data input
        y_train      -> Training data output
        lambda_reg   -> Regulariztion hyperparameter

Return : (m x 1) Final coefficients(weights) for the linear model 
          m is the number of features
"""
def L2(x_train,y_train,lam):
    phiTphi=np.dot(np.transpose(x_train),x_train)
    lambdaI=lam*np.eye(len(phiTphi))
    invTerm=np.linalg.inv(phiTphi+lambdaI)
    T1=np.dot(invTerm,np.transpose(x_train))
    w=np.dot(T1,y_train)
    return w