Species: [Caenorhabditis elegans](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/6239/)

RefSeq:  GCF_000002985.6

Variable settings:

```
# Species RefSeq numnber
GCF="GCF_000002985.6"

# The name of FASTQ link
GENOME="elegans.fa"

#Link to the main file
LINK=ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna

# The number of reads
N=3342900

# Lengh of the reads
L=150

# The files to write the reads to
R1=reads/wgsim_read1.fq
R2=reads/wgsim_read2.fq

# Link to the new FASTQ file
LINK2=reads/
```

### 1. Select a genome, then download the corresponding FASTA file.

Download and unzip the file:

```
# Download the genome
datasets download genome accession ${GCF}

# Unpack the data (Overwrite files if they already exist)
unzip -o ncbi_dataset.zip

# Make a link to a simpler name
ln -sf ${LINK} ${GENOME}
```

**a. The size of the file:** 97MB

```
echo "Size of the FASTQ file is:"
ls -lh ${LINK}
```

Result:

```
+ echo 'Size of the FASTQ file is:'
Size of the FASTQ file is:
+ ls -lh ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
-rw-------  1 hpbichtram  staff    97M Sep 29 23:48 ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
```

**b. The total size of the genome:** 100 286 401 

```
echo "Total size of the genome is at column sum_len:"
seqkit stats ${GENOME}
```

Result:

```
+ echo 'Total size of the genome is at column sum_len:'
Total size of the genome is at column sum_len:
+ seqkit stats elegans.fa
file        format  type  num_seqs      sum_len  min_len       avg_len     max_len
elegans.fa  FASTA   DNA          7  100,286,401   13,794  14,326,628.7  20,924,180
```

**c. The number of chromosomes in the genome:** 7

```
echo "Total number of chromosomes is:"
grep -c "^>" ${GENOME}
```

Result:

```
+ echo 'Total number of chromosomes is:'
Total number of chromosomes is:
+ grep -c '^>' elegans.fa
7
```

**d. The name (id) and length of each chromosome in the genome:**

```
echo "ID and length of each chromosome are:"
awk '/^>/ {if (seqlen) {print chrom, seqlen}; chrom=$0; seqlen=0; next} {seqlen += length($0)} END {print chrom, seqlen}' ${GENOME}
```

Result:

```
+ echo 'ID and length of each chromosome are:'
ID and length of each chromosome are:
+ awk '/^>/ {if (seqlen) {print chrom, seqlen}; chrom=$0; seqlen=0; next} {seqlen += length($0)} END {print chrom, seqlen}' elegans.fa
>NC_003279.8 Caenorhabditis elegans chromosome I 15072434
>NC_003280.10 Caenorhabditis elegans chromosome II 15279421
>NC_003281.10 Caenorhabditis elegans chromosome III 13783801
>NC_003282.8 Caenorhabditis elegans chromosome IV 17493829
>NC_003283.11 Caenorhabditis elegans chromosome V 20924180
>NC_003284.9 Caenorhabditis elegans chromosome X 17718942
>NC_001328.1 Caenorhabditis elegans mitochondrion, complete genome 13794
```

### 2. Generate a simulated FASTQ output for a sequencing instrument of your choice. Set the parameters so that your target coverage is 10x.

Since we have the formula below (with paired-end sequencing):

> $Coverage = \frac{\text{Read Length} \times \text{Number of Reads} \times 2}{\text{Genome Size}}$

To calculate read numbers with the read length of 150 bp (for example, Illumina MiSeq or NextSeq1000/2000) and paired-end sequencing for target coverage of 10x:

> $Read numbers = \frac{\text{Genome Size} \times \text{10}}{\text{150 bp}  \times 2} = \frac{\text{100 286 401} \times \text{10}}{\text{150 bp}  \times 2} = ~ 3342900 $

To generate the FASTA files:

```
# Simulate with no errors and no mutations
wgsim -N ${N} -1 ${L} -2 ${L} -r 0 -R 0 -X 0 \
      ${GENOME} ${R1} ${R2}
```

**a. Number of reads I have generated:** 3342900

```
# Run read statistics
seqkit stats ${R1} ${R2}
```

Result:

```
+ seqkit stats reads/wgsim_read1.fq reads/wgsim_read2.fq
processed files:  2 / 2 [======================================] ETA: 0s. done
file                  format  type   num_seqs      sum_len  min_len  avg_len  max_len
reads/wgsim_read1.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
reads/wgsim_read2.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
```

**b. The average read length:** 150

```
# Run read statistics
seqkit stats ${R1} ${R2}
```

Result:

```
+ seqkit stats reads/wgsim_read1.fq reads/wgsim_read2.fq
processed files:  2 / 2 [======================================] ETA: 0s. done
file                  format  type   num_seqs      sum_len  min_len  avg_len  max_len
reads/wgsim_read1.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
reads/wgsim_read2.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
```

**c. These FASTQ files size:** 1.1GB each file

```
echo "These FASTA files size are:"
ls -lh ${LINK2}
```

Result:

```
+ echo 'These FASTA files size are:'
These FASTA files size are:
+ ls -lh reads/
total 5481816
-rw-r--r--  1 hpbichtram  staff   1.1G Sep 29 23:16 wgsim_read1.fq
-rw-r--r--  1 hpbichtram  staff   1.1G Sep 29 23:16 wgsim_read2.fq
```

**d. Compress the files and report how much space that saves:** 210MB each file

```
# Compress the files
gzip ${R1} ${R2}

# Size of new compressed files
echo " "
echo "These compressed FASTA files' size are:"
ls -lh ${LINK2}
```

Result:

```
+ echo 'These compressed FASTA files'\'' size are:'
These compressed FASTA files' size are:
+ ls -lh reads/
total 858648
-rw-r--r--  1 hpbichtram  staff   210M Sep 29 23:16 wgsim_read1.fq.gz
-rw-r--r--  1 hpbichtram  staff   210M Sep 29 23:16 wgsim_read2.fq.gz
```

**e. Discuss whether I could get the same coverage with different parameter settings (read length vs. read number):**

Since we have the formula below (with paired-end sequencing):

>> $Coverage = \frac{\text{Read Length} \times \text{Number of Reads} \times 2}{\text{Genome Size}}$

We can get the same coverage with modified parameter settings:

  e.1/ When we increase the read length size, we are required to decrease the number of reads. This modification can reduce the file sizes and computational analysis steps, but it is just suitable with some sequencing techniques. For examples, depending on the application, Illumina's read can be from 50bp to 300bp. So we need to be carefully when increase the read length sizes. And due to the long reads, the accurate level also reduces.

  e.2/ When we shorten the read length size and increase the number of reads, we can have fewer sequencing errors for the same coverage. However, a larger number of reads will lead to a extremely huge size of FASTQ files and require more computational efforts and memory capability of the computer/terminal to run.


### 3. Total data would be generated when covering the Yeast, the Drosophila or the Human genome at 30x:

Since genome size of Caenorhabditis elegans is 100 286 401 base pairs (bp) ~ 100.2 Mb and the file size is about 97 MB, the ratio of genome size and FASTA file size is ~ 1:1.

Read length = 150 bp 

Ratio of reads and size of new FASTA file (with paired-end sequencing) : 1519500 

$\frac{\text{3 342 900}}{\text{2 files * 1.1GB}} = 1 519 500 $

When compressing a file, its size decreases by ~5.36 times ($=\frac{\text{1.1GB}}{\text{210MB}}$.

**a. Saccharomyces cerevisiae (yeast):** ~ 12.2 Mb

a.1/ Size of FASTA file: ~ 12.3 MB (12.2 MB of genome and 0.1 MB for other parts of the file)

a.2/ Number of FASTQ reads needed for 30x: 1 220 000 (each file)


> $\frac{\text{12 200 000 x 30}}{\text{150 * 2}} = 1 220 000$

a.3/ Size of the FASTQ files before compression: 822.27 MB (each file)


$\frac{\text{1 220 000}}{\text{1 519 500}} = 0.803 GB ~ 822.26 MB$

a.4/ Size of the FASTQ files after compression: 153.4 MB (each file)


$\frac{\text{822.27}}{\text{5.36}} = 153.4 MB$

**b. Drosophila melanogaster:** ∼180 Mb

b.1/ Size of FASTA file: 183 MB (180 MB of genome and 3 MB for other parts of the file)

b.2/ Number of FASTQ reads needed for 30x: 18 000 000 (each file)


$\frac{\text{180 000 000 x 30}}{\text{150 * 2}} = 18 000 000$

b.3/ Size of the FASTQ files before compression: 11.85 GB (each file)


$\frac{\text{18 000 000}}{\text{1 519 500}} = 11.85 GB$

b.4/ Size of the FASTQ files after compression: 2.21 GB (each file)


$\frac{\text{11.85}}{\text{5.36}} = 2.21 GB$

**c. Homo sapiens:** ~ 3.2 Gb (3.2 billion base pairs) (in a haploid set of chromosomes)

c.1/ Size of FASTA file: 3.23 GB (3.2 GB of genome and 0.03 GB for other parts of the file)

c.2/ Number of FASTQ reads needed for 30x: 320 000 000 (each file)


$\frac{\text{3 200 000 000 x 30}}{\text{150 * 2}} = 320 000 000$

c.3/ Size of the FASTQ files before compression: 210.6 GB (each file)


$\frac{\text{320 000 000}}{\text{1 519 500}} = 210.6 GB$

c.4/ Size of the FASTQ files after compression: 39.29 GB (each file)


$\frac{\text{210.6}}{\text{5.36}} = 39.29 GB$

