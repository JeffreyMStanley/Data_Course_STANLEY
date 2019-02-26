#1 loads the mtcars data set
data("mtcars")
str(mtcars)
df=mtcars

?mtcars
?str
library(tidyverse)
#2 subsets the mtcars dataframe to include only automatic transmissions 
df2 = df %>%
  group_by(am) %>%
  filter(am ==0)

df2$am = NULL #I wanted to get rid of the column am because it is ot needed    

#3 saves this new subset as a new ﬁle called “automatic_mtcars.csv” in your Assignment_5 directory 
write.csv(df2, "automatic_mtcars.csv")

#4  plots the eﬀect of horsepower on miles-per-gallon (update plot to have meaningful labels and title) 
#5  saves this plot as a png image called “mpg_vs_hp_auto.png” in your Assignment_5 directory
png("mpg_vs_hp_auto.png")

ggplot(df2, aes(x=hp, y=mpg)) +
  geom_point() +
  geom_smooth() +
  xlab("horse_power") +
  ggtitle("mph v.s. horse power")

dev.off()  

#6 plots the eﬀect of weight on miles-per-gallon (with improved labels, again) 
#7 saves this second plot as a tiﬀ image called “mpg_vs_wt_auto.tiﬀ” in your Assignment_5 directory 
tiff("mpg_vs_wt_auto.tiff")

ggplot(df2, aes(x=wt, y=mpg)) +
  geom_point() +
  labs(title = "mph vs weight", x="Weight (1ooo lbs)")
dev.off()  

#8 subsets the original mtcars dataframe to include only cars with displacements less than or equal to 200 cu.in. 

df3 = df %>%
  filter(disp <= 200)

#9 saves that new subset as a csv ﬁle called mtcars_max200_displ.csv 
write.csv(df3, "mtcars_max200.csv")


#10 calulate max horse power for each dataframe 

maxdf = max(df$hp)
maxdf2 = max(df2$hp)
maxdf3 = max(df3$hp)

max_hp = cbind(maxdf,maxdf2,maxdf3)
max_hp

#11 prints these calculations (from task 10) in a readable format to a new plaintext ﬁle called hp_maximums.txt

write.table(max_hp, "hp_maximums.txt")
