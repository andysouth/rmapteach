## ----eval=TRUE-----------------------------------------------------------

# load the package
library("ggplot2")

# load some data on mammal sleep patterns from the package
data(msleep)

# to show the 'str'ucture of the data
str(msleep)


# first plot
ggplot(data = msleep, aes(x = bodywt, y = awake)) +
    geom_point()

# aes (for aesthetic) sets up links between the data and aspects of the plot
# + adds layers to the plot, in this case points
# geom* stands for the geometric objects you can add to a plot
# bodywt and awake are columns within the data

# add an extra column to the aes
ggplot(data = msleep, aes(x = bodywt, y = awake, col = vore)) +
    geom_point()

# if you change col= to a column that is numeric it changes the legend
ggplot(data = msleep, aes(x = bodywt, y = awake, col = sleep_rem)) +
    geom_point()

# you can store the plot as an object (in this case called p) which can make modifying it easier
p <- ggplot(data = msleep, aes(x = bodywt, y = awake, col = sleep_rem))
p <- p + geom_point()
# type the variable name to display the plot 
p

# use themes to change the overall appearance of plots
# note that when typing this in RStudio it will show you the options once you've typed th...
p + theme_bw()


## ----eval=TRUE-----------------------------------------------------------

# we can log bodywt to space the points out more
p <- ggplot(data = msleep, aes(x = log(bodywt), y = awake, col = vore)) +
     geom_point()
p

# label the points for data exploration
p <- ggplot(data = msleep, aes(x = log(bodywt), y = awake, label = name)) +
     geom_point() + 
     geom_text()
p

# divide into subplots using facet_wrap()
p <- ggplot(data = msleep, aes(x = log(bodywt), y = awake, label = name)) +
    geom_point() + 
    facet_wrap(~vore)
p




## ----eval=TRUE-----------------------------------------------------------

#load some time-series data from ggplot2
data(economics)

# to show the 'str'ucture of the data
str(economics)

# geom_line()
ggplot(economics, aes(date, unemploy)) + geom_line()

#note that above aes(date, unemploy) assumes that these are to set x & y respectively
# this : aes(x=date, y=unemploy) would give an identical result

# another dataset economics_long is in 'long' format
# instead of having one column for each attribute (e.g. pop and unemploy)
# it has a column (variable) which has a repeated factor values for each date
# this allows us to create a plot with multiple lines 

data(economics_long)

ggplot(economics_long, aes(date, value01, colour = variable)) +
  geom_line()

#note that for each variable the value01 column has been scaled between 0 & 1 to fit on same scale


# geom_path can be used to look at the relationship of 2 variables over time
# unemployment and savings rate
p <- ggplot(economics, aes(unemploy/pop, psavert))
p + geom_path(aes(colour = date))

# note how the unemployment rate is calculated by unemploy/pop within the aes call
# you can do other calculations between columns in there 


## ----eval=TRUE-----------------------------------------------------------

# the diamonds dataset has > 50K diamonds (rows) in it

data(diamonds)
str(diamonds)

# a scatter plot is not very informative
p <- ggplot(diamonds, aes(x = carat, y = price, col = color))
p + geom_point()

# setting the alpha (transparency) level to < 1 can improve things but not much
p <- ggplot(diamonds, aes(x = carat, y = price, col = color))
p <- p + geom_point(alpha=0.3)

# geom_smooth adds a smoothed conditional mean which can help reveal patterns
p + geom_smooth()

# geom_histogram can be used to look at distributions 
p <- ggplot(data=diamonds) + geom_histogram(aes(x=price))
p

# most of the diamonds are cheap ! (relatively)


