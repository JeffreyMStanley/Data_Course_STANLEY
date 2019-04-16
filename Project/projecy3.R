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
library(Biostrings)
library(BarcodingR)
library(GenomicAlignments)

#alignment with COI

all.COI = readRDS("./Project_Data/ext_COI/all_COI.RDS")

alignment.COI = msa(all.COI, "ClustalW")
saveRDS(alignment.COI, "./alignment_COI.RDS")
print(alignment.COI, show = "complete")

#reading in everything
alignment.COI = readRDS("./alignment_COI.RDS")
alignment = readRDS("./alignment.RDS")
ranges.COI = readRDS("./ranges_COI.RDS")




?ggtree
