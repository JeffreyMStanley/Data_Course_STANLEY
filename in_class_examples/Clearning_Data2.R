df = read.csv("Exercises/ugly_data2.csv", stringsAsFactors = FALSE)
library(tidyverse)

df1 = df[1:9,]
df2 = df[20:28,]
df1$Gender = "Male"
df2$Gender = "Female"

df = full_join(df1,df2)

long = gather(df,AgeGroup,Value,2:5)
long$AgeGroup = str_remove(long$AgeGroup, "^m")
long$AgeGroup = str_replace(long$AgeGroup, "014", "0014")

ages1 = substr(long$AgeGroup,start = 1, stop = 2)
ages2 = substr(long$AgeGroup,start = 3, stop = 4)
ages = paste0(ages1, "-", ages2)
long$AgeGroup = ages


# when the tables are next to each other
df_m = df %>% 
  select(c(1:5))

df_f = df %>%
  select(c(10:14))

df_m = df_m %>%
  gather(Group, Value, c(2:5))

df_f = df_f %>%
  gather(Group, Value, c(2:5))

df_long = full_join(df_m , df_f)

df_long$Year.1 = NULL