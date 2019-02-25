library(tidyverse)


a = rnorm(500000, mean = 10, sd = 1)
b = rnorm(500000, mean = 10.5, sd = 1)
c = rnorm(500000, mean = 11, sd = 1)
df = data.frame(a=a,b=b,c=c)
df = gather(df, Var, Value, 1:3)

mean(a)
sd(a)

mean(b)
sd(b)



?rnorm #gets random value with a given mean and sd


ggplot(df, aes(x=Value, fill = Var)) +
  geom_density(alpha = .5) 


t.test(a,b) #difference between means
t.test(a,c)


mod1 = (aov(Value ~ Var, data = df))
summary(mod1)
tuk1 = TukeyHSD(mod1)
tuk1
plot(tuk1)




hist(rbinom(100000,10,.5)) #number ex, size of ex, probaility of sucsess


binom.test(10,10,.5) # X=bumber successes, n = number of trials, p = probaility of success
