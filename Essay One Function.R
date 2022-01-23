#cluster Automator Function

cluster_automator <- function(x, longcol, latcol, proj=27700, weightcol = 0, eps = 250, MinPts = 4,knn = FALSE, main = "DBSCAN Output", xlab = "Eastings", ylab = "Northings"){
  library(sp)
  x <- x[complete.cases(x[, longcol:latcol]), ]
  spdf<- SpatialPointsDataFrame(x[,longcol:latcol], x, proj4string = CRS("+init=epsg:4326"))
  
  b<-spTransform(spdf, CRS(paste0("+init=epsg:",proj)))
  if(knn== FALSE){
    if(weightcol == 0){
      m <- data.frame(b@coords[,longcol:latcol])
      library(dbscan)
      db <<- dbscan(m[,1:2], eps = eps, MinPts = MinPts)
      plot(m[,1:2], col=factor(db$cluster), main = main, frame = F, asp=T, xlab = xlab, ylab = ylab)
    } else {
      m <- data.frame(b@coords[,longcol:latcol], x[,weightcol])
      library(dbscan)
      db <<- dbscan(m[,1:2], weights = m[,3], eps = eps, MinPts = MinPts)
      plot(m[,1:2], col=factor(db$cluster), main = main, frame = F, asp=T, xlab = xlab, ylab = ylab)
    }
  } else if(knn == TRUE){
    m <- data.frame(b@coords[,longcol:latcol])
    kNNdistplot(m, k = MinPts+1)
  }
}

#Test 1
#Kensington Crime Data
setwd("~/Desktop/Y2 Data Analysis/Datasets/Met Pol. Crime Data")
police_data<- read.csv("2019-12-metropolitan-street.csv")
police_data<- police_data[grepl('Kensington', police_data$LSOA.name),]
crime_count_raw<- aggregate(police_data$Crime.ID, by=list(police_data$Longitude, police_data$Latitude,police_data$LSOA.code,police_data$Crime.type), FUN=length)
crime_count_asb<- crime_count_raw[which(crime_count_raw[,4]=="Anti-social behaviour"),]

#Tests - Anti-Social Behaviour
cluster_automator(crime_count_asb, longcol=1, latcol=2)
cluster_automator(crime_count_asb, longcol=1, latcol=2, knn = TRUE)
cluster_automator(crime_count_asb, longcol=1, latcol=2, eps = 150, MinPts = 3)
cluster_automator(crime_count_asb, longcol=1, latcol=2, weightcol = 5)
cluster_automator(crime_count_asb, longcol=1, latcol=2, weightcol = 5, eps = 150, MinPts = 2)


#Test 2 
#Kensington Crime Data
setwd("~/Desktop/Y2 Data Analysis/Datasets/Met Pol. Crime Data")
police_data<- read.csv("2019-12-metropolitan-street.csv")
police_data<- police_data[grepl('Kensington', police_data$LSOA.name),]
crime_count_raw<- aggregate(police_data$Crime.ID, by=list(police_data$Longitude, police_data$Latitude,police_data$LSOA.code,police_data$Crime.type), FUN=length)
crime_count_burg<- crime_count_raw[which(crime_count_raw[,4]=="Burglary"),]

#Tests - Burglary
cluster_automator(crime_count_burg, longcol=1, latcol=2, weightcol = 5)
cluster_automator(crime_count_burg, longcol=1, latcol=2, knn = TRUE)
cluster_automator(crime_count_burg, longcol=1, latcol=2, eps = 200)



##Test 3 
#Camden Crime Data
setwd("~/Desktop/Y2 Data Analysis/Datasets/Met Pol. Crime Data")
police_data1<- read.csv("2020-07-metropolitan-street.csv")
police_data1<- police_data1[grepl('Camden', police_data1$LSOA.name),]
crime_count_raw1<- aggregate(police_data1$Crime.ID, by=list(police_data1$Longitude, police_data1$Latitude,police_data1$LSOA.code,police_data1$Crime.type), FUN=length)
crime_count_violence<-crime_count_raw1[which(crime_count_raw1[,4]=="Violence and sexual offences"),]

#Tests - Burglary
cluster_automator(crime_count_violence, longcol=1, latcol=2, weightcol = 5)
cluster_automator(crime_count_violence, longcol=1, latcol=2, knn = TRUE)
cluster_automator(crime_count_violence, longcol=1, latcol=2, eps = 200)







#Test 3
#Car Accident Data - 2018 
#https://data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data/datafile/36f1658e-b709-47e7-9f56-cca7aefeb8fe/preview

setwd("~/Desktop/Y2 Data Analysis/Datasets")
car_accidents<- read.csv("worksheet_data/dftRoadSafetyData_Accidents_2018.csv")
car_accidents<- car_accidents[grepl(1, car_accidents$Local_Authority_.District.),]
cluster_automator(car_accidents, longcol=4, latcol=5, weightcol = 9)



#Test 4 
#bovine TB data in Cornwall - https://www.maths.lancs.ac.uk/~rowlings/Teaching/Sheffield2013/ppexample.html
tb_data <- read.table("worksheet_data/Data/BTB_spoligotype_data_jittered.txt", head = TRUE)
cluster_automator(tb_data, longcol=1, latcol=2)


#test 5 
#A&E location data UK
ae_data <- read.csv("worksheet_data/UK A&E Provider Locations by LongLat - NHS Region - LSOA - UK Ward- 2019-08-09.csv")
cluster_automator(tb_data, longcol=5, latcol=4)
