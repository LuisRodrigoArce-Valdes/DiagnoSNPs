## DiagnoSNPs
*By Luis Rodrigo Arce Valdés (2021).*

This small tool is used to identify from a typical vcf file SNPs that are fixed with opposite alleles between two groups of samples. These markers then, can be used as diagnostic for those two groups. For example, these kind of markers are widely used in hibrization studies to identify species specific alleles and then quantify the degree of hibridization and introgression in hybrid samples.

### Instalation
#### Dependencies
This program works on any UNIX command line terminal. However, you need first to install [vcftools](https://vcftools.github.io/index.html) and [R](https://www.r-project.org/) software on your computer. For vcftools I highly suggest you to install it via conda. You might want to install [miniconda](https://docs.conda.io/en/latest/miniconda.html), the minimal version of conda and then install vcftools via:
```
conda install -c bioconda vcftools
```
Install the latest version of R from the terminal using:
```
sudo apt install r-base
```

#### DiagnoSNPs
To install DiagnoSNPs simply download this whole repository using the green code button and then clicking on **Download ZIP**.

![Download](Screenshot.png)

Alternatively you can clone this reposotiry at a specific directory using:
```
git clone git@github.com:LuisRodrigoArce-Valdes/DiagnoSNPs.git
```
*You need to have installed git on your computer*



### Running the program
To run DiagnoSNPs place yourself inside