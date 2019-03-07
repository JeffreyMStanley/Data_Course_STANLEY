df = read.csv("./Data/mushroom_growth.csv")

library(tidyverse)
library(modelr)
glimpse(df)


#not realy good because linear id did this
ggplot(df, aes(x=Nitrogen, y=GrowthRate)) +
  geom_point() +
  facet_grid(~Species)

df.mod.full = glm(GrowthRate ~ Light*Nitrogen*Temperature, data = df)
summary(df.mod.full)
mean(abs(residuals(df.mod.full)))  

df2 = add_predictions(df, df.mod.full, var = "pred")

df2 = mutate(df2, DIFF = abs(pred - GrowthRate))

ggplot(df2, aes(x=Nitrogen)) +
  geom_point(aes(y=GrowthRate)) +
  facet_grid(~Species) +
  geom_jitter(aes(y=pred, color="Red"))

# what we talked about we use quandratic 

# this sucks nls(formula = ((a*x^2) + (b*x) + c), data = df,  )
?nls

pred = predict(loess(GrowthRate ~ Nitrogen, data = df))

ggplot(df, aes(x=Nitrogen, y=GrowthRate)) +
  geom_point() +
  geom_smooth(se = FALSE) +
  geom_point(aes(y=pred), color = "Red", size = 4)


?predict()

nd = data.frame(Nitrogen = 15)

mod.loess = loess(GrowthRate ~ Nitrogen, data = df)
predict(mod.loess, newdata = nd)


