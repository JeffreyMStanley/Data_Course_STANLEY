df = read.csv("Data/1620_scores.csv")

library(tidyverse)
library(modelr)

ggplot(df, aes(y = df$Exam.1..4245260., x = df$Actual.PreTest.Score...not.what.your.grade.is...4122452.)) +
  geom_point()

mod1 = lm(data = df, df$Exam.1..4245260. ~ df$Actual.PreTest.Score...not.what.your.grade.is...4122452.) 
summary(mod1)

df %>% mutate(MeanExam = sum(Exam.1..4245260. + Exam.2..4245261.)/2) # this didnt do what I wanted

df$SumExams = df$Exam.1..4245260. + df$Exam.2..4245261.

ggplot(df, aes(x = df$Actual.PreTest.Score...not.what.your.grade.is...4122452., y = SumExams)) + 
  geom_point() + geom_smooth(method = "lm")


mod2 = lm(data = df, SumExams ~ df$Actual.PreTest.Score...not.what.your.grade.is...4122452.)
summary(mod2)

ggplot(df, aes(x = Actual.PreTest.Score...not.what.your.grade.is...4122452., y = SumExams)) + 
  geom_point() + geom_smooth( method = "lm")

df$MeanQuiz = rowSums(df[,17:23])/7

mod3 = lm(data = df, SumExams ~ Actual.PreTest.Score...not.what.your.grade.is...4122452. + MeanQuiz)
summary(mod3)

?anova() #compares models to see whats important

anova(mod1, mod2)
anova(mod2,mod3)
anova(mod1, mod3)


df = add_predictions(df, mod3, var = "mod3")
df = add_predictions(df, mod2, var = "mod2")
df = add_predictions(df, mod1, var = "mod1")

ggplot(mapping = aes(x=row.names(df))) +
  geom_point(aes(y=df$SumExams),color = "Black") +
  geom_point(aes(y = df$mod1, color = "Red")) +
  geom_point(aes(y = df$mod3, color = "Blue"))

ggplot(df, aes(x=MeanQuiz, y = SumExams)) + 
  geom_point() + geom_smooth(color = "Black",method = "lm") +
  geom_smooth(aes(y = mod3), color = "Red", method = "lm") +
  geom_smooth(aes(y = mod1), color = "Blue", method = "lm")

sum(residuals(mod1)^2)
sum(residuals(mod3)^2)

#predicting a certain value

mod3 

newdf = data.frame(Actual.PreTest.Score...not.what.your.grade.is...4122452.=c(20,30,40),
           MeanQuiz = c(7,2,8))

predict(mod3, newdata = newdf)

#tidying things up
bird = read.csv("Data/Bird_Measurements.csv")
# find column with mass (except egg mass)
masscols = grep("mass", names(bird))[-7]
masscols = c(5,7,9)
# find cols to keep in every supset
impt.cols = c(1:4)

# subset to mass only
bird.mass = bird[,c(impt.cols,masscols)]

#long format (mass only)
mass.long = gather(bird.mass,Sex,Mass,5:7)

mass.long$Sex = str_remove(mass.long$Sex,"_mass")
unique(mass.long$Sex)

mass.long %>%
  
