#################################Exam project for monitoring ecosystems and functioning##################################à

#The report from Greenpeace "Dangerous man, dangerous deals" highlights the dramatic changes impacting the Amazon rainforest under the Brazilian President Jair Bolsonaro
#In just three years deforestation has increased by 75.6 percent and fire hotspots alerts grew by 24 percent. 
#Greenhouse gas emissions in Brazil increased 9.5 percent since Bolsonaro took office.
#Bolsonaro assumed office the 1st January 2019


#I wanted to study the changes of FCover in a time scale that goes from 2018-2019-2020
#The Fraction of Vegetation Cover (FCover) corresponds to the fraction of ground covered by green vegetation. 
#Practically, it quantifies the spatial extent of the vegetation.

#data on https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home

#libraries needed
library(raster) #Raster data are saved in pixels, each one represents an area on the Earth's surface.
library(ncdf4) #Used to read Copernicus data
library(RStoolbox) #Toolbox for remote sensing image processing and analysis
library(ggplot2) #To make plots
library(patchwork) #To combine separate ggplots into the same graphic
library(viridis) #Palette for plots
library(ggpubr) #To export ggplots

#setting the working directory
setwd("C:/lab/fcover/")

#import all data together with the lapply function
#first build a list explaining to the software what are the images that we want to import directly with the function list.files

#making a list with the list.files function 
#to use the list.files we chose the similar patter of our data
list.files(pattern= "c_gls_FCOVER")
#then we assign a name to our list
rlist <- list.files(pattern= "c_gls_FCOVER")
#to recall it just digit
rlist

#appliyng the lapply function 
list_rast <- lapply(rlist, raster)
list_rast #shows all the file which have been imported

#creating a stack to have all images together
stack(list_rast)
#assignin a name to it
fcoverstack <- stack(list_rast)
fcoverstack

#in R after checking fcoverstack we can notice that the names our our files are too long
#Fraction.of.green.Vegetation.Cover.1km.1, Fraction.of.green.Vegetation.Cover.1km.2, Fraction.of.green.Vegetatation.Cover.1km.3 

#we could rename them in this way
names(fcoverstack) <- c("FCOVER.1km.1", "FCOVER.1km.2", "FCOVER.1km.3")
#if we check fcoverstack now the names are these one less longer

#now we can separate the files and assign a name to the stack elements
fcover2018 <- fcoverstack$FCOVER.1km.2
fcover2019 <- fcoverstack$FCOVER.1km.3
fcover2020 <- fcoverstack$FCOVER.1km.1

#plotting the Fraction of Vegetation Cover (FCover) from 2018
#saving a viridis palette to use with raster files
viridis(3) 
viridis<-colorRampPalette(viridis(3))(100) 

plot(fcover2018, col=viridis, main="Global FCOVER 2018")

#we can save and export our file with PNG and dev.off
#dev.off is used to close the procedure of exporting the image

png("fcover2018.png", width = 2500, height = 2500, res = 300) 
plot(fcover2018, col=viridis, main="Global FCOVER 2018")
dev.off()

#we can try and plot the three images with ggplot

p2018 <- ggplot() + geom_raster(fcover2018, mapping = aes(x=x, y=y, fill= FCOVER.1km.2)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover 2018")
#i want to export this
#install package to export ggplots
#install.packages("ggpubr")
#library(ggpubr)

#exporting
ggexport(p2018, filename= "fcover2018_ggplot.png", width = 2500, height = 1000, res = 300)

#Fcover 2019 with ggplot
p2019 <- ggplot() + geom_raster(fcover2019, mapping = aes(x=x, y=y, fill= FCOVER.1km.3)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover 2019")
#exporting
ggexport(p2019, filename= "fcover2019_ggplot.png", width = 2500, height = 1000, res = 300)

#Fcover 2020 with ggplot
p2020 <- ggplot() + geom_raster(fcover2020, mapping = aes(x=x, y=y, fill= FCOVER.1km.1)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover 2020")
#the p is lower 
#R is case sensitive
#exporting
ggexport(p2020, filename= "fcover2020_ggplot.png", width = 2500, height = 1000, res = 300)


#to see them all together to make a quick comparison we can use the patchwork library
#i want to see them piled up vertically
p2018/p2019/p2020
fcover_comparison <- p2018/p2019/p2020

#exporting
ggexport(fcover_comparison, filename= "fcovercomparison.png", width = 2500, height = 2500, res = 300)

#now i want to make a close up to the Brasil area
#with the crop function is possible to search for the data in a specific region
#to do so i have to put the coordinates for longitude and latidute
#Brazil is located at latitude from -80 to -35
#and longitude from -30 to 10
#i store them assigning a name
ext <- c(-80, -35, -30, 10)

#then i cropped the area of Brasil from 2018 and 2020
crop2018 <- crop(fcover2018, ext)
crop2020 <- crop(fcover2020, ext)

#plotting again with ggplot 

c2018<- ggplot() + geom_raster(crop2018, mapping = aes(x=x, y=y, fill= FCOVER.1km.2)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover Brasil 2018")
#exporting 
ggexport(c2018, filename= "fcoverbrasil2018ggplot.png", width = 2500, height = 2000, res = 300)

c2020 <- ggplot() + geom_raster(crop2020, mapping = aes(x=x, y=y, fill= FCOVER.1km.1)) + scale_fill_viridis(option="viridis") + ggtitle ("Fcover Brasil 2020")
c2020
#exporting
ggexport(c2020, filename= "fcoverbrasil2020ggplot.png", width = 2500, height = 2000, res = 300)


fcover_brasil_comparison<-c2018/c2020
#changes in the spatial extent of vegetation in two years

#export this
ggexport(fcover_brasil_comparison, filename= "fcoverbrasilcomparison.png", width = 2500, height = 2500, res = 300)

#i can try to use the cividis palette
#cividis palette is a colorblind-friendly color map
p1<- ggplot() + geom_raster(crop2018, mapping = aes(x=x, y=y, fill= FCOVER.1km.2)) + scale_fill_viridis(option="cividis") + ggtitle ("Fcover Brasil 2018")
p1
#exporting
ggexport(p1, filename= "fcover2018cividis.png", width = 2500, height = 2000, res = 300)


#plotting the image from 2020
p2 <- ggplot() + geom_raster(crop2020, mapping = aes(x=x, y=y, fill= FCOVER.1km.1)) + scale_fill_viridis(option="cividis") + ggtitle ("Fcover Brasil 2020")
p2
#exporting
ggexport(p1, filename= "fcover2020cividis.png", width = 2500, height = 2000, res = 300)


#see them together
p1/p2
pcividis <-p1/p2
#exporting
ggexport(pcividis, filename= "fcover_comparison_cividis.png", width = 2000, height = 2500, res = 300)



#The area of Parà was one of the most impacted by deforestation in 2019
#let's try and crop the map on that area
extp <- c(-60, -45, -15, 5)
para2018 <- crop(fcover2018, extp)
para2019 <- crop(fcover2019, extp)
para2020 <- crop(fcover2020, extp)

par(mfrow=c(2,2)) #when i put 2,1 the images don't appear all together, 2018 and 19 one in top of the other, 2020 in a new page
plot(para2018, col=viridis, main="Parà 2018")
plot(para2019, col=viridis, main="Parà 2019")
plot(para2020, col=viridis, main="Parà 2020")

#let's export them
png("para.png", width = 2500, height = 2500, res = 300)
par(mfrow=c(2,2))
plot(para2018, col=viridis, main="Parà 2018")
plot(para2019, col=viridis, main="Parà 2019")
plot(para2020, col=viridis, main="Parà 2020")
dev.off()


#i want to see what happened during the 2019 Amazon rainforest wildfires season
#the wildfires season went from January to October 2019
#data on https://land.copernicus.vgt.vito.be/PDF/portal/Application.html#Home
#collection on Fire disturbance not available for that period
#monitoring the situation in January, August and October

#study NDVI
#The normalized difference vegetation index (NDVI) is a graphical indicator that can be used to analyze remote sensing measurement 
#assessing whether or not the target being observed contains live green vegetation
#so NDVI can be used to estimate if vegetation is alive

#let's investigate the situation:
#before the wildfire season
#during the wildfire season
#after the wildfire season

#NDVI before should be > NDVIafter
#setting the working directory since i wanted to make a different folder
setwd("C:/lab/ndvi/")

#NDVI before the 2019 Amazon rainforest wildfires season
#november 2018
ndvibefore <- raster("c_gls_NDVI_201811110000_GLOBE_PROBAV_V2.2.1.nc")

#NDVI during
#august 2019
ndviduring <- raster("c_gls_NDVI_201908210000_GLOBE_PROBAV_V2.2.1.nc")

#NDVI after
#november 2019
ndviafter <- raster("c_gls_NDVI_201911210000_GLOBE_PROBAV_V2.2.1.nc")

#since our focus is on Brasil, let's crop the data using the coordinates we used before
ext <- c(-80, -35, -30, 10)
cropbefore <- crop(ndvibefore, ext)
cropduring <- crop(ndviduring, ext)
cropafter <- crop(ndviafter, ext)
#Normalized Difference Vegetation Index (NDVI) quantifies vegetation by measuring the difference 
#between near-infrared (which vegetation strongly reflects) and red light (which vegetation absorbs).
#NDVI always ranges from -1 to +1
#NDVI values close to zero represent bare soil, thus I used grey-beige colors, 
#NDVI close to 1 represents living vegetation, thus, I used green colors. 
#let's build a colorRampPalette
cl <- colorRampPalette(c("honeydew", "darkolivegreen3","palegreen4"))(100)

#plotting ndvi before
plot(cropbefore, col=cl, main="NDVI before wildfire season, November 2018")
#exporting 
png("ndvibefore.png", width = 2500, height = 2500, res = 300)
plot(cropbefore, col=cl, main="NDVI before wildfire season, November 2018")
dev.off()

#plotting ndvi during
plot(cropduring, col=cl, main="NDVI during wildfire season, August 2019")
#exporting 
png("ndviduring.png", width = 2500, height = 2500, res = 300)
plot(cropduring, col=cl, main="NDVI during wildfire season, August 2019")
dev.off()

#plotting NDVI after
plot(cropafter, col=cl, main="NDVI after wildfire season, November 2019")
#exporting 
png("ndviafter.png", width = 2500, height = 2500, res = 300)
plot(cropafter, col=cl, main="NDVI after wildfire season, November 2019")
dev.off()

#differences
diffndvi<- cropbefore-cropafter
plot(diffndvi, col=cl, main="NDVI difference")
#exporting
png("ndvidifference.png", width = 2500, height = 2500, res = 300)
plot(diffndvi, col=cl, main="NDVI difference")
dev.off()

#comparison
par(mfrow=c(2,2))
plot(cropbefore, col=cl, main="NDVI before wildfire season, November 2018")
plot(cropduring, col=cl, main="NDVI during wildfire season, August 2019")
plot(cropafter, col=cl, main="NDVI after wildfire season, November 2019")
plot(diffndvi, col=cl, main="NDVI difference")

#exporting
png("ndvicomparison.png", width = 3500, height = 2500, res = 300)
par(mfrow=c(2,2))
plot(cropbefore, col=cl, main="NDVI before wildfire season, November 2018")
plot(cropduring, col=cl, main="NDVI during wildfire season, August 2019")
plot(cropafter, col=cl, main="NDVI after wildfire season, November 2019")
plot(diffndvi, col=cl, main="NDVI difference")
dev.off()

#####################################################################################################################################################################










