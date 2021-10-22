# 1. Get data
dereks.data<-read.csv("Data/DereksData.csv", header = T)
summary(dereks.data)
str((dereks.data))
#summary(CC.data$Region)
#summary(CC.data$Location)
Sites<-as.data.frame(unique(dereks.data$SiteID))

# 2. Format variables
# Date/times

dereks.data <- transform(dereks.data,
                     datetime = as.POSIXct(paste(ESTDate, EST.Time),
                                           format = '%m/%d/%Y %I:%M:%S %p', tz = "EST"))


dereks.data$ESTDate<-as.Date(dereks.data$ESTDate, "%m/%d/%Y")
dereks.data$Year<-format(dereks.data$ESTDate, format ="%Y")
dereks.data$UTC<-format(dereks.data$datetime, tz="UTC",usetz=FALSE)

#dereks.data$ESTDate<-as.Date(dereks.data$ESTDate, "%m/%d/%Y")

dereks.data$Year<-as.numeric(dereks.data$Year)
dereks.data$Date<-as.Date(dereks.data$ESTDate, "%m/%d/%Y")


# Numerical data
dereks.data$Latitude <- gsub("N/A", "NA", dereks.data$Latitude)
dereks.data$Longitude <- gsub("N/A", "NA", dereks.data$Longitude)

#Latitude_NA<-which(is.na(CC.data$Latitude))
dereks.data$Latitude <-as.numeric((as.character(dereks.data$Latitude)))
#Latitude_NA2<-which(is.na(CC.data$Latitude))
#NewNAs<-setdiff(Latitude_NA2, Latitude_NA)
#Row189 is not being recognized-fixed, it had an space

#Longitude_NA<-which(is.na(CC.data$Longitude))
dereks.data$Longitude <-as.numeric((as.character(dereks.data$Longitude)))
#Longitude_NA2<-which(is.na(CC.data$Longitude))
#NewNAs<-setdiff(Longitude_NA2, Longitude_NA)


dereks.data$Temperature_C <-
  as.numeric((as.character(dereks.data$Temperature_C)))
Temperature_NA2<-which(is.na(dereks.data$Temperature_C))
# 4 temp values not available in the original data

dereks.data$TA <-as.numeric((as.character(dereks.data$TA)))
#Row 730 does not have TA, pH, pCO2 or Aragonite 

dereks.data$DIC <-as.numeric((as.character(dereks.data$DIC)))

dereks.data$pH <-as.numeric((as.character(dereks.data$pH)))
TA_NA<-which(is.na(dereks.data$pH))
# rows 31  32 663 664 730

dereks.data$pCO2 <-as.numeric((as.character(dereks.data$pCO2)))
dereks.data$Aragonite_Sat_W<-
  as.numeric((as.character(dereks.data$Aragonite_Sat_W)))

#Values set to -9 -> Changed to NAs
CC.data_Neg9<-subset(dereks.data,dereks.data$Aragonite_Sat_W==-9 |
                       dereks.data$pH==-9 |
                       dereks.data$pCO2==-9)

dereks.data[ dereks.data == -9 ] <- NA

```
