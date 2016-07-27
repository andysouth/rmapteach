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


## ----eval=FALSE----------------------------------------------------------
#  install.packages("tmap")

## ----eval=TRUE-----------------------------------------------------------
library("tmap")

## ----eval=TRUE-----------------------------------------------------------

# load data from tmap
data(Europe)
# set shapes and fill them
tm_shape(Europe) +
  tm_fill("purple")

# load data from tmap
data(World)
# set shapes and fill them
tm_shape(World) +
  tm_fill("green")

# check what data are associated with a map using 'str(*@data)', str stands for structure
str(World@data)
str(Europe@data)
# note that str(Europe) shows all the geometry information too and is not very useful here

# check the contents of Factor variables using 'levels'
levels(Europe$part)
# levels(Europe@data$part) gives the same output, you don't always need the @data to get at the variables 

# plot a subset of the map using '[which(*),]'
tm_shape(Europe[which(Europe$part=='Northern Europe'),]) +
  tm_fill("red")


# check the contents of numeric variables using 'hist'
hist(Europe$pop_est)

# fill polygons on a map based on data variables
# factor
tm_shape(Europe) +
  tm_fill("part")
# numeric
tm_shape(Europe) +
  tm_fill("pop_est")

# the previous commands used default colours, you can modify these with 'palette'
tm_shape(Europe) +
  tm_fill("pop_est", palette = "YlGnBu")
# to see available palettes 
RColorBrewer::display.brewer.all()

# to add a histogram to the legend
tm_shape(Europe) +
  tm_fill("pop_est", palette = "YlGnBu", legend.hist = TRUE)
  
# maps are stored as a SpatialPolygonsDataFrame from the package sp
# you can find this out by typing
class(Europe)


## ----eval=FALSE----------------------------------------------------------
#  # to see help use '?'
#  ?tm_fill
#  
#  # syntax is like ggplot2 (e.g. + to add layers)
#  
#  # start with one of the code examples above and change something ...
#  
#  

## ----eval=TRUE-----------------------------------------------------------

# load some tmap point data for metropolitan areas
data(metro)
# ?metro gives information about the data
# this is also an sp object with associated variables
class(metro)
str(metro@data)

# plot points as bubbles
tm_shape(metro) +
    tm_bubbles("pop2010", legend.size.show = FALSE)

# plot points on top of a European map
tm_shape(Europe) +
  tm_borders() +
tm_shape(metro) + 
  tm_bubbles("pop2010")


## ----eval=TRUE-----------------------------------------------------------

# load some data from tmap
data(land)

class(land)

str(land@data)

tm_shape(land) + 
    tm_raster("trees", breaks=seq(0, 100, by=20) )

tm_shape(land) + 
    tm_raster("trees", breaks=seq(0, 100, by=50) )

# categorical land cover
tm_shape(land) + 
    tm_raster("cover")

# using faceting

# facet by cover to get one map for each cover type
tm_shape(land) + 
    tm_raster("cover", legend.show = FALSE) +
    tm_facets("cover", free.coords=TRUE, drop.units=TRUE)   


# facet by country to get one cover map per country
tm_shape(land) + 
    tm_raster("cover") + # , legend.show = FALSE)
tm_shape(Europe[which(Europe$part=="Northern Europe"),]) +
    tm_borders() +
    tm_facets("name", free.coords = TRUE)


## ----eval=TRUE-----------------------------------------------------------

# create a very simple data frame as an example
dF <- data.frame( country=c("Spain", "United Kingdom"),
                  weather=c("hot", "cold") )

# tmap can join this onto a map (other options are available too)
Eu_and_dat <- append_data(Europe, dF, key.shp="name", key.data="country")

tm_shape(Eu_and_dat) +
  tm_fill("weather", palette=c("red","blue"))


## ----eval=FALSE----------------------------------------------------------
#  
#  # Can you plot some other data by country ?
#  # remember the country names in the tmap map are in Europe$name
#  install.packages("gapminder")
#  library(gapminder)
#  ?gapminder
#  str(gapminder)
#  
#  Eu_and_gap <- append_data(Europe, gapminder[gapminder$year==2007,], key.shp="name", key.data="country")
#  
#  tm_shape(Eu_and_gap) +
#     tm_fill("lifeExp")
#  

## ----eval=FALSE----------------------------------------------------------
#  # other useful packages, resources
#  
#  # packages for creating the circular migration plots I showed this morning
#  install.packages("migest")
#  install.packages("circlize")
#  
#  
#  # raster package, great for mapping satellite data etc.
#  install.packages("raster")
#  library(raster)
#  
#  # rmapshaper for simplifying polygon boundaries
#  install.packages("rmapshaper")
#  library(rmapshaper)
#  
#  
#  

