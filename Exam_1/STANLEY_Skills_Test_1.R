list.files()
df=read.delim("DNA_Conc_by_Extraction_Date.csv")


df
summary(df)
#I
class(df)
class(df$DNA_Concentration_Katy)
class(df$DNA_Concentration_Ben)

hist(df$DNA_Concentration_Katy, main = "DNA Con katy", xlab = "Concentration", ylab = "frequency")

hist(df$DNA_Concentration_Ben, main = "DNA Con Ben", xlab = "Concentration", ylab = "frequency")


#II and III
class(df$Year_Collected)
df$Year_Collected=as.factor(df$Year_Collected)

jpeg("STANLEY_Plot1.jpeg", width = 480, height = 480)
plot(x=df$Year_Collected, y=df$DNA_Concentration_Katy, main = "Katy's Extractions",
     ylab = "DNA Concentration", xlab = "YEAR")

dev.off()

jpeg("STANLEY_Plot2.jpeg", width = 480, height = 480)

plot(x=df$Year_Collected, y=df$DNA_Concentration_Ben, main = "Ben's Extractions",
     ylab = "DNA Concentration", xlab = "YEAR")

dev.off()

#IV I faild this part I cant do it I suck
?mean()
df$Year_Collected


difference = c()
x=1
for(year in levels(df$Year_Collected)){
  ben = (mean(df[df$Year_Collected == year,"DNA_Concentration_Ben"]))
  katy = (mean(df[df$Year_Collected == year,"DNA_Concentration_Katy"]))
  difference[x] = (ben-katy)
x=x+1
  }

minyear = which(difference == min(difference))
levels(df$Year_Collected)[minyear]


#nice way to do it
library(tidyverse)
df2 = df %>%
  group_by(Year_Collected) %>%
  summarise(Mean_ben = mean(DNA_Concentration_Ben), Mean_katy = mean(DNA_Concentration_Katy))
df2$Mean_ben-df2$Mean_katy

#junk that did not work
col1 = df$Year_Collected == 2000
col2 = (df$DNA_Concentration_Katy) 
cbind(col1, col2)
df2=which(df$Year_Collected == "2000")
data.frame(df$Year_Collected == 2000, df$DNA_Concentration_Katy)
plot(x=df2, y=df$DNA_Concentration_Katy)
  
col2000= c(df$Year_Collected == 2000)
hist(df$Year_Collected == 2000)

plot(x=df$DNA_Concentration_Katy, y=df$DNA_Concentration_Ben, col=df$Year_Collected)
library(ggplot2)

# V
df3=df[,c("Year_Collected", "DNA_Concentration_Ben")]
remove(df3)
#nice way to do V tidyverse %>% is a pipe 
df3=df%>%
  group_by(Year_Collected) %>%
  summarise(Mean_ben = mean(DNA_Concentration_Ben), SDBen = sd(DNA_Concentration_Ben))




