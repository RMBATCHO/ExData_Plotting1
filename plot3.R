#Unzip file and upload the data.
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), header = TRUE, sep=";", na.strings="?")
unlink(temp)

# Subset the data from the dates 2007-02-01 and 2007-02-02.
subdata <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

# Convert the Date and Time variables to Date/Time classes.
subdata$datetime <- paste(subdata$Date, subdata$Time)
subdata$datetime <- strptime(subdata$datetime, "%d/%m/%Y %H:%M:%S")

# Plot the Global Active Power per days clustered by sub_metering.
par(mar=c(4, 4, 2, 1))
with(subdata, plot(subdata$datetime, subdata$Sub_metering_1, type="n", ylab="Energy sub metering", xlab=" ", cex.lab=.8, col="black"))
        lines(subdata$datetime, subdata$Sub_metering_1, type="l", col="black")   
        lines(subdata$datetime, subdata$Sub_metering_2, type="l", col="red")
        lines(subdata$datetime, subdata$Sub_metering_3, type="l", col="blue")
        legend("topright", col = c("black", "red", "blue"), lty=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Save plot as PNG
dev.copy(png,"plot3.png",width=480,height=480,units="px")
dev.off()