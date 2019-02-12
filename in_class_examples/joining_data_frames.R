library(tidyverse)

# here are two data frames
df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))

df1
df2

# join them together
full_join(df1,df2, by="CustomerId")
left_join(df1,df2, by="CustomerId")
right_join(df1,df2, by="CustomerId")
inner_join(df1,df2, by="CustomerId")
semi_join(df1,df2, by="CustomerId")
anti_join(df1,df2, by="CustomerId")

fully_anti_join = function(x,y,name){
  anti = anti_join(x,y, by = name)
  anti2 = anti_join(y,x, by = name)
  full_join(anti,anti2)
}

fully_anti_join(df1,df2, "CustomerId")

?gather()

list.files()
utah = read.csv("./Data/Utah_Religions_by_County.csv")

utah.long = gather(utah,key="Religion", value = "Proportion", -c(1:4))

ggplot(utah.long, aes(x=County, y=Proportion, color = Religion)) + 
  geom_boxplot() + coord_flip()


ggplot(utah.long, aes(x=County, y=Proportion, fill = Religion)) + 
  geom_boxplot() + facet_wrap(~County) + coord_flip()

utah.long %>% filter(Religion != "LDS") %>%
  ggplot(aes(x=Religion, y=Proportion, fill = Religion)) + 
  geom_boxplot() + facet_wrap(~County) + coord_flip()


utah.long$County
utah.long$County <- factor(str_remove(utah.long$County, " County"))
