# This is my first code in GitHub

#Here are the imputs data
#Costanza data on streams
 water <-c(100, 200, 300, 400, 500)
 water
 
 #Marta data on fishing genomes
 fishes <- c(10, 50, 60, 100, 200)
 fishes
 
 #plot the diversity of fishes (y) versus the amount of water (x)
 plot(water, fishes)

#data we developed can be stored in a table
#table in R is called data frame

streams <-data.frame(water, fishes)
