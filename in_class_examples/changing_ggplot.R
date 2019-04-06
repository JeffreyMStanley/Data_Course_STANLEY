# packages
library(tidyverse)
library(wesanderson)

#load data 
data("mtcars")
df = mtcars
sal = read.csv("./Exams/Exam_2/salaries.csv")
# custom palette from google color picker
pal = c("#4286f4", "#17b737")


# clean data
df$am = factor(df$am)


# initial plot 
p1 = ggplot(df, aes(x = hp, y = mpg, color=am)) +
  geom_point(size = 15, alpha = .5)
p1

p1 = p1 + labs(title = "MPG vs HP", x="Horsepower", y = "Miles per Gallon", color = "Auto/Man")


p2 = p1 + scale_color_manual(labels = c("Man", "Auto"), values = pal) +
  theme(plot.title = element_text(face = "italic", hjust = 0.5),
        panel.background = element_rect(fill = "Black"),
        axis.ticks = element_line(colour = NULL),
        panel.grid = element_line(color = "Black"),
        legend.background = element_rect(fill = "Black"),
        legend.key = element_rect(fill = "Red", color = "Black"),
        legend.title = element_text(color = "White"))
p2
# make different things in the same line italic and not italic 
p2 + theme(axis.title.x = element_text(face = "italic"),
           axis.title.y = element_text(face = "italic")) +
  labs(y = expression(paste(italic("Miles"), " per ", italic("Gallom"))))

p3 = ggplot(df, aes(x=am,y=mpg)) 
p3 + geom_boxplot()
p3 + geom_violin() + geom_point()

sal
sal.long = sal %>%
  gather(key = "prof.type", value = "salary", c(5:7))

ggplot(sal.long, aes(x = prof.type, y=salary,fill=Tier) +
         geom_boxplot()

