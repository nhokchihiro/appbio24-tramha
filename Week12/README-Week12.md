> [!IMPORTANT]  
> Please install Bioinformatics Toolbox first by running `bio code`.

> [!IMPORTANT]
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into make -f Makefile.mk all

> [!WARNING]  
> This Makefile will run only with paired-end sequencing reads. If your SRA downloaded reads are single end, please modify the Makefile first.

## Variant calling in a BAM file

### 1. Variable settings:

BioProject Accession number: [PRJNA257197](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA257197/)

Species: Zaire ebolavirus

```
# Accession number of the Zaire ebolavirus genome.
ACC=GCA_000848505.1

# The reference file.
REF=refs/zaire.fa

# The GFF file.
GFF=refs/zaire.gff

# The sequencing read accession number.
SRR=SRR1553606

# The number of reads to get
N=100000

# The name of the sample 
SAMPLE=NM042

# The path to SRA reads
R1=reads/${SAMPLE}_1.fastq
R2=reads/${SAMPLE}_2.fastq

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The resulting variant VCF file (compressed!).
VCF=vcf/${SAMPLE}.vcf.gz
```

### 2. Instruction of the Makefile:

**a. To see the available targets:**

Run one of the below commands:

```
make
```

Results:

```
# SNP call demonstration
#
# ACC=GCA_000848505.1
# SRR=SRR1553606
# SAMPLE=NM042
# BAM=bam/NM042.bam
# VCF=vcf/NM042.vcf.gz
#
# make bam          # create the BAM alignment file.
# make vcf          # call the SNPs and produce VCF file.
# make variants     # variant effect prediction.
# make all          # run all the steps.
# make clean        # clean the file after every run.
```

**b. To run desired targets:**

Run the command `make [target]`, for example:

```
make variants
```

Results:

```
# Build the custom database
make -f src/run/snpeff.mk GFF=refs/zaire.gff REF=refs/zaire.fa build
# Run snpEff using the custom database
make -f src/run/snpeff.mk GFF=refs/zaire.gff REF=refs/zaire.fa VCF=vcf/NM042.vcf.gz run
-rw-r--r--  1 hpbichtram  staff   6.9K Nov 17 22:26 idx/snpEff/genome/snpEffectPredictor.bin
-rw-r--r--  1 hpbichtram  staff    49K Nov 17 22:26 results/snpeff.vcf.gz
-rw-r--r--  1 hpbichtram  staff   291K Nov 17 22:26 results/snpeff.html
-rw-r--r--  1 hpbichtram  staff    26K Nov 17 22:26 results/snpeff.csv
```

**c. To run for other ACC and SRR numbers:**

Run the below targets:

```
make all ACC=GCF_000063585.1 SRR=SRR28257549 SAMPLE=BMH-2021 REF=refs/botulinum.fa GFF=refs/botulinum.gff
```

### 3. Variant effect prediction:

To utilize snpEff for the variant effect prediction, we run this command:

```
make variants
```

Four new variants prediction files would be generated in `results` folder, including vcf and html files.


In our practice, some variant effects resulting from the `results/snpeff.html` are depected as below:

![Image1](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image1.png)

- All variants in this sample are **SNPs**. There are no indels, MNPs, or even inversion modification in this sample. The **silent mutation** is the highest percentage functional class.

![Image2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image2.png)

- Most of these variants are located at **downstream and upstream regions**. Only a few variants (13.8%) are at exon coding regions. 

![Image3](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image3.png)

![Image4](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image4.png)

- Above are the **codon changes table** and **amino acids changes table**. The codons/amino acids at rows are modified by the codons/amino acids at columns. From these table, we can identified some major SNPs changes, such as:
      + There are 4 times codon AAT changed into AGT, which contribute to the replacing of amino acid Asn to Ser (missense mutation).
      + There is 1 time codon CAG changed into TAG, which leading to the modification of amino acid Gln to stop codon (nonsense mutation).
      + There are 8 times codon ACT changed into ACC, which keeping codon Thr still as the same (silent mutation).

> [!TIPS]  
> We can utilize this command line for indicating the effect of codon changes into amino acid changes:
> `bio fasta [reference codon][changed codon] -translate`.

For example: 

```
bio fasta AATAGT -translate
```

Results:

```
>seq1
NS
```

That means the modification of codon AAT to AGT leads to the replace of amino acid Asn by Ser.
