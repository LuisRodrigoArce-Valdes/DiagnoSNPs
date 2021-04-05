#!/bin/bash
version=1.0

usage() {
echo "DiagnoSNPs.sh v $version by Luis Rodrigo Arce-Valdés (04/04/2021)
DiagnoSNPs.sh - A small pipeline to identify SNPs fixed with alternative alleles between two groups of samples

Usage:
DiagnoSNPs.sh -v vcf -a first_group.txt -b second_group.txt -o dir -p prefix

Options:
-v: path to the vcf input file.
-a: path to a text file with the samples names of the first group (Format is 'SAMPLE1\n SAMPLE2\n ...')
-b: path to a text file with the samples names of the second group (Format is 'SAMPLE1\n SAMPLE2\n ...')
-o: path to a directory where to write the output file
-p: prefix for output file

Dependencies:
+ vcftools:
Petr Danecek, Adam Auton, Goncalo Abecasis, Cornelis A. Albers, Eric Banks, Mark A. DePristo, Robert E. Handsaker, Gerton Lunter, Gabor T. Marth, Stephen T. Sherry, Gilean McVean, Richard Durbin, 1000 Genomes Project Analysis Group, The variant call format and VCFtools, Bioinformatics, Volume 27, Issue 15, 1 August 2011, Pages 2156–2158, https://doi.org/10.1093/bioinformatics/btr330

+ R:
R Core Team (2020). R: A language and environment for statistical computing. R Foundation for Statistical Computing, Vienna, Austria. URL https://www.R-project.org/.

You need to have installed both vcftools and R in your OS for DiagnoSNPs.sh to work. If you use this script you must cite on your paper both vcftools and R software.
" 1>&2
exit 1
}

while getopts ":v:a:b:o:p:" i; do
    case "${i}" in
        v)
            v=${OPTARG}
            ;;
        a)
            a=${OPTARG}
            ;;
        b)
            b=${OPTARG}
            ;;
        o)
            o=${OPTARG}
            ;;
        p)
            p=${OPTARG}
            ;;      
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${v}" ] || [ -z "${a}" ] || [ -z "${b}" ] || [ -z "${o}" ]; then
    usage
fi

echo "Running DiagnoSNPs$version with the following input files"
echo "v = ${v}"
echo "a = ${a}"
echo "b = ${b}"
echo "o = ${o}"
echo "p = ${p}"
echo ""

echo "01.- Creating list of SNPs fixed for one allele for each group"
echo "Looking for fixed SNPs in ${a}"
vcftools --vcf ${v} --keep ${a} --max-maf 0 --hardy --out tmp_a
echo "Looking for fixed SNPs in ${b}"
vcftools --vcf ${v} --keep ${b} --max-maf 0 --hardy --out tmp_b
rm tmp_a.log tmp_b.log
echo ""

echo "02.- Looking for SNPs that are fixed in both populations"
Comparing_fixed_SNPs.R
# Small format change
tr "," "\t" < shared.txt > shared_snps.txt
rm shared.txt tmp_a.hwe tmp_b.hwe
echo ""

echo "03.- HardyWeinberg testing fixed SNPs"
vcftools --vcf ${v} --keep ${a} --keep ${b} --positions shared_snps.txt --hardy --out HWe_snps
rm shared_snps.txt HWe_snps.log
echo ""

echo "04.- Deleting biallelic SNPs fixed for the same allele in both groups"
Deleting_same_fixed_allele.R
# Another small format change
tr "," "\t" < diagnostic_snps.txt > ${o}/${p}.DiagnoSNPs.txt
rm HWe_snps.hwe diagnostic_snps.txt

echo "Finished running DiagnoSNPs.sh. Your list of alternatively fixed SNPs is ${o}/${p}.DiagnoSNPs.txt"
