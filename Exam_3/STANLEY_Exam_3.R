# Skills Test 3

# Below are two data sets. Using these data, re-create the two plots in the exam_3 directory.
# Use ggplot
# export (using code) these two plots into your exam_3 directory. 
# They should be saved as .png files at 300 dpi with a width of 5 inches and height of 5 inches
# Naming convention should be LASTNAME_plot1.png and LASTNAME_plot2.png
# Push your R script and the two image files to GitHub.

# Load packages
library(tidyverse)
library(gapminder)
library(ggplot2)
# creating a color palette for plot 1
pal = c("#6b5456","#ec8d1b","#6abf2a","#8b53b7","#70acbe","#01c95b","#c00014","#31332f","#f7d000","#abba00")

# generate data for plot 1
plot1.data = gapminder


# Make and export plot 1
                                # your code for plot1 goes here #
plot1.data
p1 = ggplot(plot1.data, aes(x = year, y = lifeExp, color = continent)) + 
  geom_point(size = 3,alpha = .2) +
  geom_smooth(size = 2, se = FALSE)

p1 = p1 + labs(x = "Year", y = "Life Expectancy", title = "Life Expectancy Over Time \n Colored by Continent",
               color = "Continent") 

p2 = p1 + scale_color_manual(values = pal) + theme(plot.title = element_text(hjust = 0.5, size = 20), 
                                              legend.title = element_text(size = 16),
                                              panel.background = element_rect(fill = "White"),
                                              axis.ticks = element_line(color = NULL),
                                              panel.grid = element_line(color = "gray"),
                                              legend.key = element_rect(fill = "White"))
                                              
                                              
p2
ggsave("STANLEY_plot1.png", dpi = 300, width = 5, height = 5)



ggplot(mtcars, aes(mpg,cyl))+ 
  geom_smooth(aes(fill="Mean",level=0.095)) +
  ggtitle(paste0(title,"\n",subheader)) +
  scale_fill_grey(name='95% Confidence\n Interval',start=.65,end=.65) +
  theme(plot.title = element_text(size = rel(2.0),hjust=-.1,face="bold"))

# Generate data for plot 2 (run the following 5 lines only once to ensure we are all using identical data)
set.seed(123)
a <- data.frame( x=rnorm(20000, 10, 1.9), y=rnorm(20000, 10, 1.2) )
b <- data.frame( x=rnorm(20000, 14.5, 1.9), y=rnorm(20000, 14.5, 1.9) )
c <- data.frame( x=rnorm(20000, 9.5, 1.9), y=rnorm(20000, 15.5, 1.9) )
plot2.data <- rbind(a,b,c)

# make and export plot2
                                # your code for plot2 goes here #
g1 = ggplot(plot2.data, aes(x = x, y = y, color = x)) + 
  geom_point(shape = 15, size = 5) +
  labs(x = NULL, y = NULL)

g1 + theme(panel.background = element_rect(fill = "White"),
           axis.ticks = element_line(color = "White"),
           panel.grid = element_line(color = "White"),
           legend.background = element_rect(fill = "white"),
           legend.key = element_rect(fill = "white"),
           legend.title = element_text(color = "white"),
           axis.text.y = element_blank(),
           axis.text.x = element_blank())
ggsave("STANLEY_plot2.png", dpi = 300, width = 5, height = 5)

fail_1 = ggplot(plot2.data, aes(x = x, y=y)) +
  geom_bin2d()
fail_1 + theme(panel.background = element_rect(fill = "White"),
               axis.ticks = element_line(color = "White"),
               panel.grid = element_line(color = "White"),
               legend.background = element_rect(fill = "white"),
               legend.key = element_rect(fill = "white"),
               legend.title = element_text(color = "white"),
               axis.text.y = element_blank(),
               axis.text.x = element_blank())
ggsave("STANLEY_plot2.png", dpi = 300, width = 5, height = 5)
               