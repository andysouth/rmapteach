## ----eval=FALSE, tidy=FALSE----------------------------------------------
#  
#  # # indicates a comment
#  
#  # a 'package' is a collection of functions, data and documentation
#  
#  # to install a package from CRAN just need to do once initially
#  # & maybe every few months to check for updates
#  install.packages("ggplot2") # note the quotes
#  
#  # 'library' to load a package in each new session
#  library(ggplot2)
#  
#  # <- to assign things to an object
#  # c() to concatenate things together
#  object <- c(1:10)
#  object2 <- c("apples","oranges")
#  
#  # things without quotes tend to be objects, whereas with quotes are strings
#  # contrast "object" with object
#  
#  # str(), head() and class() give information about an object
#  str(object)
#  head(object)
#  class(object)
#  
#  # functions are crucial and are used by a function call like this :
#  # function_name(argument1=a, argument2=b)
#  # arguments to a function can be specified by name or their position in the call
#  
#  # dataframes are key for holding data
#  # they consist of rows and columns
#  d_f <- data.frame(fruit=c("apples","oranges"), taste_score=c(1,10))
#  d_f
#  # elements can be accessed by [rownum,colnum]
#  d_f[2,1]
#  # missing out either will give you all
#  d_f[,1]
#  # which can be used to find the elements that satisfy a condition
#  which(d_f[,1] =="oranges")
#  

