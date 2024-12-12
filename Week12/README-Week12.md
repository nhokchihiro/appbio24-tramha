> [!IMPORTANT]  
> Please install Bioinformatics Toolbox first by running `bio code`.

> [!IMPORTANT]
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into make -f Makefile.mk all

> [!WARNING]  
> This Makefile will run only with paired-end sequencing reads. If your SRA downloaded reads are single end, please modify the Makefile first.

## An automatic VCF calling pipeline

### 1. Variable settings:

BioProject Accession number: [PRJNA832888](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA832888/)

Species: Rabies lyssavirus

```
# Accession number of the Lyssavirus rabies genome.
ACC=GCF_000859625.1

# The reference file.
REF=refs/rabies.fa

# The GFF file.
GFF=refs/rabies.gff

# The sequencing read accession number.
SRR=SRR18960173

# The number of reads to get
N=100000

# The name of the sample 
SAMPLE=Rab-7-4

# The path to SRA reads
R1=reads/${SAMPLE}_1.fastq
R2=reads/${SAMPLE}_2.fastq

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The resulting variant VCF file (compressed!).
VCF=vcf/${SAMPLE}.vcf.gz
```

### 2. Design file creation

After identified your BioProject Accession number, run the command line `bio search [project number] -H --csv > design.csv` to collect all desired SRR numbers.

For example:

```
bio search PRJNA832888 -H --csv > design.csv
```

An alternative way is to generate your own design file with interested SRA numbers including at least two columns: `run_accession` and `sample_alias`. Illustration as below:

```
run_accession,sample_alias
SRR18960170,Rab-35-2-4
SRR18960172,Rab-8-4
SRR18960173,Rab-7-4
SRR18960174,Rab-1-4
SRR18960171,Rab-35-1-4
```

### 3. Instruction of the Makefile

**a. To see the available targets:**

Run one of the below commands:

```
make
```

Results:

```
# SNP call demonstration
#
# ACC=GCF_000859625.1
# SRR=SRR18960173
# SAMPLE=Rab-7-4
# BAM=bam/Rab-7-4.bam
# VCF=vcf/Rab-7-4.vcf.gz
#
# make bam          # create the BAM alignment file.
# make vcf          # call the SNPs and produce VCF file.
# make merge        # merge all VCF files together if running the automatic pipeline.
# make all          # run all the steps.
# make clean        # clean the file after every run.
```

**b. To run desired targets:**

Run the command `make [target]`, for example:

```
make vcf
```

**c. To run for other ACC and SRR numbers:**

Change the ACC, SRR, SAMPLE, REF and GFF links to the desired biodata, and run the targets. For example:

```
make all ACC=GCF_000063585.1 SRR=SRR28257549 SAMPLE=BMH-2021 REF=refs/botulinum.fa GFF=refs/botulinum.gff
```

**d. To conduct an automatic VCF calling pipeline for several SRAs from design.csv:**

Using GNU parallel, run the command below to see how many SRR numbers will be run: 

```
cat design.csv | head -10 | \
    parallel --dry-run --lb -j 4 --colsep , --header : \
    make all SRR={run_accession} SAMPLE={sample_alias}
```

Results:

```
make all SRR=SRR18960171 SAMPLE=Rab-35-1-4
make all SRR=SRR18960170 SAMPLE=Rab-35-2-4
make all SRR=SRR18960172 SAMPLE=Rab-8-4
make all SRR=SRR18960173 SAMPLE=Rab-7-4
make all SRR=SRR18960174 SAMPLE=Rab-1-4
```

Run the command below to execute the automatic VCF calling pipeline: 

```
cat design.csv | head -10 | \
    parallel --lb -j 4 --colsep , --header : \
    make all SRR={run_accession} SAMPLE={library_name}
```

> [!TIP]  
> Please run `make clean` after every running session. If you are switching from one SRA number to multiple SRAs of one bioproject or vice versa, please run `make clean` , otherwise, error may happen.

### 4. Discussion of the VCF file:

To see the statistics of VCF file, run the command line `bcftools stats [VCF file] > stat.txt`:

For example:

```
bcftools stats merged.vcf.gz > stat.txt
```

Some information of statistics for merged VCF file:

```
# SN	[2]id	[3]key	[4]value
SN	0	number of samples:	5
SN	0	number of records:	1012
SN	0	number of no-ALTs:	0
SN	0	number of SNPs:	1011
SN	0	number of MNPs:	0
SN	0	number of indels:	1
SN	0	number of others:	0
SN	0	number of multiallelic sites:	7
SN	0	number of multiallelic SNP sites:	7
```

Thus, it suggests that there are 5 samples variants of this alignment. Most of them are SNPs, and there is one indels.

Since these are the genome sequencing of the rabies virus in the territory of the Republic of Kazakhstan within the same collection duration, these virus samples exhibit the high degree of similarity in their VCF. However, there are still some rare variants which only appears in some samples. For example, the variant at position 10,031 alter G to A only appears in sample SRR18960172 (Image 4).

![Image2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image2.png)

![Image3](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image3.png)

![Image4](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week12/Images/Image4.png)

