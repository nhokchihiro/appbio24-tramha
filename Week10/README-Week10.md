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
# Accession number of the ebola genome.
ACC=AF086833

# The reference file.
REF=refs/zaire.fa

# The GFF file.
GFF=refs/zaire.gff

# The sequencing read accession number.
SRR=SRR1553606

# The number of reads to get
N=100000

# The name of the sample (see: bio search SRR1553425)
SAMPLE=NM042

# The path to read 1
R1=reads/${SAMPLE}_1.fastq

# The path to read 2
R2=reads/${SAMPLE}_2.fastq

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The resulting variant VCF file (compressed!).
VCF=vcf/${SAMPLE}.vcf.gz
```

### 2. Instruction of the Makefile

**a. To see the available targets:**

Run one of the below commands:

```
make
```

Results:

```
# SNP call demonstration
#
# ACC=AF086833
# SRR=SRR1553606
# SAMPLE=NM042
# BAM=bam/NM042.bam
# VCF=vcf/NM042.vcf.gz
#
# make bam          # create the BAM alignment file.
# make vcf          # call the SNPs and produce VCF file.
# make count        # counting variants in the resulting VCF file.
# make all          # run all the steps.
```

**b. To run desired targets:**

Run the command `make [target]`, for example:

```
make vcf
```

Results:

```
make -f src/run/bcftools.mk REF=refs/zaire.fa BAM=bam/NM042.bam VCF=vcf/NM042.vcf.gz run
echo "Variants is completely recorded in VCF file."
-rw-r--r--  1 hpbichtram  staff    17K Nov  8 04:41 vcf/NM042.vcf.gz
Variants is completely recorded in VCF file.
```

**c. To run for other ACC and SRR numbers:**

Change the ACC, SRR, SAMPLE, REF and GFF links to the desired biodata, and run the targets. For example:

```
make all ACC=GCF_000063585.1 SRR=SRR28257549 SAMPLE=BMH-2021 REF=refs/botulinum.fa GFF=refs/botulinum.gff
```

**d. To run several SRRs and generate the VCF file for one specific bioproject:**

d.1/ To get several SRRs of one specific bioproject:

```
bio search [BioProject number] -H --csv | csvtk cut -f run_accession,sample_alias | head
```

For example:

```
bio search PRJNA257197 -H --csv | csvtk cut -f run_accession,sample_alias | head
```

Results:

```
run_accession,sample_alias
SRR1553421,EM104
SRR1553422,EM104
SRR1553429,EM112
SRR1553430,EM112
SRR1553433,EM115
SRR1553434,EM115
SRR1553435,EM119
SRR1553436,EM119
SRR1553437,EM120
```

d.2/ Continually process all desired samples:

```
make SRR=SRR1972663 SAMPLE=G3966.1 all
make SRR=SRR1972670 SAMPLE=G3997.1 all
make SRR=SRR1972720 SAMPLE=G4188.1 all
```

d.3/ Generate one final VCF file from all above commands:

```
bcftools merge -0 vcf/*.vcf.gz -O z > vcf/final.vcf.gz
bcftools index vcf/final.vcf.gz
bcftools stats vcf/final.vcf.gz > final_stat.txt
```

### 3. Some information and Statistics of the VCF file:

Run the below command:

```
make count
```

Results:

```
Count all the variant lines in the VCF file:
     565
Count all the variants with QUAL >30:
     565
Generating statistics for VCF file completely at stat.txt!
```

Some information of statistics for VCF file:

```
SN	0	number of samples:	1
SN	0	number of records:	565
SN	0	number of no-ALTs:	0
SN	0	number of SNPs:	565
SN	0	number of MNPs:	0
SN	0	number of indels:	0
SN	0	number of others:	0
SN	0	number of multiallelic sites:	0
SN	0	number of multiallelic SNP sites:	0
```

Thus, it suggests that all variants of this alignment are SNPs, there is no indels and MNPs. All SNPs have quality score > 30.

### 4. Verify the variant caller's results by looking at a few example the alignments in the BAM file.

Find examples where the variant caller did not work as expected: false positives, false negatives, etc.


![Image1](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week08/Images/Image1.png)

