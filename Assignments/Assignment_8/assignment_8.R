library(modelr)
library(tidyverse)
library(aod)

# 1 = in grad school. 0 = not in grad school
df = read.csv("./GradSchool_Admissions.csv")
df
class(df$rank)
df$rank = as.factor(df$rank)

summary(df)
sapply(df, sd)

ggplot(df, aes(x = rank, y = admit)) +
  geom_point()

ggplot(df, aes(x = gpa, y=admit)) +
  geom_point(aes(color = factor(admit))) 
  
ggplot(df, aes(x= gre, y = admit)) +
  geom_point(aes(color = factor(admit)))

mod1 = glm(admit ~ gpa+gre+rank, data = df, family = "binomial")


summary(mod1)
confint(mod1)
confint.default(mod1)

# test wether school rank means anything
wald.test(b = coef(mod1), Sigma = vcov(mod1), Terms = 4:6)


#to test the difference between tier 2 and 3
l = cbind(0,0,0,1,-1,0)
wald.test(b = coef(mod1), Sigma = vcov(mod1), L=l)

k = cbind(0,0,0,0,1,-1)
wald.test(b = coef(mod1), Sigma = vcov(mod1), L=k)

# predictied probablities for each rank
new.df1 = with(df, data.frame(gre = mean(gre), gpa = mean(gpa), rank = factor(1:4)))
new.df1$rankP <- predict(mod1, newdata = new.df1, type = "response")
new.df1


