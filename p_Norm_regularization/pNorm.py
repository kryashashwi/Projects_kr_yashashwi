# -*- coding: utf-8 -*-
"""
Created on Sun Sep  3 21:52:13 2017

@author: kumar yashashwi
"""

"""
This function fits a linear regression model with p Norm regularization where 1<p<2. 
The method used is Stochastic adaptive gradient descent.
"""

import numpy as np
import copy

def grad(phi,w,y):
    """
    Input : phi -> the feature matrix
            w   -> the linear model coefficient
            y   -> y_train
    Return : gradient corresponding to the cost function 
    """
    T1 =2*np.multiply(np.transpose(phi),(np.dot(phi, w) - y))
    T3 =p* lam*np.multiply((np.power(np.abs(w),p-1)),np.sign(w))
    gradient= np.add(T1,T3)
    return gradient
def pNorm(x_train,y_train,lambda_reg,order):
    """
    Input : x_train      -> Training data input
            y_train      -> Training data output
            lambda_reg   -> Regulariztion hyperparameter
            order        -> Regularization Norm order
    Return : Final coefficients for the linear model 
    """
    phi=x_train.astype('float')
    y=y_train.astype('float')
    np.random.seed(seed=1) #For giving same random initialization on successive code runs
#    Initialization of parameters
    global p,lam  
    p=order
    lam=lambda_reg
    w_old = np.random.rand(np.shape(phi)[1]) 
    precision=0.01  # tolerance value to exit the optimization
    t=0.1 #Learning rate for gradient descent
    tolerance=1  #Initialize it to a high value to enter the while loop 
    aGrad = np.zeros(np.shape(phi)[1])
    error=0  #Initialize it to a high value to enter the while loop 
    while (tolerance>precision): #Do until this optimization converges
#        print(tolerance)
        for i in range(len(phi)):
            #Applying Adaptive SGD
            grad1= grad(phi[i],w_old,y[i])  
            grad1 = np.array(grad1).astype('float')
            aGrad = np.multiply(grad1, grad1)+aGrad
            w_new= (w_old-t*np.divide(np.array(grad1),np.sqrt(np.array(aGrad))))
            #Updating weights 
            w_old=copy.deepcopy(w_new)

        y_pred=np.dot(phi,w_old)
        error_old=copy.deepcopy(error)
        error=np.sqrt((np.linalg.norm((y_pred-y),ord=2)))
        tolerance=abs(error-error_old) #Evaluating stop condition
        
    return w_old
