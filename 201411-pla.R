trainobs = 10
testobs  = 100
experiments = 1000

iterations = numeric()
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
  
  
# run experiments
for (i in 1: experiments){
    
    # build a train set
    train = cbind(1,runif(trainobs,-1,1),runif(trainobs,-1,1))

    # in this exercise f - the target function - is known
    # compute f on the train set
    f_train = numeric()
    for (m in 1:trainobs){
      f_train[m] = f(train[m,2],train[m,3])
    }
    
    # find the final hypothesis from the hypothesis set of PERCEPTRONS using the Perceptron Learning Algorithm
    w <- c(0,0,0)
    iteration <- 0 
    
    done <- 0
    while (done == 0) {       
      iteration <- iteration + 1
      wrongPoints <- 0
      for (m in 1:trainobs) {
        
        if (sign(t(w) %*% train[m,]) != f_train[m]) {
          w <- w + f_train[m] * train[m,]
          wrongPoints <- wrongPoints + 1
          break
        }
      } 
      
      if (wrongPoints == 0) {
        done <- 1
      } 
    }
    
    iterations[i] <- iteration
    
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
    
    cat("Experiment ", i, "Iterations ", iterations[i], "In-sample error ", e_in[i], "Out-sample error", e_out[i], "\n")

}

average_it  <- mean (iterations, na.rm = TRUE) 
cat("Average Number of Iterations needed by PLA to converge: ", average_it, "\n")

media_in <- mean(e_in, na.rm = TRUE)
cat("Average IN-SAMPLE Error should be 0 and is ", media_in, "\n")

media_out <- mean(e_out, na.rm = TRUE)
cat("Average Error ", media_out, "\n")
