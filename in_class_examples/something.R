df = read.csv("./Data/landdata-states.csv")
names(df)

plot(x=df$State, y=df$Home.Value)
levels(df$State)

plot(x=df$region, y=df$Home.Value,col=df$Date)

#Home Value over time

plot(x=df$Year, y=df$Home.Value,col=df$region)

plot(x=df$Year, y=df$Land.Value,col=df$region)

plot(x=df$Land.Value, y=df$Home.Value,col=df$region)

list(df$region)

lm(df$Home.Value ~ df$Land.Value) #Land.value Influences home.vlaue

mod1 = lm(df$Home.Value ~ df$Land.Value)
summary(mod1)

abline(mod1)


sum(mod1$residuals^2)

plot(x=df$Year, y=df$Home.Value)

mod2 = lm(df$Home.Value ~ df$Year)
summary(mod2)
abline(mod2, col = "red")

mod3 = aov(df$Home.Value ~ df$Year + df$region) 
summary(mod3)

mod4 = aov(df$Home.Value ~ df$Year * df$region)
summary(mod4)


mod5 = aov(df$Home.Value ~ df$Year * df$region * df$State * df$Qrtr)
summary(mod5)

mod6 = aov(df$Home.Value ~ df$Year * df$region * df$State + df$Qrtr)
summary(mod6)

anova(mod5,mod6)

rm(mod1,mod2,mod3,mod4,mod5,mod6)
sum(mod5$residuals^2)
sum(mod6$residuals^2)






df2 = read.delim("./Data/US_Biome_Diversity.tsv")
name(df2)
names(df2)
list(df2$State)

plot(x=df2$State, y=df2$Biome)
plot(x=df2$Biome, y=df2$Diversity)
plot(x=df2$State, y=df2$Diversity, col = df2$Biome)

legend(



