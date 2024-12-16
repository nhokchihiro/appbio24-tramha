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
# Generate two groups of samples, each has 4 duplicates and 40,000 genes.
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

- While running `make analysis`, results showed as below:

```
# Input: 40000 rows
# Removed: 26990 rows
# Fitted: 13010 rows
# Significant PVal: 864 ( 6.6 %)
# Significant FDRs: 408 ( 3.1 %)
# Results: files/deseq2.csv

# Tool: evaluate_results.r 
# 507 in files/counts.csv 
# 408 in files/deseq2.csv 
# 350 found in both
# 157 found only in files/counts.csv 
# 58 found only in files/deseq2.csv 
# Summary: files/summary.csv
```

- Results indicated that there were 40,000 genes were generated during the RNA-seq count simulation. However, 26,990 genes were removed, perhaps due to low differential expression. Only 13,010 genes were included after the filtering.
Among those genes, there were 864 genes (6.6%) had a p-value below the significance threshold, indicating these genes are significantly differentially expressed between two groups of samples. Other 408 genes (3.1%) have an significant adjusted p-value (FDR), indicating that after correcting for multiple testing, these genes remain crucial.

- There were 507 genes in the count matrix and 408 genes found significantly differentially expressed after DESeq2 analysis.

- Comparing between two files counts.csv and deseq2.csv, we can see that there was an overlap of 305 genes found in both files. There were 157 false negatives, which indicate genes were differentially expressed but deseq2 did not find. 58 genes were expected by deseq2 but were not.

- PCA plot presented a clear separation between two group, suggesting that the simulated experimental condition has a strong effect on gene expression. Both upregulated and downregulated genes could be seen through the heatmap.

- This simulated data appears to be reliable by looking at the the overlap between the count matrix and DESeq2 results. 
