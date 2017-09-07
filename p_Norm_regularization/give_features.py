# -*- coding: utf-8 -*-
"""
Created on Mon Sep  4 21:16:30 2017

@author: kumar yashashwi
"""

"""
This function gives the feature matrix to be used for making linear regression model
Input  -> train.csv filepath
Output -> Feature matrix of size m-by-n. m is number of training samples and n is number of features
"""
def give_features(file_path):
    import pandas as pd
    import numpy as np
    df=pd.read_csv(file_path, sep=',', delimiter=None)
    df1 =df.as_matrix()
    if(file_path=='train.csv'):
        df2=df1[:,2:-1] #Removing the y(output) value to get feature matrix 
    else:
        df2=df1[:,2:]
    feature_matrix=df2.astype('float')
    #Using data as a feature my converting it to number of days in the year
    #Using time as a feature my calculating number of minutes 
    date_time=df.date.astype('str') 
    date=[]
    time=[]
    for i in range(len(date_time)):
        date.append(date_time[i].split(' ')[0]) #Get date
        time.append(date_time[i].split(' ')[1]) #Get time
    featue_date=[]
    feature_time=[]
    for i in range(len(date)):
        temp_date=date[i].split('-')
        featue_date.append((int(temp_date[1])-1)*30+int(temp_date[2])) #Make data a feature
        temp_time=time[i].split(':')
        feature_time.append((int(temp_time[0])*24)+int(temp_time[1]))  #Make time a feature
    a=np.ones(len(feature_matrix))   
    featue_date = np.array(featue_date).astype('float')
    feature_time = np.array(feature_time).astype('float')
    #Concatanating  different features to return final feature matrix
    feature_final=np.column_stack((featue_date,feature_time,feature_matrix,a))
    return feature_final
    