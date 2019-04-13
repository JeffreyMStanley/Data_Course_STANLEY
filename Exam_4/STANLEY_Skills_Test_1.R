library(tidyverse)

df=read.delim("DNA_Conc_by_Extraction_Date.csv")

#I
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


#IV the year is 2000
df2 = df %>%
  group_by(Year_Collected) %>%
  summarise(Mean_ben = mean(DNA_Concentration_Ben), Mean_katy = mean(DNA_Concentration_Katy), 
            dif = Mean_ben-Mean_katy) 

df2[which.min(df2$dif),]
#V 
df3 = df%>%
  group_by(Year_Collected) %>%
  summarise(Ben_Average_Conc = mean(DNA_Concentration_Ben))

names(df3)[names(df3) == 'Year_Collected'] <- 'YEAR'

df3[which.max(df3$Ben_Average_Conc),]
write.csv(df3,"./Ben_average_by_year.csv")
