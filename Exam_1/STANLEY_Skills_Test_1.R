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

#IV
?mean()
df$Year_Collected

col1 = df$Year_Collected == 2000
col2 = (df$DNA_Concentration_Katy) 
cbind(col1, col2)
df2=which(df$Year_Collected == "2000")
data.frame(df$Year_Collected == 2000, df$DNA_Concentration_Katy)
plot(x=df2, y=df$DNA_Concentration_Katy)
  
col2000= c(df$Year_Collected == 2000)
hist(df$Year_Collected == 2000)
