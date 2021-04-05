#!/usr/bin/env Rscript
# Deleting_same_fixed_allele.R script
# As part of the DiagnoSNPs package
# This script deletes shared fixed allele SNPs between two groups:

# Loading data
fixed <- read.table("HWe_snps.hwe", header = T)

# Creating loci names
fixed$names <- paste(fixed$CHR, fixed$POS, sep = ",")
print("Total number of fixed loci:")
length(fixed$names)

# Taking out SNPs fixed for the same allele in both species (monomorphic for both groups)
fixed_filtered <- fixed[!fixed$ChiSq_HWE == 'NaN',]
message("Total number of bi-allelic SNPs fixed for opposite alleles between the two groups")
length(fixed_filtered$names)

# Writing file for shared loci
write(fixed_filtered$names, "diagnostic_snps.txt", ncolumns = 1)
