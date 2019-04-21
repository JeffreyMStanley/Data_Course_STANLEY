
library(ShortRead)
library(tidyr)
library(stringr)
library(msa)
library(seqinr)
library(DNABarcodes)
library(GenomicRanges)
library(ggtree)
library(ape)
library(phangorn)

#must be DNA stringset
# loeading in files for an alignment with all of the files in the data foler ##############
files <- list.files("./Project_Data/", pattern = "*.fasta$", full.names = TRUE)
snake.mt = readDNAStringSet(files) ##############################
######

# the first to lines together the 3rth like is just to get it to load back up ############
alignment = msa(snake.mt, "ClustalW")
saveRDS(alignment, "./alignment.RDS")
alignment
alignment = readRDS("./alignment.RDS")
print(alignment, show = "complete") #to view the full alignment just so I know it worked ################
#####

# bulding a Tree https://cran.r-project.org/web/packages/phangorn/vignettes/Trees.pdf
alignment2 = msaConvert(alignment, "phangorn::phyDat")
dm = dist.ml(alignment2)
treeNJ = NJ(dm)

layout(matrix(c(1,2),2,1), height=c(1,2))
par(mar = c(0,0,2,0) + 0.1)
plot(treeNJ, "unrooted", main = "NJ")

fit = pml(treeNJ, data = alignment2)
methods(class="pml")
fitJC  <- optim.pml(fit, TRUE)
logLik(fitJC) 
mt = modelTest(alignment2)
bs = bootstrap.pml(fitJC, bs = 100, optNni = TRUE)
saveRDS(bs,"full_tree.RDS") #eddit the tree from this in ggtree. 
bs = readRDS("full_tree.RDS")

#ploting the tree
png("./mltree.png")

par(mfrow=c(2,1))
par(mar=c(1,1,3,1))
plotBS(midpoint(fitJC$tree), bs, p=50, type="p")
title("a)")
cnet = consensusNet(bs, p = 0.2)
plot(cnet, "2D", show.edg.label=TRUE)
title("b)")

dev.off()
######

# steps for barcoding
# 1. for barcoding I need to get the cytochrom oxidase 1 sequence for ever sample and find where it is
# 2. I need to cut it out with genomicRanges so then I just have COI 

# get a tree for the whole sequence

?GenomicRanges
?DNABarcodes
?create.dnabarcodes(4)
?msa
?ape
?phangorn
?Trees
?pml
?ggtree
