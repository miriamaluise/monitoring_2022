#ice melt in greenland
#proxy: LST (land surface temperature)

library(raster)
library(ggplot2)
library(RStoolbox)
library(patchwork)
library(viridis)

setwd("C:/lab/greenland/")

rlist <- list.files(pattern="lst")
rlist

import <- lapply(rlist, raster)
import

#let's make a stack
tgr <- stack(import)
tgr

cl <- colorRampPalette(c("blue", "light blue", "pink", "yellow")) (100)
plot(tgr, col=cl)

#let's use ggplot of first and final images 2000 vs 2015
#recall library

p1 <- ggplot() +
geom_raster(tgr$lst_2000, mapping = aes(x=x, y=y, fill=lst_2000)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2000")

p2 <- ggplot() +
geom_raster(tgr$lst_2015, mapping = aes(x=x, y=y, fill=lst_2015)) +
scale_fill_viridis(option="magma") +
ggtitle("LST in 2015")

#plot them together
p1 + p2

#plotting frequency distribution of data
par(mfrow=c(1,2))
hist(tgr$lst_2000)
hist(tgr$lst_2015)

par(mfrow=c(2,2))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)

dev.off()
plot(tgr$lst2010, tgr$lst_2015)
abline(0, 1, col="red")

plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
abline(0,1,col="red")

#make a plot with all the histograms and the regressions for all the values
par(mfrow=c(4,4))
hist(tgr$lst_2000)
hist(tgr$lst_2005)
hist(tgr$lst_2010)
hist(tgr$lst_2015)
plot(tgr$lst_2010, tgr$lst_2015, xlim=c(12500,15000), ylim=c(12500,15000))
plot(tgr$lst_2010, tgr$lst_2000, xlim=c(12500,15000), ylim=c(12500,15000))
#......

#instead do this way
pairs(tgr)










