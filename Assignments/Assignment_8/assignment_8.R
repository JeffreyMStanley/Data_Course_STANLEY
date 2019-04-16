library(modelr)
library(tidyverse)

# 1 = in grad school. 0 = not in grad school
df = read.csv("./GradSchool_Admissions.csv")
df
class(df$admit)
df$admit = as.character(df$admit)
ggplot(df, aes(x = admit, y=gpa)) +
  geom_boxplot()

mod = lm(admit ~ gpa, data = df)
summary(mod)

df2 = add_predictions(df, mod)
df2
?add_predictions()
mod2 = lm(admit ~ gpa+gre, data = df)
summary(mod2)

add_predictions(df, mod2)
?lm
?lm
?predict
https://www.masterdataanalysis.com/r/using-r-predict-customer-will-buy/