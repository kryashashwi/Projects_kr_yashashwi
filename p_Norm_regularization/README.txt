This project tries out a general p Norm regularization

Note: 1)Run template.py file to get output.csv file
      2)To try for specific p(Norm ordr) and regularization parameter(lambda_reg) do the following:
	  a)Uncomment line 94  in file template.py
	  b)Comment out line 96 in file template.py
	  c)Put values of p(LINE 93) and lambda_reg(LINE 92) in file template.py
	  d)For 1<p<2, the code will take some time to generate result, so be patient.
---------------------------------------------------------------------------------------------
Description of all files

1)getY.py           : returs the output value if the training data
2)give_features.py  : returns the m by n matrix used to develop regression model, 
		      m is number of examples in train data, n is number of features
3)L1.py  	    : returns weight vector n by 1 using L1 regularization
4)L2.py		    : returns weight vector n by 1 using L2 regularization
5)pNorm.py   	    : returns weight vector n by 1 using p Norm regularization
6)save_as_csv.py    : save the output for test data in csv format
7)standardize.py    : returns the m by n matrix used to develop regression model after standardizing
8)template.py       : main file that calls all other function
9)my_w_best.pkl	    : pickle file for weight vector that gives least RMSE on test data
10)output.csv	    : result of test data
11)GD_behavious.jpeg: Plot of behavioue of gradient descent for  p=1, p=2, p=1.5
------------------------------------------------------------------------------------------------------------------------
Feature Engineering :

Initially I removed the date column in the train.csv to do the calucaltions. Upon testing on validatin data set.
I was getting 101+ RMSE. After that I used date as a feature which basically was the number of days from start 
of the year 2016. For time I used number of minutes from start of the day. This reduced my RMSE by 2. Then I tried
using different set of features but it only resulted in increase of error. Finally I used simulated annealing algorithm 
for feature selection. The input to this was select features at random and the cost was RMSE on validation data. The
error reduced on validation data by nearly 1 but increased on test data so I came back to using al the given features.
-------------------------------------------------------------------------------------------------------------------------

Behaviour of gradient descent on different values of p :

NOTE : Refer to file SGD_behaviour.jpg
For p=2 (L2 norm), gradient descent converges quickly 
For p=1 (L1 norm), gradient descent converges quickly but starting value is high
for p=1.5, gradient descent takes larger number of iterations to converge 
These trends are clear from the plot
----------------------------------------------------------END------------------------------------------------------------


