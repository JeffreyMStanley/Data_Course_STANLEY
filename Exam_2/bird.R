bird = read.csv("./Bird_Measurements.csv")
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

