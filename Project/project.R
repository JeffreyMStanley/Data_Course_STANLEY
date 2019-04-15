
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

# im going to start by looking at just some restricting snakes

#test this did not really work needed to read in as DMA strings 
boa =  read.fasta("Project_Data/Boa_c_mt.fasta")
ball = read.fasta("Project_Data/Python_r_mt.fasta")
######

#read in with DNAStringSet
boa2 = readDNAStringSet("./Project_Data/Boa_c_mt.fasta")
ball2 = readDNAStringSet("./Project_Data/Python_r_mt.fasta")
#######

# loeading in files for an alignment with all of the files in the data foler ##############
files <- list.files("./Project_Data/", pattern = "*.fasta$", full.names = TRUE)
test.sec2 = readDNAStringSet(files) ##############################
######


# aligning the just the first two sequences this method did not really work all that well.
boa = as.character(boa)
ball = as.character(ball)
test.sec = c(boa,ball)

test.A = msa(test.sec,"ClustalW", type ="DNA")
test.A
write.fasta(test.A, ball, file = "testA.fasta")
######

# the best test for what im trying to do.
test.sec1.2 = c(boa2,ball2)

test.A2 = msa(test.sec1.2, "ClustalW")
saveRDS(test.A2, "./test.A2.RDS")

test.A2
test.A2 = readRDS("./test.A2.RDS")
msaPrettyPrint(x = test.A2, output = "pdf", file = "test.A2.pdf")
# write.fasta(test.A2, file = "testA2.fasta") Does not work
#######
# testing trees in phangorn, conver with msaConver
test.A2phy = msaConvert(test.A2, "phangorn::phyDat")


###
# testing GenomicRanges with just ball and boa to try to find Cytochrome Oxidase I (COI)
boaCOI = read.fasta("./Project_Data/COI/COI_Boa_c.fasta")
un.t = union(boaCOI, boa)
un.t
un.t2 = intersect(boaCOI, boa)
?`GenomicRanges-comparison`
#####

# the first to lines together the 3rth like is just to get it to load back up ############
alignment = msa(test.sec2, "ClustalW")
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
