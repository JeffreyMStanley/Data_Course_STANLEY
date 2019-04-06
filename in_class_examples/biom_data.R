library(tidyverse)
library(vegan)

meta = read.csv("./Data/MLO_Metadata.csv")
otu = read.csv("Data/MLO_OTU_Table.csv")

colnames(otu)[1] <- "sample"
row.names(otu) <- otu$sample

otu = otu[,-1]
as.character(meta$SampleID)

row.names(otu)
# subset metadata to same samples that are in otu and then make sure they're in 
# the same exact order

good.samples = as.character(meta$SampleID) %in% row.names(otu)
sum(good.samples)

meta = meta[good.samples,]
meta

meta = arrange(meta, SampleID)
?arrange



# quick heatmap
heatmap(as.matrix(otu))



# remove empty otus and samples
colsums(otu)
otu = otu[colSums(otu) > 0]

otu = otu[rowSums(otu) > 0]
# go back and rerun heatmap

# build a model ... community structure as function of year
dist = vegdist(otu,method = "jaccard", binaary = TRUE)

adonis(dist ~ meta$Year + meta$Quarter)

# visualize it 
nmds = metaMDS(otu)
x = nmds$points[,1]
y = nmds$points[,2]

df = data.frame(Quarter = meta$Quarter, year = meta$Year)

ggplot(df, aes(x=x, y=y, color = factor(year))) +
  geom_point() +
  lims(x = c(-.1,.1))

