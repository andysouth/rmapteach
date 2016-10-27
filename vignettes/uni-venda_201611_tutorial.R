## ----eval=FALSE----------------------------------------------------------
#  #install if not installed already
#  if (require(tmap)) install.packages("tmap")

## ----eval=TRUE-----------------------------------------------------------
library("tmap")

## ----eval=TRUE-----------------------------------------------------------


# load data from tmap
data(World)
# set shapes and fill them
tm_shape(World) +
  tm_fill("green")

# check what data are associated with a map using 'str(*@data)', str stands for structure
str(World@data)

# check the contents of Factor variables using 'levels'
levels(World$continent)

# plot a subset of the map using '[which(*),]'
tm_shape(World[which(World$continent=='Africa'),]) +
  tm_fill("red")

# check the contents of numeric variables using 'hist'
hist(World$pop_est_dens)

# fill polygons on a map based on data variables
# factor
tm_shape(World) +
  tm_fill("continent")

# numeric
tm_shape(World[which(World$continent=='Africa'),]) +
  tm_fill("pop_est_dens")

# to add a histogram to the legend
tm_shape(World[which(World$continent=='Africa'),]) +
  tm_fill("pop_est_dens", legend.hist = TRUE)

# the previous commands used default colours, you can modify these with 'palette'
# and make continuous with style='cont'
tm_shape(World[which(World$continent=='Africa'),]) +
  tm_fill("pop_est_dens", palette = "YlGnBu", style='cont')

# to see available palettes 
RColorBrewer::display.brewer.all()

# maps are stored as a SpatialPolygonsDataFrame class from the package sp
# you can find this out by typing
class(World)


## ----eval=FALSE----------------------------------------------------------
#  # to see help use '?'
#  ?tm_fill
#  
#  # syntax is like ggplot2 (e.g. + to add layers)
#  
#  # start with one of the code examples above and change something
#  # e.g. change tm_fill("pop_est_dens") to tm_fill("area")
#  # or one of the other fields shown in str(World@data)
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

# plot points on top of a map
tm_shape(World[which(World$continent=='Africa'),]) +
  tm_borders() +
tm_shape(metro) + 
  tm_bubbles("pop2010")


## ----eval=TRUE-----------------------------------------------------------

# load some data from tmap
data(land)

class(land)

str(land@data)

# plot land and add raster of trees
tm_shape(land) + 
    tm_raster("trees", breaks=seq(0, 100, by=20) )

# plot land and add categorical land cover
tm_shape(land) + 
    tm_raster("cover")


# just for a selected country
tm_shape(World[which(World$name=='South Africa'),], is.master=TRUE) +
    tm_borders() +
tm_shape(land) + 
    tm_raster("cover")


# using faceting to create multiple plots

# facet by cover to get one map for each cover type
tm_shape(land) + 
    tm_raster("cover", legend.show = FALSE) +
    tm_facets("cover", free.coords=TRUE, drop.units=TRUE)   


# facet by country to get one cover map per country
tm_shape(land) + 
    tm_raster("cover") + 
tm_shape(World[which(World$continent=='Africa'),]) +
    tm_borders() +
    tm_facets("name", free.coords = TRUE)


## ----eval=TRUE-----------------------------------------------------------

# create a very simple data frame as an example
dF <- data.frame( country=c("South Africa", "United Kingdom"),
                  weather=c("hot", "cold") )

# tmap can join this onto a map
World_and_dat <- append_data(World, dF, key.shp="name", key.data="country")

tm_shape(World_and_dat) +
  tm_fill("weather", palette=c("blue", "red"))

# Can you change this to plot a different map ? 
# Maybe add other countries or a different variable.


## ----eval=FALSE----------------------------------------------------------
#  #install if not installed already
#  if (require(leaflet)) install.packages("leaflet")

## ----eval=FALSE----------------------------------------------------------
#  library(leaflet)
#  # to see help on the package
#  ?leaflet
#  
#  # create a default map
#  mymap = leaflet() %>% addTiles()
#  
#  # use %>% (called a 'pipe') to modify the map
#  
#  # set view by a point (long, lat) and zoom level
#  mymap %>% setView(32, -26, zoom=10)
#  
#  # set view by the edges
#  #fitBounds(lng1, lat1, lng2, lat2)
#  mymap %>% fitBounds(30, -29, 35, -24)
#  

## ----eval=FALSE----------------------------------------------------------
#  
#  # a new package for getting world bank data
#  install.packages("wbstats")
#  # http://www.r-bloggers.com/new-r-package-to-access-world-bank-data/
#  
#  # raster package, great for mapping satellite data etc.
#  install.packages("raster")
#  library(raster)
#  
#  # rmapshaper for simplifying polygon boundaries
#  install.packages("rmapshaper")
#  library(rmapshaper)
#  
#  # leaflet a package for creating interactive maps
#  install.packages("leaflet")
#  
#  

