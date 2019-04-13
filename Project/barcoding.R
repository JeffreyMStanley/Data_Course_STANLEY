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
#test with boa pairwiseAlignment
#load them in 
# missing one of them Varanus komodoensis
agk = readDNAStringSet("./Project_Data/Agkistrodon_p_mt.fasta")
agkCOI = readDNAStringSet("./Project_Data/COI/COI_Agkistrodon_p.fasta")

amp = readDNAStringSet("./Project_Data/Amphisbaena_s_v_mt.fasta")
ampCOI = readDNAStringSet("./Project_Data/COI/COI_Amphisbaena_s.fasta")

arc = readDNAStringSet("./Project_Data/Archochordus_g_mt.fasta")
arcCOI = readDNAStringSet("./Project_Data/Archochordus_g_mt.fasta")

boa = readDNAStringSet("./Project_Data/Boa_c_mt.fasta")
boaCOI = readDNAStringSet("./Project_Data/COI/COI_Boa_c.fasta")

cyl = readDNAStringSet("Project_Data/Cylindrophis_r_mt.fasta")
cylCOI = readDNAStringSet("./Project_Data/Cylindrophis_r_mt.fasta")


did = readDNAStringSet("./Project_Data/Didodon_s_mt.fasta")
didCOI = readDNAStringSet("./Project_Data/COI/COI_Dinodon_s.fasta")

enh = readDNAStringSet("./Project_Data/Enhydris_p_mt.fasta")
enhCOI = readDNAStringSet("./Project_Data/COI/COI_Enhydris_p.fasta")

igu = readDNAStringSet("./Project_Data/Iguana_i_mt.fasta")
iguCOI = readDNAStringSet("./Project_Data/COI/COI_Iguana_i.fasta")

naja = readDNAStringSet("./Project_Data/Naja_n_mt.fasta")
najaCOI = readDNAStringSet("./Project_Data/COI/COI_Naja_n.fasta")

ovo = readDNAStringSet("./Project_Data/Ovophis_o_mt.fasta")
ovoCOI = readDNAStringSet("./Project_Data/COI/COI_Ovophis_o.fasta")

pan = readDNAStringSet("./Project_Data/Pantherophis_s_mt.fasta")
panCOI = readDNAStringSet("./Project_Data/COI/COI_Pantherophis_s.fasta")

ple = readDNAStringSet("./Project_Data/Plestiodon_e_mt.fasta")
pleCOI = readDNAStringSet("./Project_Data/COI/COI_Plestiodon_e.fasta")

pyt = readDNAStringSet("./Project_Data/Python_r_mt.fasta")
pytCOI = readDNAStringSet("./Project_Data/COI/COI_Python_r.fasta")

ram = readDNAStringSet("./Project_Data/Ramphotyphlops_b_mt.fasta")
ramCOI = readDNAStringSet("./Project_Data/COI/COI_Ramphotyphlops_b.fasta")

rena = readDNAStringSet("./Project_Data/Rena_h_mt.fasta")
renaCOI = readDNAStringSet("./Project_Data/COI/COI_Rena_h.fasta")

xen = readDNAStringSet("./Project_Data/Xenopeltis_u_mt.fasta")
xenCOI = readDNAStringSet("./Project_Data/COI/COI_Xenopeltis_u.fasta")

#alignmentss
agkaln = Biostrings::pairwiseAlignment(agkCOI, agk, type = "local")

ampanl = Biostrings::pairwiseAlignment(ampCOI, amp, type = "local")

arcaln = Biostrings::pairwiseAlignment(arcCOI, arc, type = "local")

boaaln = Biostrings::pairwiseAlignment(boaCOI, boa, type = "local")

cylaln = Biostrings::pairwiseAlignment(cylCOI, cyl, type = "local")

didaln = Biostrings::pairwiseAlignment(didCOI, did, type = "local")

enhCOI = Biostrings::pairwiseAlignment(enhCOI, enh, type = "local")

igualn = Biostrings::pairwiseAlignment(iguCOI, igu, type = "local")

najaaln = Biostrings::pairwiseAlignment(najaCOI, naja, type = "local")

ovoaln = Biostrings::pairwiseAlignment(ovoCOI, ovo, type = "local")

panaln = Biostrings::pairwiseAlignment(panCOI, pan, type = "local")

plealn = Biostrings::pairwiseAlignment(pleCOI, ple, type = "local")

pytaln = Biostrings::pairwiseAlignment(pytCOI, pyt, type = "local")

ramaln = Biostrings::pairwiseAlignment(ramCOI, ram, type = "local")

renalan = Biostrings::pairwiseAlignment(renaCOI, rena, type = "local")

xenaln = Biostrings::pairwiseAlignment(xenCOI, xen, type = "local")
######
# http://bioconductor.org/packages/release/bioc/vignettes/Biostrings/inst/doc/PairwiseAlignments.pdf
# aligned(pattern())
# views gets stard end and width

test1 = alignedPattern(boaaln)
test2 = Views(boaaln)

alignedPattern(agkaln)
Views(agkaln)
