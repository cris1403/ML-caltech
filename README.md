ML-caltech
==========
On January 2013 I attended an amazing Caltech's [Machine Learning Course - CS 156](https://work.caltech.edu/telecourse.html) by Professor Yaser Abu-Mostafa.
His explanations were clear and easily understandable and I strongly recommend the course for anybody who wants 
to really understand what machine learning is.

Here you find some algorithms and their R code.

## Perceptron Model (Lecture 1)
We have a vector of real-valued numerical input features and the response is a binary class *(+1,-1)*. In linear classification, 
we try to divide the two classes by a linear separator in the feature space. If *p = 2*, the separator is a line, 
if *p = 3* it’s a plane, and in general it’s a *(p − 1)-dimensional* hyper-plane in a *p-dimensional* space.

One of the older approaches to this problem in the machine learning literature is called the perceptron algorithm, 
and was invented by Frank Rosenblatt in 1956. This iterative algorithm takes the training data, starts with an
initial guess as to the separating plane’s weights, and then updates weights each time it picks a misclassified point.
In such cases, the algorithm changes the weights so that it behaves better on that particular point.
You get a correct solution (the algorithm converges) if the data are linearly separable. 

## The Linear Regression Model (Lecture 3)
In this case the response is a real-valued output. How do we choose the best hypothesis? We want to minimize the squared error.
It's a kind of snapshot of how your hypothesis is doing on your dataset. We want to minimize the error with respect to the weights, which means to put 
the first derivatives all equal to zero. This gives the formula to compute w by using the pseudo-inverse of X.

                             ->p     - 1 ->p     
mathbf{{boldsymbol{w}} =  {}(X    X )    X    Y}.,

