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

# Built multiple base plot for the Global Active Power, Voltage, Energy sub metering, 
# and Global Reactive Power per days.
par(mfrow = c(2,2), mar=c(4, 4, 2, 1), oma = c(0,0,2,0))
with(subdata, {
     plot(subdata$datetime, subdata$Global_active_power, ylab="Global Active Power", xlab=" ", type="l", cex.lab=.8)
     plot(subdata$datetime, subdata$Voltage, ylab="Voltage", xlab="datetime", type="l", cex.lab=.8)
     plot(subdata$datetime, subdata$Sub_metering_1, type="n", ylab="Energy sub metering", xlab=" ", cex.lab=.8, col="black")
        lines(subdata$datetime, subdata$Sub_metering_1, type="l", col="black")   
        lines(subdata$datetime, subdata$Sub_metering_2, type="l", col="red")
        lines(subdata$datetime, subdata$Sub_metering_3, type="l", col="blue")
        legend("topright", col = c("black", "red", "blue"), bty="n", cex=.5, lty=c(1,1,1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(subdata$datetime, subdata$Global_reactive_power, las = 2, ylab="Global_reactive_power", xlab="datetime", type="l", cex.lab=.8)   
})

# Save plot as PNG
dev.copy(png,"plot4.png",width=480,height=480,units="px")
dev.off()