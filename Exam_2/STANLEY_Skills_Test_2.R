library(tidyverse)
library(modelr)
# I. 	Simple tidying exercise
sal = read.csv("./salaries.csv")

# 2.  Convert to usable tidy format so we can look at "Salary" as a dependent variable (10 points)

sal.long = sal %>%
  gather(key = "prof.type", value = "salary", c(5:7))
#3.  Create boxplot of salary by University Tier, colored by Faculty Rank (10 points)
# x-axis = Tier
# y-axis = Salary
# Boxplot fill color = Rank
# Title = "Faculty Salaries - 1995"

# 4.  Export this delightful boxplot to a file named "LASTNAME_exam2_plot1.jpeg" (10 points)

jpeg("STANLEY_exam2_plot1.jpeg")

ggplot(sal.long, aes(x= Tier, y = salary, color = prof.type)) +
  geom_boxplot()

dev.off()

# II. Linear modeling and predictions
at = read.csv("./atmosphere.csv")

# 2.  Create two different linear models with Diversity as the dependent variable. The second model should have the
# same terms as the first, but an additional one or two terms as well. (10 points)
at
mod1 = lm(Diversity ~ Precip+CO2_Concentration, data = at)
summary(mod1)

mod2 = lm(Diversity ~Precip+CO2_Concentration+Aerosol_Density, data = at)
summary(mod2)
#3.  Compare the residuals of the two models and document which has better explanatory power for the data (10 points)

resid1 = residuals(mod1)
resid1

resid2 = residuals(mod2)
resid2
at$resid1 = resid1
at$resid2 = resid2

max(at$resid1)
min(at$resid1)
mean(at$resid1)

max(at$resid2)
min(at$resid2)
mean(at$resid2)
# based on compareing residuals mod2 is better because they are closser to 0

?residuals
#4.  Use these both models to predict Diversity values in the data set (10 points)

at$pred1 = predict(mod1)
at$pred2 = predict(mod2)

#5.  Make a plot showing actual Diversity values, along with the two models' predicted Diversity values.
    #Use color or some other aesthetic to differentiate the actual values and both predictions (10 points)

ggplot(at, aes(x = Precip)) +
  geom_point(aes(y=Diversity, color = "Diversity")) +
  geom_point(aes(y = pred1, color = "pred1")) +
  geom_point(aes(y = pred2, color = "pred2")) 
  

#6.  Write code to show the predicted values of Diversity for each model using the hypothetical data 
    # found in hyp_data.csv (10 points)
hyp = read.csv("./hyp_data.csv")


hyp = add_predictions(hyp, mod1, var = "pred1")

hyp = add_predictions(hyp, mod2, var = "pred2")
# from class
pred.hyp1 = predict(mod1, newdata = hyp)
pred.hyp2 = predict(mod2, newdata = hyp)

# 7.  Export a text file that contains the summary output from *both* your models to "model_summaries.txt" (10 points)


s1 = summary(mod1)
s2 = summary(mod2)
capture.output(s1,s2, file = "model_summaries.txt")


# 8.  Add these predicted values (from hypothetical data - Part II, Step 6) to a plot of actual data 
#  and differentiate them by color. (10 bonus points possible for a pretty graph)

ggplot(at, aes(x = Precip)) +
  geom_point(aes(y = hyp$pred1))

# a better way from class
p1 = ggplot(atm, aes(x = Precip, y = Diversity)) +
     geom_point()

p1 + geom_point(aes(y = pred1), color = "Red) +
    geom_point(aes(y = pred2), color = "Green")


