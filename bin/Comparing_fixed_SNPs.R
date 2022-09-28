#!/usr/bin/env Rscript
# Comparing_fixed_SNPs.R script
# As part of the DiagnoSNPs package
# This script looks for shared fixed SNPs between two groups:

# Loading data
hwe <- list()
hwe$a <- read.table("tmp_a.hwe", header = T)
hwe$b <- read.table("tmp_b.hwe", header = T)

# Creating loci names
lapply(hwe, function(x) data.frame(x, names=paste(x$CHR, x$POS, sep=","))) -> hwe

# Looking for shared loci between species
shared <- intersect(hwe$a$names, hwe$b$names)
print("Some shared loci:")
head(shared)
print("Total number of shared fixed loci:")
length(shared)

# Writing file for shared loci
write(shared, "shared.txt", ncolumns = 1)
