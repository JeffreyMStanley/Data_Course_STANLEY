library(ShortRead)
library(tidyverse)
library(stringr)
library(msa)
library(seqinr)
library(DNABarcodes)
library(GenomicRanges)
library(ggtree)
library(ape)
library(phangorn)
library(Biostrings)
library(BarcodingR)
library(GenomicAlignments)
library(geiger)
library(phylotools)
#alignment with COI

all.COI = readRDS("./Project_Data/ext_COI/all_COI.RDS")

alignment.COI = msa(all.COI, "ClustalW")
saveRDS(alignment.COI, "./alignment_COI.RDS")
print(alignment.COI, show = "complete")

#reading in everything
alignment.COI = readRDS("./alignment_COI.RDS")
alignment = readRDS("./alignment.RDS")
ranges.COI = readRDS("./ranges_COI.RDS")

options(showTailLines=Inf)
print(ranges.COI)
#########

options(showTailLines=Inf)

sink("./ranges_COI.txt")
options(showTailLines=Inf)
print(ranges.COI)

sink(NULL)
closeAllConnections()
##########
#ggtree for the full thing
?ggtree

bs = readRDS("./full_tree.RDS")
ggplot(bs, aes(x,y)) +
  geom_tree() +
  theme_tree() +
  geom_tiplab()


bs2 = midpoint(bs)
ggplot(bs2, aes(x,y)) +
  geom_tree() +
  theme_tree() +
  geom_tiplab() +
  geom_nodepoint() 

ggsave("./root_full_tree.png", width = 20, height = 12)

bs3 = consensus(bs2, p=1)
bs3 = midpoint(bs3)
#######

# building the tree for COI
alignment2.COI = msaConvert(alignment.COI, "phangorn::phyDat")
dm.COI = dist.ml(alignment2.COI)
treeNJ.COI = NJ(dm.COI)

layout(matrix(c(1,2),2,1), height=c(1,2))
par(mar = c(0,0,2,0) + 0.1)
plot(treeNJ.COI, "unrooted", main = "NJ")

fit.COI = pml(treeNJ.COI, data = alignment2.COI)
methods(class="pml")
fitJC.COI  <- optim.pml(fit.COI, TRUE)
logLik(fitJC.COI) 
mt.COI = modelTest(alignment2.COI)
bs.COI = bootstrap.pml(fitJC.COI, bs = 100, optNni = TRUE)
saveRDS(bs.COI,"COI_tree.RDS") #eddit the tree from this in ggtree. 
bs.COI = readRDS("COI_tree.RDS")

par(mfrow=c(2,1))
par(mar=c(1,1,3,1))
plotBS(midpoint(fitJC.COI$tree), bs.COI, p=50, type="p")
title("a)")
cnet = consensusNet(bs.COI, p = 0.2)
plot(cnet, "2D", show.edg.label=TRUE)
title("b)")
##### plot tree

ggplot(bs.COI, aes(x,y)) +
  geom_tree() +
  theme_tree() +
  geom_tiplab()

bs.COI2 = midpoint(bs.COI)

ggplot(bs.COI2, aes(x,y)) +
  geom_tree() +
  theme_tree() +
  geom_tiplab()

######



