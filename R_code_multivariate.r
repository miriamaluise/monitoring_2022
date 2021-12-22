# R code for measuring community interactions!

# install.packages("vegan")
library(vegan)
setwd("C:/lab/")

#load the data
load("biomes_multivar.RData")
#remember to put the extension

#list the file inside the data with ls function
ls()

multivar <- decorana(biomes)
multivar

plot(multivar)



#let's take a look at the grouping of species. Are them in the same biome?
#ordiellipse 
#first, attaching dataset with attach function
#to attach the biome types


attach(biomes_types)
ordiellipse(multivar, type, col=c("black", "red", "green", "blue"), kind= "ehull", lwd=3)
#the colour will represent 4 different ellipses

#now we can put the names for the biomes
#ordispider function
ordispider(multivar, type, col=c("black", "red", "green", "blue"), label=T)


 install.packages("sdm")
 library(sdm)
 
 











