rm(list=ls())
library(fBasics)

trainobs = 100
testobs  = 100
experiments = 100

e_in = numeric()
e_out = numeric()

line = function(x){
  b = (p2[2] - p1[2])/(p2[1]-p1[1])
  y = (b * (x - p1[1])) + p1[2]
  return(y)
}

f = function (px1, px2) {
  if (px2 > line(px1)){return(1)}
  else {return(-1)}
}

for (i in 1: experiments){
  
  # pick a target function f (i.e a line in the [-1,1] * [-1,1] plane)
  # choose two random points p1 and p2
  p1 <- runif(2, -1, 1)
  p2 <- runif(2, -1, 1)
  
	# build a train set
	train = cbind(1,runif(trainobs,-1,1),runif(trainobs,-1,1))
	
	# in this exercise f - the target function - is known
	# compute f on the train set
	f_train = numeric()
	for (m in 1:trainobs){
	  f_train[m] = f(train[m,2],train[m,3])
	}
	
	# find the final hypothesis from the hypothesis set of Linear Regression Models
	# LINEAR REGRESSION ALGORITHM - one-step solution
 	
	w = inv(t(train) %*% train) %*% t(train) %*% f_train
	
	# check if the final hypothesis works
	g_train = numeric()
	for (m in 1:trainobs){
	  g_train[m] = sign(t(w) %*% train[m,])
	}
	
	# compare g_train and f_train: e_in
	e_in[i] = sum(f_train != g_train) / trainobs
	
	# then build a test set
	test = cbind(1,runif(testobs,-1,1),runif(testobs,-1,1))
	
	# compute f on the test set
	f_test = numeric()
	for (m in 1:testobs){
	  f_test[m] = f(test[m,2],test[m,3])
	}
	
	# apply the final hypothesis to test set
	g_test = numeric()
	for (m in 1:testobs){
	  g_test[m] = sign(t(w) %*% test[m,])
	}
	
	# compare g_test and f_test: e_out
	e_out[i] = sum(f_test != g_test) / testobs
	
	cat("Experiment ", i, "In-sample error ", e_in[i], "Out-sample error", e_out[i], "\t", "\n")
  
  if (e_in[i]> 0.8){break}
  
}

media_in <- mean(e_in, na.rm = TRUE)
media_out <- mean(e_out, na.rm = TRUE)

cat("Average IN-SAMPLE Error ", media_in, "Average OUT-SAMPLE Error ", media_out, "\t")
