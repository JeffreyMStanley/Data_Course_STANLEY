library(modelr)
library(broom)
library(dplyr)
library(fitdistrplus)
library(tidyr)
library(tidyverse)

df = read.csv("mushroom_growth.csv")

ggplot(df, aes(x=Nitrogen, y=GrowthRate)) +
  geom_point()

ggplot(df, aes(x = Light, y= GrowthRate)) + 
  geom_point() 

ggplot(df, aes(x= Humidity, y= GrowthRate)) +
 geom_boxplot()

ggplot(df, aes(x = Temperature, y = GrowthRate)) +
  geom_boxplot()


mod1 = lm(data = df, GrowthRate ~ Nitrogen)
summary(mod1)
pred1 = predict(mod1)
mse(mod1, df)

mod1.2 = aov(data = df, GrowthRate ~ Nitrogen)
summary(mod1.2)
pred1.2 = predict(mod1.2)
mse(mod1.2, df)

mod2 = lm(data = df, GrowthRate ~ Nitrogen+Light)
summary(mod2)
pred2 = predict(mod2)
mse(mod2, df)

mod2.2 = aov(data = df, GrowthRate ~ Nitrogen+Light)
summary(mod2.2)
pred2.2 = predict(mod2.2)
mse(mod2.2, df)

df2 = df
df2$pred2 = pred2


ggplot(df2, aes(x=Nitrogen+Light)) + 
  geom_point(aes(y=GrowthRate)) +
  geom_jitter(aes(y=pred2, color = "Red"))

