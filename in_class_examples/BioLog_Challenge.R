library(tidyverse)
df = read.csv("./Data/BioLog_Plate_Data.csv")

glimpse(df)
?plyr::mapvalues() #plyr is a package mapvalues is a funtion
library(plyr)
?mapvalues()

geoff = c("geoff", "geoff", "geoffreey")
mapvalues(geoff, from = geoff, to = rep("Geoff",3)) #,3 repet string 3 times

hours = c("Hr_24", "Hr_48", "Hr_144")

as.numeric(mapvalues(hours, from = c("Hr_24", "Hr_48", "Hr_144"), to = c(24,48,144)))

# write a command the subsets the BioLog data to Clear_Creek samples, with dilution of 0.01, and only "Glycogen"
df2 = df %>%
  filter(Sample.ID == "Clear_Creek" & Dilution == 0.01 & Substrate == "Glycogen") %>%
  gather(key = "Hours", value = "abs", c(6:8))

df_long = df %>%
  gather(key = "Hours", value = "abs", c(6:8))

Tween_80 = (plyr::mapvalues(df_long$Substrate, from = "Tween 80 ", to = "Tween_80"))
df_long$Substrate = as.factor(Tween_80)

# Now plot those three replicates over time.
hours = (plyr::mapvalues(df_long$Hours, from = c("Hr_24", "Hr_48", "Hr_144"), to = c(24,48,144)))
df_long$Hours = as.numeric(hours)

hours = (plyr::mapvalues(df2$Hours, from = c("Hr_24", "Hr_48", "Hr_144"), to = c(24,48,144)))
df2$Hours = as.numeric(hours)

ggplot(df2, aes(x=Hours, y=abs, color= factor(Rep))) +
  geom_point() +
  geom_smooth()


# Make a plot of Tween 80 utilization over time for ALL the samples, colored by Sample.ID
df_Tween_80 = df_long %>%
  filter(Substrate == "Tween_80")
hours = (plyr::mapvalues(df_long$Hours, from = c("Hr_24", "Hr_48", "Hr_144"), to = c(24,48,144)))
df_long0$Hours = as.factor(hours)

ggplot(df_Tween_80, aes(x=Hours, y=abs, color = Sample.ID)) +
  geom_boxplot() 
  

# Now, same plot, but combine both soils and both waters into soil and water groups and color by soil vs water
levels(df$Sample.ID)

Soil = plyr::mapvalues(df_Tween_80$Sample.ID, from = c("Soil_1", "Soil_2"), to = rep("Soil",2)) +
   plyr::mapvalues(df_Tween_80$Sample.ID, from = c("Clear_Creek", "Waste_Water"), to = rep("Water",2))


df_Tween_80$Sample.ID = as.factor(Soil)

ggplot(df_Tween_80, aes(x=Hours, y=abs, color = Sample.ID)) +
  geom_boxplot() 

# Make a table of summary statistics: for each combination of Sample.ID and Substrate, give:
# -- Number of observations
# -- Mean absorbance value
df_long_S = df_long %>%
  group_by(Sample.ID, Substrate) %>%
  summarise(mean_abs = mean(abs), N=n())


# Example output ....

# Sample.ID     Substrate                       N Mean
# <fct>         <fct>                       <int> <dbl>
# 1 Clear_Creek 2-Hydroxy Benzoic Acid         27 0.0562
# 2 Clear_Creek 4-Hydroxy Benzoic Acid         27 0.247 
# 3 Clear_Creek D-Cellobiose                   27 0.403 
# 4 Clear_Creek D-Galactonic Acid γ-Lactone    27 0.314 
# 5 Clear_Creek D-Galacturonic Acid            27 0.385 
# 6 Clear_Creek D-Glucosaminic Acid            27 0.154 
# 7 Clear_Creek D.L -α-Glycerol Phosphate      27 0.0335
# 8 Clear_Creek D-Mallic Acid                  27 0.170 
# 9 Clear_Creek D-Mannitol                     27 0.346 
# 10 Clear_Creek D-Xylose                       27 0.0323
# 

