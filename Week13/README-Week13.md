> [!IMPORTANT]  
> Please install *Bioinformatics Toolbox* first by running `bio code`. Additionally, for this weekly assignment, you also need to set up the *stats* environment. Please look at this [link](https://www.biostarhandbook.com/appbio/methods/stats/).

> [!IMPORTANT]
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into make -f Makefile.mk all

## An automatic RNA-Seq count matrix generation pipeline

### 1. Variable settings:

BioProject Accession number: [PRJEB22173](https://www.ncbi.nlm.nih.gov/bioproject/PRJEB22173)

Species: Rabies lyssavirus

```
# Accession number of the Lyssavirus rabies genome.
ACC=GCF_000859625.1

# The reference file.
REF=refs/rabies.fa

# The GTF file.
GTF=refs/rabies.gtf

# The design file.
DESIGN = design.csv

# The number of reads to get.
N=100000

# File to save downloaded reads
LINK=reads/

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The counts in tab delimited format.
COUNTS_TXT = res/counts-hisat.txt

# Final combinted counts in CSV format.
COUNTS_CSV = res/counts-hisat.csv

# Flags passed to parallel.
FLAGS = --eta --lb --header : --colsep ,
```

### 2. Design file creation

**a. Method 1:** After identified your BioProject Accession number, run the command line `bio search [project number] -H --csv > design.csv` to collect all desired SRR numbers.

For example:

```
bio search PRJEB22173 -H --csv > design.csv
```

**b. Method 2:** An alternative way is to generate your own design file with interested SRA numbers including at least two columns: sample (as `run_accession`) and group (as `sample_alias`). Illustration as below:

```
sample,group
ERR2097149,RV2980
ERR2097150,RV2981
ERR2097160,Sub 5792
ERR2097161,Sub5790
```

**c. Method 3:** You just neeed to simply run the below command to generate a design file related to this Makefile.

```
make design
```

### 3. Instruction of the Makefile

**a. To see the available targets:**

Run the below commands:

```
make
```

Results:

```
# RNA-Seq count matrix generation
#
# ACC=GCF_000859625.1
# REF=refs/rabies.fa
# GTF=refs/rabies.gtf
# DESIGN=design.csv
#
# make design      # create the design.csv file.
# make index       # download the reference data and generate the HISAT2 index.
# make data        # download the sequencing data from design file.
# make align       # run the alignment with SRA from design file by HISAT2.
# make count       # generate the count matrix in CSV format.
# make clean       # clean all files after every run.
# make all         # proceed all the targets.
```

**b. To run desired targets:**

Run the command `make [target]`, for example:

```
make data
```

**c. To run for other ACC and SRR numbers:**

Change the ACC, REF, GTF, and DESIGN links to the desired biodata, and run the targets. Remember to create new design file for your new run. For example:

```
make all ACC=GCF_000063585.1 REF=refs/botulinum.fa GTF=refs/botulinum.gtf DESIGN=design.csv
```

**d. To conduct an RNA-Seq count matrix generation pipeline for several SRAs from design.csv:**

Using GNU parallel, run the command below to see how many SRR numbers will be run: 

```
cat design.csv | head -10 | \
    parallel --dry-run --lb -j 4 --colsep , --header : \
    make all SRR={sample} SAMPLE={group}
```

Results:

```
make all SRR=ERR2097149 SAMPLE=RV2980
make all SRR=ERR2097150 SAMPLE=RV2981
make all SRR=ERR2097160 SAMPLE='Sub 5792'
make all SRR=ERR2097161 SAMPLE=Sub5790
```

Run the command below to execute the automatic RNA-Seq count matrix generation pipeline: 

```
cat design.csv | head -10 | \
    parallel --lb -j 4 --colsep , --header : \
    make all SRR={sample} SAMPLE={group}
```

***In this Makefile, since I already included the automatic pipeline, you just need to run this command:***

```
make all
```

> [!TIP]  
> Please run `make clean` after every running session. If you are switching from one SRA number to multiple SRAs of one bioproject or vice versa, please run `make clean` , otherwise, error may happen.

### 4. Discussion of the count matrix generated:

Firstly, to check if the alignment are from RNA-seq data, we are required to utilize IGV. Open the IGV, load the genome refs/rabies.fa file and the GTF file refs/rabies.gtf. Then load two files, including the bam file and bw file for every SRR number. For example, I load two SRR numbers as below.

Image from the bam/ERR2097149.bam and the bam/ERR2097149.bw files:

![Image2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week13/Images/Image2.png)

Image from the bam/ERR2097150.bam and the bam/ERR2097150.bw files:

![Image3](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week13/Images/Image3.png)


To see the statistics of the counts-hisat.csv file, run the below command line:

```
cat res/counts-hisat.csv
```

Result information:

```
name,gene,ERR2097149,ERR2097150,ERR2097160,ERR2097161
RABVgp1,RABVgp1,20,416,1663,192
RABVgp2,RABVgp2,16,269,821,137
RABVgp3,RABVgp3,5,220,562,101
RABVgp4,RABVgp4,20,416,962,179
RABVgp5,RABVgp5,109,2652,7257,891
```

Or if you open the counts-hisat.csv file:

![Image4](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week13/Images/Image4.png)

***Discussion:***

Lyssavirus rabies genome (i.e., GCF_000859625.1) is a single-stranded RNA genome organized into five main genes: RABVgp1, RABVgp2, RABVgp3, RABVgp4, RABVgp5. These genes encode the essential structural and functional proteins for the virus. 

From the count matrix, we can see that all genes have significantly higher counts in ERR2097160 while lower counts in ERR2097149. Since these are virus samples from different red foxes, it indicates the severe/activity of rabies viruses in each subject.

RABVgp5 has the highest expression levels across all samples, especially in ERR2097160, suggesting its high active function compared to other genes. This information makes sense since RABVgp5 encodes for the glycoprotein (G) that proceed the viral entry into host cells by binding to nicotinic acetylcholine receptors on the subject's cell surface.

Additionally, genes RABVgp1 and RABVgp4 have relatively similar patterns, especially in ERR2097150 and ERR2097149.
