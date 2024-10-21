> [!IMPORTANT]  
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into ```make -f Makefile.mk all```.

> [!WARNING]  
> This Makefile will run only with paired-end sequencing reads. If your SRA downloaded reads are single end, please modify the Makefile first.

## Sequencing alignments from simulated reads and SRA downloaded reads to a reference genome

### 1. Variable settings:

```
# NCBI Genome accession number
ACC=GCF_000848505.1
ID=ViralProj14703

# Reference genome
REF=refs/zaire.fa

# Simulated reads
R1=reads/simulated_read1.fastq
R2=reads/simulated_read2.fastq

# The number of simulated reads
N=3342900

# Lengh of the simulated reads
L=150

# SRR number
SRR=SRR1553606

# Downloaded SRA reads
R3=reads2/${SRR}_1.fastq
R4=reads2/${SRR}_2.fastq

# How many reads to download
N2=100000

# File to save simulated reads
LINK1=reads/

# File to save downloaded reads
LINK2=reads2/

# BAM file
BAM1=bam/simulate.bam
BAM2=bam/download.bam
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
make simulate      # simulate FASTQ output
make fastq         # download reads from SRA, please put the SRR of paired-end sequencing
make index         # index the reference genome
make align         # align the reads and convert to BAM
make stats         # generate alignment statistics
make clean         # remove the generated files
make all_simulate  # only run the targets related to simulating FASTQ output
make all           # run all the targets
```

**b. To run desired targets:**

Simply call the command as ```make [targets]``` as instruction in the usage part.

For example:

```
make refs
```

Or, add *-n* to see what steps a target will go through:

```
make refs -n
```

Results:

```
# Create the reference directory
mkdir -p refs/
# Use datasets to download the genome.
datasets download genome accession GCF_000848505.1
# Unzip the genome, skip the README and md5sum files.
unzip -n ncbi_dataset.zip -x README.md md5sum.txt 
# Copy the genome to the reference file.
cp -f ncbi_dataset/data/GCF_000848505.1*/GCF_000848505.1*_genomic.fna refs/zaire.fa
```

**c. To run for other ACC and SRR numbers:**

Simply execute the desired targets relating by modifying all essential variables, including ACC, SRR, REF.

For example:

```
make all SRR=SRR30984978 ACC=GCF_000240185.1 REF=refs/klebs.fa
```

> [!TIP]
> You can change variable N (The number of simulated reads) and variable L (Lengh of the simulated reads) if wanted.

### 3. Visualize the resulting BAM files for your simulated reads and the reads downloaded from SRA.

Simulated reads: 

![Image1](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week08/Images/Image1.png)

![Image2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week08/Images/Image2.png)


SRA downloaded reads:

![Image3](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week08/Images/Image4.png)

![Image4](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week08/Images/Image3.png)

It seems that the reads in simulated data are more match to the reference genome, while the downloaded ones have lots of gaps among reads. The mutations appear in simulated data are also randomly, while those in the SRA data are similar in different reads, most likely due to the transformation of this virus strain over many years.

### 4. Generate alignment statistics for the reads from both sources, simulated and SRA.

Run the command below to generate alignment statistics, remember to run all other before commands first:

```
make stats
```

Results:

```
samtools flagstat bam/simulate.bam
samtools flagstat bam/download.bam
6685800 + 0 in total (QC-passed reads + QC-failed reads)
6685800 + 0 primary
0 + 0 secondary
0 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
6685800 + 0 mapped (100.00% : N/A)
6685800 + 0 primary mapped (100.00% : N/A)
6685800 + 0 paired in sequencing
3342900 + 0 read1
3342900 + 0 read2
6685780 + 0 properly paired (100.00% : N/A)
6685800 + 0 with itself and mate mapped
0 + 0 singletons (0.00% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
202827 + 0 in total (QC-passed reads + QC-failed reads)
200000 + 0 primary
0 + 0 secondary
2827 + 0 supplementary
0 + 0 duplicates
0 + 0 primary duplicates
82069 + 0 mapped (40.46% : N/A)
79242 + 0 primary mapped (39.62% : N/A)
200000 + 0 paired in sequencing
100000 + 0 read1
100000 + 0 read2
72164 + 0 properly paired (36.08% : N/A)
78814 + 0 with itself and mate mapped
428 + 0 singletons (0.21% : N/A)
0 + 0 with mate mapped to a different chr
0 + 0 with mate mapped to a different chr (mapQ>=5)
```

### 5. Briefly describe the differences between the two datasets.

**a. Information of the two datasets:** 

- Simulated reads were run from the dataset collected in 1976, sequence assembled in 2000:

[GCF_000848505.1](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000848505.1/) - Zaire ebolavirus genome assembly ViralProj14703.

- SRA downloaded reads were from the sample collected and assembled in	2014:
 
[SRR1553606](https://www.ncbi.nlm.nih.gov/sra/SRR1553606) - Zaire ebolavirus genome sequencing from 2014 outbreak in Sierra Leone.

**b. Differences between two datasets:**

- There are 6,685,800 reads in total for simulated reads, and all reads (100%) were mapped to the reference genome. Meanwhile, the SRA downloaded ones has 202,827 total reads, with 200,000 primary reads and 2,827 supplementary reads, and only 40.46% of the reads (82,069) were mapped to the reference genome (with 39.62% were primary mapped).
  
- For paired reads, in simulated data, 100% of them were properly paired. But for the SRA downloaded ones, only 36.08% (72,164) of them properly paired. About a third of the paired reads are aligned with both mates in the correct orientation and distance from each other.

- In the simulated reads from reference genome, there are no duplicate reads, no singletons, and no cross-chromosomal mapping. There are also no reads mapped to different chromosomes in the downloaded data, but there is a very small percentage of reads (0.21%) are singletons.

- In conclusion, the simulated data shows perfect alignment, with all reads mapped and properly paired. This is proper since these reads were simulated from the reference genome. However, the SRA downloaded real data shows much lower align rates and pairing accuracy. It can be explained by sequencing errors, sample quality issues, or a new evolved virus of the same species since this data is more than 30 years later.
