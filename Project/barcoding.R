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
arcCOI = readDNAStringSet("./Project_Data/COI/COI_Acrochordus_g.fasta")

boa = readDNAStringSet("./Project_Data/Boa_c_mt.fasta")
boaCOI = readDNAStringSet("./Project_Data/COI/COI_Boa_c.fasta")

cyl = readDNAStringSet("Project_Data/Cylindrophis_r_mt.fasta")
cylCOI = readDNAStringSet("./Project_Data/COI/COI_Cylindrophis_r.fasta")

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

enhaln = Biostrings::pairwiseAlignment(enhCOI, enh, type = "local")

igualn = Biostrings::pairwiseAlignment(iguCOI, igu, type = "local")

najaaln = Biostrings::pairwiseAlignment(najaCOI, naja, type = "local")

ovoaln = Biostrings::pairwiseAlignment(ovoCOI, ovo, type = "local")

panaln = Biostrings::pairwiseAlignment(panCOI, pan, type = "local")

plealn = Biostrings::pairwiseAlignment(pleCOI, ple, type = "local")

pytaln = Biostrings::pairwiseAlignment(pytCOI, pyt, type = "local")

ramaln = Biostrings::pairwiseAlignment(ramCOI, ram, type = "local")

renaln = Biostrings::pairwiseAlignment(renaCOI, rena, type = "local")

xenaln = Biostrings::pairwiseAlignment(xenCOI, xen, type = "local")
######
# http://bioconductor.org/packages/release/bioc/vignettes/Biostrings/inst/doc/PairwiseAlignments.pdf
# aligned(pattern())
# views gets stard end and width
ext.agk = alignedPattern(agkaln)
view.agk = Views(agkaln, names = "agk")
saveRDS(ext.agk, "./Project_Data/ext_COI/ext_agk.RDS")
saveRDS(view.agk, "./Project_Data/ext_COI/views/view_agk.RDS")

ext.amp = alignedPattern(ampanl)
view.amp = Views(ampanl, name = "amp")
saveRDS(ext.amp, "./Project_Data/ext_COI/ext_amp.RDS")
saveRDS(view.amp, "./Project_Data/ext_COI/views/view_amp.RDS")

ext.arc = alignedPattern(arcaln)
view.arc = Views(arcaln, name = "arc")
saveRDS(ext.arc,"./Project_Data/ext_COI/ext_arc.RDS")
saveRDS(view.arc, "./Project_Data/ext_COI/views/view_arc.RDS")

ext.boa = alignedPattern(boaaln)
view.boa= Views(boaaln, names = "boa")
saveRDS(ext.boa,"./Project_Data/ext_COI/ext_boa.RDS")
saveRDS(view.boa, "./Project_Data/ext_COI/views/view_boa.RDS")

ext.cyl = alignedPattern(cylaln)
view.cyl = Views(cylaln, name = "cyl")
saveRDS(ext.cyl,"./Project_Data/ext_COI/ext_cyl.RDS")
saveRDS(view.cyl, "./Project_Data/ext_COI/views/view_cyl.RDS")

ext.did = alignedPattern(didaln)
view.did = Views(didaln, name = "did")
saveRDS(ext.did,"./Project_Data/ext_COI/ext_did.RDS")
saveRDS(view.did, "./Project_Data/ext_COI/views/view_did.RDS")

ext.enh = alignedPattern(enhaln)
view.enh = Views(enhaln, names = "enh")
saveRDS(ext.enh,"./Project_Data/ext_COI/ext_enh.RDS")
saveRDS(view.enh, "./Project_Data/ext_COI/views/view_enh.RDS")

ext.igu = alignedPattern(igualn)
view.igu = Views(igualn, names = "igu")
saveRDS(ext.igu,"./Project_Data/ext_COI/ext_igu.RDS")
saveRDS(view.igu, "./Project_Data/ext_COI/views/view_igu.RDS")

ext.naja = alignedPattern(najaaln)
view.naja = Views(najaaln, names = "naja")
saveRDS(ext.naja,"./Project_Data/ext_COI/ext_naja.RDS")
saveRDS(view.naja, "./Project_Data/ext_COI/views/view_naja.RDS")

ext.ovo = alignedPattern(ovoaln)
view.ovo = Views(ovoaln, names = "ovo")
saveRDS(ext.ovo,"./Project_Data/ext_COI/ext_ovo.RDS")
saveRDS(view.ovo, "./Project_Data/ext_COI/views/view_ovo.RDS")

ext.pan = alignedPattern(panaln)
view.pan = Views(panaln, names = "pan")
saveRDS(ext.pan,"./Project_Data/ext_COI/ext_pan.RDS")
saveRDS(view.pan, "./Project_Data/ext_COI/views/view_pan.RDS")

ext.ple = alignedPattern(plealn)
view.ple = Views(plealn, names = "ple")
saveRDS(ext.ple,"./Project_Data/ext_COI/ext_ple.RDS")
saveRDS(view.ple, "./Project_Data/ext_COI/views/view_ple.RDS")

ext.pyt = alignedPattern(pytaln)
view.pyt = Views(pytaln, names = "pyt")
saveRDS(ext.pyt,"./Project_Data/ext_COI/ext_pyt.RDS")
saveRDS(view.pyt, "./Project_Data/ext_COI/views/view_pyt.RDS")

ext.ram = alignedPattern(ramaln)
view.ram = Views(ramaln, names = "ram")
saveRDS(ext.ram,"./Project_Data/ext_COI/ext_ram.RDS")
saveRDS(view.ram, "./Project_Data/ext_COI/views/view_ram.RDS")

ext.ren = alignedPattern(renaln)
view.ren = Views(renaln, names = "ren")
saveRDS(ext.ren,"./Project_Data/ext_COI/ext_ren.RDS")
saveRDS(view.ren, "./Project_Data/ext_COI/views/view_ren.RDS")

ext.xen = alignedPattern(xenaln)
view.xen = Views(xenaln, names = "xen")
saveRDS(ext.xen,"./Project_Data/ext_COI/ext_xen.RDS")
saveRDS(view.xen, "./Project_Data/ext_COI/views/view_xen.RDS")
########

#alignment
all.COI = c(ext.agk,ext.amp,ext.arc,ext.boa,ext.cyl,ext.did,ext.enh,ext.igu,ext.naja,ext.ovo,ext.pan
            ,ext.ple,ext.pyt,ext.ram,ext.ren,ext.xen)
saveRDS(all.COI, "./Project_Data/ext_COI/all_COI.RDS")
all.COI = readRDS("./Project_Data/ext_COI/all_COI.RDS")
print(all.COI, show = "complete")

# Iranges
agk.r = ranges(view.agk)
amp.r = ranges(view.amp)
arc.r = ranges(view.arc)
boa.r = ranges(view.boa)
cyl.r = ranges(view.cyl)
did.r = ranges(view.did)
enh.r = ranges(view.enh)
igu.r = ranges(view.igu)
naja.r = ranges(view.naja)
ovo.r = ranges(view.ovo)
pan.r = ranges(view.pan)
ple.r = ranges(view.ple)
pyt.r = ranges(view.pyt)
ram.r = ranges(view.ram)
ren.r = ranges(view.ren)
xen.r = ranges(view.xen)

ranges.COI = c(agk.r,amp.r,arc.r,boa.r,cyl.r,did.r,enh.r,igu.r,naja.r,ovo.r,pan.r,ple.r,pyt.r,ram.r,ren.r,xen.r)
ranges.COI
saveRDS(ranges.COI, "./ranges_COI.RDS")
#####

