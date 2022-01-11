#R code for species distribution modelling, namely the distribution of individual 

library(sdm)
library(raster) #predictors
library(rgdal) #species

#system.file function shows all the files in a certain package
file <- system.file("external/species.shp", package="sdm")
file
#you will see the path in which are the data

#shapefile function exactly as the raster function for raster files
species <- shapefile(file)
plot(species, pch=17, col="blue")

#_______________________________________________day 2
library(sdm)
library(raster) #predictors
library(rgdal) #species

#predictors environmental variable used to predict where the species can be found over space
#rgdal used for coordinate data
#raster used to plot all the predictors

#check for the species data
#system.file function that make list of all file recorded in a certain folder
file <- system.file("external/species.shp", package="sdm")
file

#shapefile function is the correspondent funcion to raster
#you use raster to import raster data

species <- shapefile(file)
species
#each row of the table is a point

#Occurrence only variable
species$Occurrence
#if you find the species you have 1, otherwise 0

#make a subset

#how many occurrences are there (the 1s)? subset dataframe
presences <- species[species$Occurrence == 1,]
#[] for subset
#94 are the occurences out of 200
absences <- species[species$Occurrence == 0,]
#106 are the absences out of 200

#plot
plot(species, pch=19 )
#pch 19 is a circle

#instead of the all occurrences, plot only the presences
plot(presences, pch=19, col="blue")
#lower amount of points with respect to the previous plot since now is 94 point

#add plot both presences and absences together 
plot(presences, pch=19, col="blue")
points(absences, pch=19, col="red")

#let's look at the predictors
#put the path in which they are located
path <- system.file("external", package="sdm")
path

lst <- list.files(path, pattern="asc", full.names=T)
lst
#list.files make a list of the files

#you can use the lapply function with the raster function but in this case is not needed
preds <- stack(lst)
preds

#plot the predictors
cl <- colorRampPalette(c('blue','orange','red','yellow')) (100)
plot(preds, col=cl)

#plot only elevation and on top of it presences
plot(preds$elevation, col=cl)
points(presences, pch=19)
#points is used to add a plot and avoid to erase the previouos one, that would happen if we use plot insead of point
#most of the individuals are found on small elevation

#plot temperature
plot(preds$temperature, col=cl)
points(presences, pch=19)

#vegetation
plot(preds$vegetation, col=cl)
points(presences, pch=19)

#precipitation
plot(preds$precipitation, col=cl)
points(presences, pch=19)

#_________________________________________________day 3
#importing the source script
setwd("C:/lab/") #to tell R where to find the script
source("R_code_source_sdm.r.txt")

#in the theoretical slide of SDMs we should 


datasdm <- sdmData( train=species, predictors=preds)

#sdm model
#sdm function fit and evaluate species distribution data
#sdm(formula, data, methods, ...)
#occurrences is the y for the formula
#temperature, elevation, precipitation, vegetation are the x
m1 <- m1 <- sdm(Occurrence~temperature+elevation+precipitation+vegetation, data=datasdm, methods="glm")

#the model produces slopes and intercepts
#now with this model we should do the predictions



















