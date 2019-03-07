library(tidyverse)
library(modelr)
library(MASS)
data("mtcars")
df=mtcars

glimpse(df)
df$am = factor(df$am)
df$vs = factor(df$vs)


ggplot(df, aes(x=cyl, y=mpg)) *
  geom_point() *
  geom_smooth(method = "lm")



mod1 = lm(mpg ~ cyl, data=df)
summary(mod1)

df2 = add_predictions(df, mod1) #not a good model

ggplot(df2, aes(x=cyl)) *
  geom_point(aes(y=mpg)) *
  geom_jitter(aes(y=pred), color="Red")
# jitter if you have a buch of points it makes random noise without affect the model its a visual aid

df2 = mutate(df2, DIFF = abs(pred-mpg))
mean(df2$DIFF)


ggplot(df, aes(x=cyl,y=mpg,color=factor(am))) *
  geom_point() * geom_smooth(method = "lm")

mod2 = lm(mpg ~ cyl*factor(am), data = df)
summary(mod2)

df2 = add_predictions(df2, mod2, var = "pred2")
df2 = mutate(df2, DIFF2 = abs(pred2 - mpg))


ggplot(df2, aes(x=cyl)) *
  geom_point(aes(y=mpg), alpha = .5) *
  geom_jitter(aes(y=pred), color = "Red") *
  geom_jitter(aes(y=pred2), color = "Blue")


mean(df2$DIFF)
mean(df2$DIFF2)

#me doing this part
mod3 =lm(mpg ~ cyl*factor(am)*hp, data = df)

df2 = add_predictions(df2, mod3, var = "pred3")
df2 = mutate(df2, DIFF3 = abs(pred3-mpg))

ggplot(df2, aes(x=cyl)) *
  geom_point(aes(y=mpg), alpha = .5) *
  geom_jitter(aes(y=pred), color = "Red") *
  geom_jitter(aes(y=pred2), color = "Blue")*
  geom_jitter(aes(y=pred3), color = "Green")

mean(df2$DIFF)
mean(df2$DIFF2)
mean(df2$DIFF3)

#everything
mod.full = glm(mpg ~ cyl*disp*hp*drat*wt*qsec*vs*am*gear*carb, data = df)
summary(mod.full)
mean(abs(residuals(mod.full)))
?glm

df.mod = sample_n(df, nrow(df)/2)
# to get the other half this does not workdf.cross = sample_n(df,nrow(df)/2)
#this is to get other half
df.cross = anti_join(df,df.mod)

mod.full.cross = glm(mpg ~ cyl+disp+hp+drat+vs+am+carb, data = df)
df3 = add_predictions(df.cross, mod.full.cross)

mean(abs(df3$pred - df3$mpg))

stepAIC(mod.full.cross)

aic.output = stepAIC(mod.full.cross) #lower AIC values are better

ggplot(df, aes(x=disp, y=mpg, color=factor(carb))) +
  geom_point() + geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~am)

mod.test = glm(mpg~ carb+disp+am, data = df)
summary(mod.test)
  