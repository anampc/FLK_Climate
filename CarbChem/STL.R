#STL 
#22042021
#Alice Webb
library("plyr")
library("ggplot2")
library("pastecs")
library(zoo)
library(readr)
library(reshape2)


#load data
dm <- WS.data

#restore date format
dm$ESTDate <- as.Date(dm$ESTDate, "%d/%m/%Y")
dm<-dm[order(as.Date(dm$ESTDate, format="%d/%m/%Y")),]

#melt
dm<-melt(dm, id.vars=c(1:12,18:20,22:26))

#mean per date and variable
dm<-ddply(dm,.(ESTDate, variable),summarize,mean=mean(value,na.rm = TRUE))

#plot to check
ggplot(dm, aes(x=ESTDate,y=mean))+
  geom_line(size=0.2)+
  facet_wrap(~variable, scales="free")+
  theme(legend.position = "none")+
  theme_minimal()+
  xlab("date")+
  ylab("variable")
# geom_vline(xintercept = as.numeric(as.Date("2019-07-10")), 
            # color = "red") 

#reorder
dm<-dm[order(as.Date(dm$ESTDate, format="%d/%m/%Y")),]

colnames(dm)<- c("Date","variable","value")
#reformat date again...
dm$Date<- as.Date(dm$Date, "%d/%m/%Y")
dm$variable<-as.character(dm$variable)

# prepare the ts() coordinate
# count how many samples are in each year
dm$year <- format(dm$Date, "%Y")
(obsCount <- count(dm[dm$variable=="TA",], vars=c("year"))) ##for TA
#year freq
# 2012   21
# 2013   19
# 2014   19
# 2015   21
# 2016   36
# 2017   33
# 2018   36
# 2019   25

# starting week
dm$week <- format(dm$Date, "%w")
head(dm)
# -> 3rd week

# actual dates
(start <- min(dm$Date))  # "2012-03-23"
(stop <- max(dm$Date))   # "2019-12-24"
stop - start            # Time difference of 2832 days days

# compute start and freq parameters to start from the correct day, stop on the correct day and distribute the other records in the years as above
#2012-01-01 = 2012.000 in ts
#        . deltat = 1 / f
#        . there are n = 210 records (n-1 = 209 steps, of 7 days each)
(n <- nrow(dm[dm$variable=="pH",]))

f <- 27 #(averaged freq)
start <- 3 #3rd week
deltat <- 1/f
xT <- ts(1:n, start=c(2012, start), end=c(2019,12),freq=f)
# nb of records per year
obsCount$tsfreq <- count(as.integer(time(xT)))$freq
obsCount
# start and stop dates
timeSteps <- (time(xT)-2012) / (1/f) *14.2
range(as.Date("2012-03-23") + as.numeric(timeSteps))
# -> seems OK, although I am not too sure why...


# test on TA
xT <- dm[dm$variable == "TA",]
xT<-xT[,3]
date<- dm[dm$variable == "TA",]
date<-date[,1]
xT <- ts(xT, start=c(2012, start), frequency=f)
plot(xT)
# look the the seasonal component over 3 months and the trend over 4 years (play around with these ;)
xTstl <- stl(xT, s.window=13, t.window=30*3, robust=T, s.jump=1, t.jump=4, l.jump=1)
acf(xTstl$time.series[,"remainder"], lag.max=30*2)
plot(xTstl)
dTstl <- data.frame(date=date, data=xT, data.frame(xTstl$time.series))
dTstlm <- melt(dTstl, id.vars="date")
lastRecord <- dTstlm[dTstlm$date == max(dTstlm$date),]
pSTL <- ggplot(dTstlm) +
  # series
  geom_path(aes(x=date, y=value, colour=variable)) + 
  facet_grid(variable~., scale="free_y") +
  scale_colour_manual(guide="none", values=c("black", "#286a9a", "red", "Gray")) +
  # scale bar
  geom_segment(aes(x=date, xend=date, y=value, yend=value-0.5), data=lastRecord, size=4, alpha=0.5) +
  geom_text(aes(x=date, y=value-0.25), data=lastRecord, label="end", size=3, alpha=0.5, hjust=-0.22)
