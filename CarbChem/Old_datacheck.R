old_data<-read.csv("Data/WS 2010-2016.csv")

#2. Format variables
# Date/times
old_data$Date<-as.Date(old_data$ESTDate, "%m/%d/%y")

old_data$Temperature_C <-
  as.numeric((as.character(old_data$Temperature_C)))
Temperature_NA2<-which(is.na(old_data$Temperature_C))
# 4 temp values not available in the original data

old_data$TA <-as.numeric((as.character(old_data$TA)))
#Row 730 does not have TA, pH, pCO2 or Aragonite 

old_data$DIC <-as.numeric((as.character(old_data$DIC)))

old_data$pH <-as.numeric((as.character(old_data$pH)))
old_data$Salinity <-as.numeric((as.character(old_data$Salinity)))
TA_NA<-which(is.na(old_data$pH))
# rows 31  32 663 664 730

old_data$pCO2 <-as.numeric((as.character(old_data$pCO2)))
old_data$Aragonite_Sat_W<-
  as.numeric((as.character(old_data$Aragonite_Sat_W)))

old_data$Dataset<-"old"

summary(old_data)
summary(old_data)
summary(CC.data)

New_data<-filter(CC.data, Mission=="WaltonSmith")
New_data<-select(New_data, ESTDate, EST.Time, SiteID,Temperature_C, BestSalinity, TA, 
                 DIC, Aragonite_Sat_W, pCO2, pH, Date)

names(New_data) <- c("ESTDate", "EST.Time", "SiteID","Temperature_C", "Salinity", "TA", 
                     "DIC", "Aragonite_Sat_W", "pCO2", "pH", "Date")

New_data$Dataset<-"New"

All.data<-rbind(old_data,New_data )


### Sites

Aragonite<- ggplot(All.data) + theme_bw() +
  
  scale_y_continuous(limits = c(0,5.5),
                     name=("Aragonite Saturation") ,
                     breaks = seq(0, 5, 1),  
                     expand = c(0, 0)) +
  scale_x_date(name="Date",
               #labels = date_format("%M/%Y"),
               #limits = c(-1,114),
               expand = c(0, 0),
               breaks ="6 months")+
  
  scale_shape_manual(values=c(21,24))+
  #scale_colour_manual(values = c("gray35","gray70", "gray70"))+
  
  geom_point(aes (Date, Aragonite_Sat_W, fill=SiteID, shape=Dataset))+    
  #geom_point(aes (Date, Aragonite_Sat_W, fill=Sample_Depth_m), shape=21)+
  #geom_line(aes (Date, Aragonite_Sat_W, fill=SiteID), alpha=0.3)+
  
  theme(legend.position="none",
        plot.background=element_blank(),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        legend.box.background = element_rect(),
        panel.background =element_rect(fill = NA, color = "black")
  ) +
  geom_abline(slope = 0, intercept = 400,
              color="gray", linetype=2)

Aragonite
#ggsave(file="Outputs/Aragonite.svg", plot=Aragonite, dpi = 300, width=6, height=4)


## Salinity overview
Sal<- ggplot(All.data) + theme_bw() +
  
  scale_y_continuous(#limits = c(0,5.5),
                     name=("Sal") ,
                     #breaks = seq(0, 5, 1),  
                     expand = c(0, 0)) +
  scale_x_date(name="Date",
               #labels = date_format("%M/%Y"),
               #limits = c(-1,114),
               expand = c(0, 0),
               breaks ="6 months")+
  scale_shape_manual(values=c(21,24))+
  geom_point(aes (Date, Salinity, fill=SiteID, shape=Dataset))+    
  theme(legend.position="none",
        plot.background=element_blank(),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        legend.box.background = element_rect(),
        panel.background =element_rect(fill = NA, color = "black")
  ) +
  geom_abline(slope = 0, intercept = 400,
              color="gray", linetype=2)
Sal

## TA overview
TA<- ggplot(All.data) + theme_bw() +
  
  scale_y_continuous(limits = c(2000,2700),
    name=("Sal") ,
    #breaks = seq(0, 5, 1),  
    expand = c(0, 0)) +
  scale_x_date(name="Date",
               #labels = date_format("%M/%Y"),
               #limits = c(-1,114),
               expand = c(0, 0),
               breaks ="6 months")+
  
  scale_shape_manual(values=c(21,24))+
<<<<<<< HEAD
  geom_point(aes (Date, TA, fill=SiteID, shape=Dataset), alpha=0.5)+    
=======
  geom_point(aes (Date, TA, fill=SiteID, shape=Dataset))+    
>>>>>>> a779b2ccbad80c404841b4b9d922b9c862bdaaf5
  
  theme(legend.position="none",
        plot.background=element_blank(),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        legend.box.background = element_rect(),
        panel.background =element_rect(fill = NA, color = "black")
  ) +
  geom_abline(slope = 0, intercept = 400,
              color="gray", linetype=2)
TA


## DIC overview
DIC<- ggplot(All.data) + theme_bw() +
  
  scale_y_continuous(limits = c(2000,2100),
                     name=("Sal") ,
                     #breaks = seq(0, 5, 1),  
                     expand = c(0, 0)) +
  scale_x_date(name="Date",
               #labels = date_format("%M/%Y"),
               #limits = c(-1,114),
               expand = c(0, 0),
               breaks ="6 months")+
  
  scale_shape_manual(values=c(21,24))+
<<<<<<< HEAD
  geom_point(aes (Date, DIC, fill=SiteID, shape=Dataset), alpha=0.5)+    
=======
  geom_point(aes (Date, DIC, fill=SiteID, shape=Dataset))+    
>>>>>>> a779b2ccbad80c404841b4b9d922b9c862bdaaf5
  
  theme(legend.position="none",
        plot.background=element_blank(),
        axis.text.x = element_text(angle = 90, vjust = 0.5),
        panel.grid.major.y = element_blank(),
        panel.grid.major.x = element_blank(),
        panel.grid.minor.x = element_blank(),
        panel.grid.minor.y = element_blank(),
        legend.box.background = element_rect(),
        panel.background =element_rect(fill = NA, color = "black")
  ) +
  geom_abline(slope = 0, intercept = 400,
              color="gray", linetype=2)
DIC

