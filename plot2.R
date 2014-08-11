ifelse(tolower(getwd())!="C:/Users/lambones/git/repos/ExData_Plotting1/",
       setwd("C:/Users/lambones/git/repos/ExData_Plotting1"), getwd())

## Download zip file from website.
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"dataset.zip")

## Unzip the file to /data directory, then delete unneeded files.
unzip("dataset.zip", junkpaths=TRUE, exdir="./data")
setwd("./data")

## Create file to hold subset of records based on date range.
file.remove('hpc.txt')
file.create('hpc.txt')

## Select header, and records with "date" of 2/1/2007 or 2/2/2007 and write to file.
first<-system("findstr /B Date household_power_consumption.txt",intern=TRUE)
second<-system('findstr /B "1/2/2007" household_power_consumption.txt', intern=TRUE)
third<-system('findstr /B "2/2/2007" household_power_consumption.txt', intern=TRUE)
con1<-file('hpc.txt',open='a')   # open connection to file 'hpc.txt' for appending
writeLines(first,con1)           # write header to file
writeLines(second,con1)          # write records with date of 2/1/2007
writeLines(third,con1)           # write reocrds with date of 2/2/2007
close(con1)                      # close file connection

## Read in subset file to dataframe.
df<-read.csv('hpc.txt',header=TRUE,sep=";")

setwd("..")

## Convert Time and Date character vectors to vectors with elements of POSIXlt(Time) and Date classes.
df$Time<-strptime(paste(df$Date,df$Time,sep=" "),format="%d/%m/%Y %H:%M:%S")
df$Date<-as.Date(df$Date,format="%d/%m/%Y")

png('plot2.png', res=72)
par(cex.axis=.8)
par(mar=c(5.1,4.1,4.1,2.1))
plot(df$Time,df$Global_active_power, type='n', ylab="Global Active Power (kilowatts)", xlab="")
lines(df$Time,df$Global_active_power)
dev.off()
