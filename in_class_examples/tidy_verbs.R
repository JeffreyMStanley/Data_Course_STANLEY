
# The tidy verbs
data(iris)
df=iris


#Give me average(mean) sepal length for each species of iris also (N, sd, min, and max)

library(tidyverse)

df2 = df %>%
  group_by(Species) %>%
  summarise(MeanSepalLenght = mean(Sepal.Length), 
            MaxSepalLenghth = max(Sepal.Length), 
            sdSepalLength = sd(Sepal.Length), N = n())  %>%
  as.data.frame("data.frame")
class(df2)

#find column that start with S
df %>%
  select(starts_with("S"))

df%>%
  select(one_of(c("Petal.Length", "Sepal.Roundness")))

df %>%

?mutate() # adds new variables that are functions of existing variables
?select() # picks variables based on their names.
?filter() # picks cases based on their values.
?summarise() # reduces multiple values down to a single summary.
?arrange() # changes the ordering of the rows.
?group_by() # allows you to perform any operation “by group”.

%>% # pipe!


