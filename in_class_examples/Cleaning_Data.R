df = read.csv("Exercises/ugly_data1.csv")
library(tidyverse)

df


long = gather(df,Group,Value,2:9)

# long$Gender = c(rep("Male",36), rep("Female",36)) this works now but if data is added it wont work any more

malerows = grep("^m", long$Group)
femalerows = grep("^f", long$Group)

long$Gender[malerows] <- "Male"
long$Gender[femalerows] <- "Female"

long$Group = str_remove(long$Group, "^m")
long$Group = str_remove(long$Group, "^f")

ages = str_replace(long$Group,"014", "0014")



ages1 = substr(ages,start = 1, stop = 2)
ages2 = substr(ages,start = 3, stop = 4)
ages = paste0(ages1, "-", ages2)
long$Group = ages
names(long)[names(long) == "Group"] <- "AgeRange"

# to save a your work    write.csv("file_path",row.names = FALSE,quote = FALSE)

