Your submission should include a readme, a makefile, and a design file.

Perform a differential expression analysis of a count matrix.

Take a count matrix, this count matrix may be one generated in a previous assignment or one that simulated.

Use method to identify genes/transcripts that show differential expression.

Draw a PCA plot and a heatmap for these genes.

Discuss the results. How many genes have you found. What kind of expression levels can you observe. How reliable does your data seem?

> [!IMPORTANT]  
> Please install *Bioinformatics Toolbox* first by running `bio code` within the same folder which contains the Makefile. Additionally, for this weekly assignment, you also need to set up the *stats* environment. Please look at this [link](https://www.biostarhandbook.com/appbio/methods/stats/).

> [!IMPORTANT]
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into make -f Makefile.mk all

## An RNA-Seq analysis from RNA-seq count simulations.

### 1. The initial differential expression analysis from realistic data:

- My initial differential expression analysis was of a count matrix generated from realistic dataset. Below are the detail information:

BioProject Accession number: [PRJNA1193813](https://www.ncbi.nlm.nih.gov/bioproject/PRJNA1193813)

Species: Staphylococcus aureus

Accession number: GCF_000013425.1

File design.csv: 

```
sample,group
SRR31594261,A
SRR31594260,A
SRR31594259,A
SRR31594258,B
SRR31594257,B
SRR31594256,B
```
Below is a part of the generated count matrix:

![Image1](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week14/Images/Image1.png)

- To conduct the differential expression analysis by DESeq2, I run the below command line:

Command: 

```
Rscript src/r/deseq2.r -d design.csv -c res/counts-hisat.csv
```

Results:

```
# Running DESeq2 
# Design: design.csv 
# Counts: res/counts-hisat.csv 
# Sample column: sample 
# Factor column: group 
# Group A has 3 samples.
# Group B has 3 samples.
# Initializing  DESeq2 tibble dplyr tools ... done
converting counts to integer mode
estimating size factors
estimating dispersions
gene-wise dispersion estimates
mean-dispersion relationship
final dispersion estimates
fitting model and testing
# Input: 77 rows
# Removed: 70 rows
# Fitted: 7 rows
# Significant PVal: 0 ( 0 %)
# Significant FDRs: 0 ( 0 %)
# Results: deseq2.csv
```

- Perhaps due to the nature of this project, results contain a significant PVal and FDRs of 0%. Thus, I conducted the second RNA-seq analysis using simulated counts. The design file and makefile in this assignment are about the differential expression analysis using simulated counts.

### 2. Instruction of the Makefile

**a. To see the available targets:**

Run the below commands:

```
make
```

Results:

```
# RNA-Seq analysis from count simulations
#
# Design file = design.csv
# Simulated count file = counts.csv
#
# make simulate      # create the design and simulated count files.
# make analysis      # conduct differential expression based on design.csv and counts.csv.
# make plot          # generate PCA plot and heatmap.
# make all           # proceed all the targets.
# make clean         # clean all files after every run.
```

**b. To run desired targets:**

Run the command `make [target]`, for example:

```
make simulate
```

Results:

```
mkdir -p files
Rscript src/r/simulate_counts.r -n 40000 -r 4 -d files/design.csv -o files/counts.csv
# Initializing  PROPER ... done
# PROspective Power Evaluation for RNAseq 
# Error level: 1 (bottomly)
# All genes: 40000 
# Genes with data: 9349 
# Genes that changed: 2000 
# Changes we can detect: 507 
# Replicates: 4 
# Design: files/design.csv 
# Counts: files/counts.csv
```

### 3. PCA plot and heatmap generation:

Command line utilized:

```
src/r/plot_pca.r -d files/design.csv -c files/deseq2.csv -o plots/pca.pdf
src/r/plot_heatmap.r -d files/design.csv -c files/deseq2.csv -o plots/heatmap.pdf
```

The image of PCA plot:

![Image2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week14/Images/Image2.png)

The image of heatmap:

![Image3](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week14/Images/Image3.png)


***Discussion:***

- DESeq2 was employed for the differential expression analysis.

- 
