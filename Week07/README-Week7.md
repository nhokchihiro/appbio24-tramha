### 1. Variable settings:

```
# Accession number
ACC=GCF_000002985.6

# The GFF file name.
GFF=ncbi_dataset/data/${ACC}/GCF_000002985.6_WBcel235_genomic.fna

# The name of FASTQ link
GENOME=elegans.fa

# The number of reads
N=3342900

# Lengh of the reads
L=150

# The files to write the reads to
R1=reads/wgsim_read1.fq
R2=reads/wgsim_read2.fq

# Link to the new FASTQ file
LINK2=reads/

# Number of reads to sample
N2=10000

# SRR number
SRR=SRR1553606

# The output read names
R3=reads2/${SRR}_1.fastq
R4=reads2/${SRR}_2.fastq

# Trimmed read names
T1=reads2/${SRR}_1.trimmed.fastq
T2=reads2/${SRR}_2.trimmed.fastq

# The reads directory
RDIR=reads2

# The reports directory
PDIR1=report_before_fastp
PDIR2=report_after_fastp
```

### 2. Description of the Makefile:

There are two parts in Makefile:
  - One is to download the genome and simulate reads (Week 05), including targets: info, genome, simulate.
  - One is to obtain and trim reads for a realistic dataset (Week 06), including targets: download, trim.

All including targets and descriptions:

```
# Print all possible targets
usage:
	@echo "Here are all targets you can run"
	@echo "make info          # summary information on the genome"
	@echo "make genome        # download the genome file and detail information"
	@echo "make simulate      # simulate FASTQ output"
	@echo "make download      # download reads from SRA"
	@echo "make trim          # trim the reads"
	@echo "make clean         # remove the downloaded files"
	@echo "make all_simulate  # only run the targets related to simulating FASTQ output"
	@echo "make all_trim      # only run the targets related to trimming the reads"
	@echo "make all           # run all the targets"
```

### 3. Instruction:

To execute desired targets, simply call the command as **make [targets]**.

**a. For example, to download the genome file:**

```
make genome
```

Result: 

```
...
Size of the FASTQ file is:
lrwxr-xr-x  1 hpbichtram  staff    70B Oct 13 22:08 elegans.fa -> ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
Total size of the genome is at column sum_len:
file        format  type  num_seqs      sum_len  min_len       avg_len     max_len
elegans.fa  FASTA   DNA          7  100,286,401   13,794  14,326,628.7  20,924,180
Total number of chromosomes is:
7
ID and length of each chromosome are:
NC_003279.8 Caenorhabditis elegans chromosome I	15072434
NC_003280.10 Caenorhabditis elegans chromosome II	15279421
NC_003281.10 Caenorhabditis elegans chromosome III	13783801
NC_003282.8 Caenorhabditis elegans chromosome IV	17493829
NC_003283.11 Caenorhabditis elegans chromosome V	20924180
NC_003284.9 Caenorhabditis elegans chromosome X	17718942
NC_001328.1 Caenorhabditis elegans mitochondrion, complete genome	13794
```

**b. Or to remove all downloaded files after the above command:**

```
make clean
```

Results:

```
rm -rf ncbi_dataset/
rm -f md5sum.txt ncbi_dataset.zip fastp.html fastp.json README.md elegans.fa
rm -rf reads2/
```

**c. You can also combine two targets together:**

```
make download trim
```

It will run both targets download and trim to generate fastqc reports upon downloading and trimming data, and put all these files in 2 folders report_before_fastp and report_after_fastp.

![Trim](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week07/Images/trim.png)

**d. Summary commands:**

There are three summary commands if you would like to execute the whole tasks, not each individual target.

```
make all_simulate  # only run the targets related to simulating FASTQ output
```

```
make all_trim      # only run the targets related to trimming the reads
```

```
make all           # run all the targets
```

This is the result folder after executing ***make all***. "Reads" contains the simulated reads from downloaded genome. And the fastqc reports in 2 folders report_before_fastp and report_after_fastp, respectively.

![Results](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week07/Images/Results.png)
