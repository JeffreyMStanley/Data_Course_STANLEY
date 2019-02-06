list.files()

read.csv("landdata-states.csv")

df = read.csv("landdata-states.csv")
class(df)
head(df)


?read.csv()
#1. what other stuff does read.csv() do automatically?
#2. How is it different from read.csv2()?
#3 why does read.csv2() even exist?

class(df$State)
class(df$Date)
#4. How could I change the parameters of read.csv() to make it so the class of the "State" column is "characer" instead of "factor"?
df = read.csv("landdata-states.csv", as.is = c("State"))



dim(df)
str(df)
summary(df)
summary(df$Home.Value)

names(df)[5]

hist(df$Land.Value)
plot(x=df$region,y=df$Land.Value)
plot(x=df$Year,y=df$Land.Value)

plot(x=df$Year,y=df$Land.Value,col=df$region)

#rest of assignment

dat=read.delim("ITS_mapping.csv")


class(dat)
summary(dat)
dim(dat)
str(dat)

png("./silly_boxplot.png")
plot(x=dat$Ecosystem, y=dat$Lat)
dev.off()



list.files()
