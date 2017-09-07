#!/bin/python3

import numpy as np
import pickle
import pandas as pd
import copy
from give_features import give_features
from standardize import standardize
from getY import getY
from L2 import L2
from L1 import L1
from pNorm import pNorm
from save_as_csv import save_as_csv

def get_feature_matrix(file_path):
    """
    file path: path to  the file assumed to be in the same format as
               either train.csv or test_features.csv in the Kaggle competition


    Return: A 2-D numpy array of size n x m where n is the number of examples in
            the file and m your feature vector size
    
    """
    feature_matrix=give_features(file_path)
    return feature_matrix

def get_output(file_path):
    """
    file_path: path to a file in the same format as in the Kaggle competition

    Return: an n x 1 numpy array where n is the number of examples in the file.
            The array must contain the Output column values of the file

    NOTE: Preserve the order of examples in the file
    """
    output_values=getY(file_path)

    return output_values

def get_weight_vector(feature_matrix, output, lambda_reg, p):
    w=[]
    check =True
    """
    feature_matrix: an n x m 2-D numpy array where n is the number of samples
                    and m the feature size.
    output: an n x 1 numpy array reprsenting the outputs for the n samples
    lambda_reg: regularization parameter
    p: p-norm for the regularized regression

    Return: an m x 1 numpy array weight vector obtained through stochastic gradient descent
            using the provided function parameters such that the matrix product
            of the feature_matrix matrix with this vector will give you the
            n x 1 regression outputs
    """
    if(p<1 or p>2):
        check = False
        return w,check
        
    
    x_train=copy.deepcopy(feature_matrix)
    x_train=standardize(x_train)
#    y_train=getY()
    if p==2:
        w=L2(x_train,y_train,lambda_reg)
    elif p==1:
        w=L1(x_train,y_train,lambda_reg)
    else:
        w=pNorm(x_train,y_train,lambda_reg,p)
    return w,check
    
    
def get_my_best_weight_vector():
    """
    Return: your best m x 1 numpy array weight vector used to predict the output for the
            kaggle competition.

            The matrix product of the feature_matrix, obtained from get_feature_matrix()
            call with file as test_features.csv, with this weight vector should
            result in you best prediction for the test dataset.

    """
    with open('my_w_best', 'rb') as f:
        w_best = pickle.load(f)
    return w_best
    
   
check=True #Imposing check condition in case invalid p is given
feature_matrix=get_feature_matrix('train.csv')
y_train=get_output('train.csv')
lambda_reg=3 #Change value of regularization parameter here
p=1.5 #Change value of p here
#Uncomment line 94 to try for specific p and regularization parameter(lambda_reg) and comment out line 96
#w,check=get_weight_vector(feature_matrix, y_train, lambda_reg, p) 
if(check):
    w=get_my_best_weight_vector()
    x_test=give_features('test_features.csv')
    x_test=standardize(x_test)
    output_values=np.dot(x_test,w)
    y_test=(output_values).astype('int')
    msg=save_as_csv(y_test)
    print(msg)
else:
    print('Invalid p given. 1<=p<=2')

