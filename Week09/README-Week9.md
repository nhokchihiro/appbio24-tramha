This assignment requires writing a Makefile and a markdown report. 

Use the Makefile developed for your previous assignment, which contains targets for creating a BAM file.

Use the BAM file generated using reads from the SRA.
In your report, show the commands and the answers for each of these questions:


> [!IMPORTANT]  
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into ```make -f Makefile.mk all```.

> [!WARNING]  
> This Makefile will run only with paired-end sequencing reads. If your SRA downloaded reads are single end, please modify the Makefile first.

## Makefile for filter and work with BAM file

### 1. Variable settings:

```
# NCBI Genome accession number
ACC=GCF_000848505.1
ID=ViralProj14703

# Reference genome
REF=refs/zaire.fa

# SRR number
SRR=SRR1553606

# Downloaded SRA reads
R1=reads/${SRR}_1.fastq
R2=reads/${SRR}_2.fastq

# How many reads to download
N=100000

# File to save downloaded reads
LINK=reads/

# BAM file
BAM1=bam/download.bam
BAM2=bam/filter.bam
```

### 2. Description and Instruction of the Makefile:

**a. To present all included targets and instructions:**

```
make usage
```

Results:

```
Here are all targets you can run
make info          # summary information on the genome
make refs          # download the genome file and detail information
make fastq         # download reads from SRA, please put the SRR of paired-end sequencing
make index         # index the reference genome
make align         # align the reads and convert to BAM
make count         # counting in a BAM file
make filter        # filter a BAM file
make stats         # generate alignment statistics
make clean         # remove the generated files
make all           # run all the targets
```

**b. To run desired targets:**

Simply call the command as ```make [targets]``` as instruction in the usage part.

For example:

```
make count
```

Or, add *-n* to see what steps a target will go through:

```
make count -n
```

Results:

```
# Count unmapped reads
echo "Counting unmapped reads..."
echo "Total unmapped reads did not align with the reference genome:"
samtools view -c -f 4 bam/download.bam
# Count primary, secondary, and supplementary alignments
echo "Counting alignments..."
echo "Total primary alignments in the BAM file:"
samtools view -c -F 256 -F 2048 bam/download.bam
echo "Total secondary alignments in the BAM file:"
samtools view -c -f 256 bam/download.bam
echo "Total supplementary alignments in the BAM file:"
samtools view -c -f 2048 bam/download.bam
# Count properly paired alignments on the reverse strand
echo "Total properly paired alignments on the reverse strand:"
samtools view -c -f 1 -f 2 -f 16 -f 64 bam/download.bam
```

**c. To run for other ACC and SRR numbers:**

Simply execute the desired targets relating by modifying all essential variables, including ACC, SRR, REF.

For example:

```
make all SRR=SRR30984978 ACC=GCF_000240185.1 REF=refs/klebs.fa
```

> [!TIP]
> You can change variable N (The number of simulated reads) and variable L (Lengh of the simulated reads) if wanted.

### 3. To count alignments in BAM file:

Run this command to count all the essential alignments in BAM file:

```
make count
```

Results:

```
Counting unmapped reads...
Total unmapped reads did not align with the reference genome:
120758
Counting alignments...
Total primary alignments in the BAM file:
200000
Total secondary alignments in the BAM file:
0
Total supplementary alignments in the BAM file:
2827
Total properly paired alignments on the reverse strand:
18183
```

Break down each command in "count" target:

**a. How many reads did not align with the reference genome?**

```
@echo "Total unmapped reads did not align with the reference genome:"
samtools view -c -f 4 $(BAM1) #keep require flag 4 UNMAP
```

Results:

```
Total unmapped reads did not align with the reference genome:
120758
```

**b. How many primary, secondary, and supplementary alignments are in the BAM file?**

```
@echo "Total primary alignments in the BAM file:"
samtools view -c -F 256 -F 2048 $(BAM1) #
@echo "Total secondary alignments in the BAM file:"
samtools view -c -f 256 $(BAM1)
@echo "Total supplementary alignments in the BAM file:"
samtools view -c -f 2048 $(BAM1)
```

Results:

```
Total primary alignments in the BAM file:
200000
Total secondary alignments in the BAM file:
0
Total supplementary alignments in the BAM file:
2827
```

**c. How many properly-paired alignments on the reverse strand are formed by reads contained in the first pair?**

```
@echo "Total properly paired alignments on the reverse strand:"
samtools view -c -f 1 -f 2 -f 16 -f 64 $(BAM1) view -c -f 4 $(BAM1) #keep require flag 4 UNMAP
```

Results:

```
Total properly paired alignments on the reverse strand:
18183
```

### 4. Make a new BAM file:

that contains only the properly paired primary alignments with a mapping quality of over 10
```
make filter
```

### 5. Compare the flagstats for your original and your filtered BAM file:

```
make stats
```

Results:

```

```

https://broadinstitute.github.io/picard/explain-flags.html
