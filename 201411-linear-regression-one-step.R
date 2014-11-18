rm(list=ls())
library(fBasics)

trainobs = 100
testobs  = 1000
experiments = 1000

e_in = numeric()
e_out = numeric()


line = function(x){
  b = (p2[2] - p1[2])/(p2[1]-p1[1])
  a = (b * (x - p1[1])) + p1[2]
  return(a)
}

f = function (x1, x2) {
  if (x2 > line(x1)){return(1)}
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
	cm = table(f_train,g_train)
	e_in[i] = 1-sum(diag(cm))/sum(cm)
	
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
	cm = table(f_test,g_test)
	e_out[i] = 1-sum(diag(cm))/sum(cm)
	
	#cat("Experiment ", i, "In-sample error ", e_in[i], "Out-sample error", e_out[i], "\t", "\n")
  
}

media_in <- mean(e_in, na.rm = TRUE)
media_out <- mean(e_out, na.rm = TRUE)

cat("Average IN-SAMPLE Error ", media_in, "Average OUT-SAMPLE Error ", media_out, "\t")
