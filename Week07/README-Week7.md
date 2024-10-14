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
  - One is to download the genome and simulate reads (Week 05).
  - One is to obtain and trim reads for a realistic dataset (Week 06).

All including targets and descriptions:

```
# Print all possible targets
usage:
	@echo "Here are all targets you can run"
	@echo "make info          # summary information on the genome"
	@echo "make genome        # download the genome file"
	@echo "make detail        # getting detail information from the genome"
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

For example, to download the genome file:

```
make genome
```

Result: 

```
datasets download genome accession GCF_000002985.6 #--include gff3,gtf,genome
unzip -n ncbi_dataset.zip
ln -sf ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna elegans.fa 
ls -lh ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
-rw-------  1 hpbichtram  staff    97M Oct 13 21:55 ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
```

Or to remove all downloaded files after the above command:

```
make clean
```

Results:

```
rm -rf ncbi_dataset/
rm -f md5sum.txt ncbi_dataset.zip fastp.html fastp.json README.md elegans.fa
rm -rf reads2/
```

You can also combine two targets together:

```
make download trim
```

It will run both targets download and trim to generate fastqc reports upon downloading and trimming data, and put all these files in 2 folders report_before_fastp and report_after_fastp.

![Trim](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week07/Images/trim.png)

The report should explain how the makefile works and how to run it to achieve the various tasks.

Have your makefile generate fastqc reports upon downloading and trimming data.

```
make all
```



![Results](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week07/Images/Results.png)
