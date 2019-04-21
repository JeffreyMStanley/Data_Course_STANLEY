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


?geom_tiplab

ggtree(bs) +
  geom_tiplab()

ape::write.nexus(bs, file = "./bs_tree.nexus")
bs2 = ape::read.nexus(file = "./bs_tree.nexus")
bs3 = consensus(bs, p=1)
bs3
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

ggplot(bs.COI, aes(x,y)) +
  geom_tree() +
  theme_tree() +
  geom_tiplab()

####### changing names does not work Im going to do it manualy
name.check(bs)
class(bs$tip.label)
bs$tip.label <- list("Agkistrodon_piscivorus", "Ovophis_okinavensis", "Dinodon_semicarinatus", 
                     "Pantherophis_slowinskii", "Naja_naja", "Enhydris_plumbea", "Python_regius",
                     "Xenopeltis_unicolor", "Cylindrophis_ruffus", "Boa_constrictor", "Acrochordus_granulatus",
                     "Ramphotyphlop_braminus", "Rena_humilis", "Amphisbaena_schmidti", "Varanus_komodoensis",
                     "Varanus_komodoensis", "Plestiodon_egregius")
list.org = list("Agkistrodon_piscivorus", "Ovophis_okinavensis", "Dinodon_semicarinatus", 
     "Pantherophis_slowinskii", "Naja_naja", "Enhydris_plumbea", "Python_regius",
     "Xenopeltis_unicolor", "Cylindrophis_ruffus", "Boa_constrictor", "Acrochordus_granulatus",
     "Ramphotyphlop_braminus", "Rena_humilis", "Amphisbaena_schmidti", "Varanus_komodoensis",
     "Varanus_komodoensis", "Plestiodon_egregius")
bs$tip.label -> bs.tips
df = data.frame(l1 = bs.tips, l2 = list.org)

bs.tips = list.org
ggtree(bs) %<+% geom_tiplab(label=l2)
class(list.org)

org = c("Agkistrodon_piscivorus", "Ovophis_okinavensis", "Dinodon_semicarinatus", 
              "Pantherophis_slowinskii", "Naja_naja", "Enhydris_plumbea", "Python_regius",
              "Xenopeltis_unicolor", "Cylindrophis_ruffus", "Boa_constrictor", "Acrochordus_granulatus",
              "Ramphotyphlop_braminus", "Rena_humilis", "Amphisbaena_schmidti", "Varanus_komodoensis",
              "Varanus_komodoensis", "Plestiodon_egregius")
class(org)
list.org2 = as.list(org)
as.phylo(list.org)
bs$tip.label <- list.org

bs.tips = bs$tip.label
bs$tip.label = bs.tips
######



