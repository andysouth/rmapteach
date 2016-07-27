## ----eval=FALSE, tidy=FALSE----------------------------------------------
#  #first install devtools to enable install from GitHub
#  install.packages("devtools")
#  library(devtools)
#  install_github('AndySouth/rmapteach')

## ----eval=TRUE-----------------------------------------------------------
library("rmapteach")

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
# bodywt and awake are columns within the data

# add an extra column to the aes
ggplot(data = msleep, aes(x = bodywt, y = awake, col = vore)) +
    geom_point()

# if you change col= to a column that is numeric it changes the legend
ggplot(data = msleep, aes(x = bodywt, y = awake, col = sleep_rem)) +
    geom_point()


## ----eval=TRUE-----------------------------------------------------------

# we can log bodywt to space the points out more
ggplot(data = msleep, aes(x = log(bodywt), y = awake, col = vore)) +
    geom_point()

# label the points for data exploration
ggplot(data = msleep, aes(x = log(bodywt), y = awake, label = name)) +
    geom_point() + 
    geom_text()

# divide into subplots using facet_wrap()
ggplot(data = msleep, aes(x = log(bodywt), y = awake, label = name)) +
    geom_point() + 
    facet_wrap(~vore)


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

# Can you plot some other data by country ?
# remember the country names in the map are in Europe$name
# TODO me to add getting data from another package



## ----eval=TRUE-----------------------------------------------------------
# to list datasets in the tmap package
data(package="tmap")




## ----eval=FALSE----------------------------------------------------------
#  # other useful packages, resources
#  
#  # raster package
#  library(raster)
#  
#  # rmapshaper for simplifying polygon boundaries
#  library(rmapshaper)
#  
#  
#  
#  
#  

