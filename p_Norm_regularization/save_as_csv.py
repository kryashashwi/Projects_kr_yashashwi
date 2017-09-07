# -*- coding: utf-8 -*-
"""
Created on Sun Sep  3 22:56:07 2017

@author: kumar yashashwi

"""

"""
This function saves the output in csv format in the same directory
as required for kaggle competition

Input  ->  y_test 
Output ->  csv file and message if file is saved successfully
"""
def save_as_csv(output):
    import pandas as pd
    import numpy as np
    output=output.astype('int')
    Id=np.add(list(range(4000)),1)
    output_df=pd.DataFrame({'Id':Id, 'Output':output})
    output_df.set_index('Id', inplace=True)
    output_df.to_csv('output.csv',sep=',')
    msg='Output csv file saved successfully'
    return msg