#R_code_quantitative_estimates_land_cover.r

library(raster)
library(RStoolbox)
library(ggplot2)
setwd("C:/lab/")

#1 do the list the files available with list.files
rlist<- list.files(pattern="defor")

#2 lapply function that has two arguments 
#apply a function to a list
#lapply(x, FUN)

list_rast <- lapply(rlist, brick)
list_rast

plot(list_rast[[1]]) #the square parenthesis are used instead of the dollar 

#this time no stack because we want to treat them singularly

#defor: NIR 1, red 2, green 3 and everything will be red
plotRGB(list_rast[[1]], r=1, g=2, b=3, stretch="lin")

#list_rast[[1]] is too long as a name so we can reassign a new name to it
l1992 <-list_rast[[1]]
plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

l2006 <- list_rast[[2]]
plotRGB(l2006, r=1, g=2, b=3, stretch="lin")


#how to explain to the software where is the forest
#classifying the images according to their different reflectance
#using RStoolbox package
#using unsuperClass function

l1992c <- unsuperClass(l1992, nClasses=2)

plot(l1992c$map)
#value 1= forest
#value 2= agricultural and water

freq(l1992c$map)
#forest 306312
#agricultural 34980
#the count may be different because some pixels can be classified as others

total <- 341292
propagri <-34980/total
propforest <- 306312/total


propagri  0.1024929 
0.11
propforest 0.8975071     
0.89

#build a dataframe

cover <-c("Forest", "Agriculture")
prop1992 <-c(0.8975071, 0.1024929)
proportion1992 <- data.frame(cover, prop1992)

#ggplot 
ggplot(proportion1992, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white")


#_____________________________day 2
library(raster)
library(RStoolbox) #we are going to use this for the classification project
library(ggplot2)

setwd("C:/lab/")
# brick
# 1 list the files available
rlist <- list.files(pattern="defor")
rlist

list_rast <- lapply(rlist, brick) # lapply(x, FUN)
list_rast

l1992 <- list_rast[[1]]
l2006 <- list_rast[[2]]


plotRGB(l1992, r=1, g=2, b=3, stretch="lin")

l1992c <- unsuperClass(l1992, nClasses=2)
#we are going to use two classes: one for forests and one for agriculture

plot(l1992c$map)
#value 1: agriculture
#value 2: forest

freq(l1992c$map)
#value 1 34407
#value 2 306885

total <-341292
propagri <-    34407/total
propforest <-   306885/total

#agriculture and water 0.10
#forest 0.90


# Classification of 2006
# Unsupervised classification
l2006c <- unsuperClass(l2006, nClasses=2) # unsuperClass(x, nClasses) 
l2006c

plot(l2006c$map)
# forest: value 1
# agriculture: value 2

# Frequencies
freq(l2006c$map)

#  value  count
#[1,]     1 179374 # forest
#[2,]     2 163352 # agriculture

# Proportions

total <- 342726
propagri2006 <- 163352/total
propforest2006 <- 179374/total

# build a dataframe
cover <- c("Forest", "Agriculture")
prop1992 <- c(propforest, propagri)
prop2006 <- c(propforest2006, propagri2006)

proportion <- data.frame(cover, prop1992, prop2006)

proportion
ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)

# plotting altogether

p1 <- ggplot(proportion, aes(x=cover, y=prop1992, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)
p2 <- ggplot(proportion, aes(x=cover, y=prop2006, color=cover)) + geom_bar(stat="identity", fill="white") + ylim(0,1)


#plot 2 graphs with gridExtra
# grid.arrange(p1, p2, nrow=1)
#or with patchwork package
library(patchwork)
p1+p2

#if you want ot put one graph in top of the other
p1/p2
#instead of using plotRGB we are going to use ggRGB
#common stuff
plotRGB(l1992, r=1, g=2, b=3, stretch="Lin")
#with ggRGB
ggRGB(l1992, r=1, g=2, b=3)
ggRGB(l1992, r=1, g=2, b=3, stretch="lin")    
ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
#with sqrt we are compacting the data
ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
ggRGB(l1992, r=1, g=2, b=3, stretch="log")

#to see all these graphs all together
#patchwork
gp1 <- ggRGB(l1992, r=1, g=2, b=3, stretch="lin")
gp2 <- ggRGB(l1992, r=1, g=2, b=3, stretch="hist")
gp3 <- ggRGB(l1992, r=1, g=2, b=3, stretch="sqrt")
gp4 <- ggRGB(l1992, r=1, g=2, b=3, stretch="log")
gp1 + gp2 + gp3 + gp4

#multitemporal patchwork
gp1 <- ggRGB(l1992, r=1, g=2, b=3)
gp5 <- ggRGB(l2006, r=1, g=2, b=3)

gp1 + gp5
gp1/gp5



















