Genome: [Caenorhabditis elegans](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/6239/)

RefSeq:  GCF_000002985.6

### 1. Select a genome, then download the corresponding FASTA file.


**a. The size of the file:** 97M

```
+ echo 'Size of the FASTQ file is:'
Size of the FASTQ file is:
+ ls -lh ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
-rw-------  1 hpbichtram  staff    97M Sep 29 23:48 ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
```

**b. The total size of the genome:** 100,286,401

```
+ echo 'Total size of the genome is at column sum_len:'
Total size of the genome is at column sum_len:
+ seqkit stats elegans.fa
file        format  type  num_seqs      sum_len  min_len       avg_len     max_len
elegans.fa  FASTA   DNA          7  100,286,401   13,794  14,326,628.7  20,924,180
```

**c. The number of chromosomes in the genome:** 7

```
+ echo 'Total number of chromosomes is:'
Total number of chromosomes is:
+ grep -c '^>' elegans.fa
7
```

**d. The name (id) and length of each chromosome in the genome:**

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

### 2. Generate a simulated FASTQ output for a sequencing instrument of your choice.  Set the parameters so that your target coverage is 10x.

**a. Number of reads I have generated:** 3342900

```
+ seqkit stats reads/wgsim_read1.fq reads/wgsim_read2.fq
processed files:  2 / 2 [======================================] ETA: 0s. done
file                  format  type   num_seqs      sum_len  min_len  avg_len  max_len
reads/wgsim_read1.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
reads/wgsim_read2.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
```

**b. The average read length:** 150

```
+ seqkit stats reads/wgsim_read1.fq reads/wgsim_read2.fq
processed files:  2 / 2 [======================================] ETA: 0s. done
file                  format  type   num_seqs      sum_len  min_len  avg_len  max_len
reads/wgsim_read1.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
reads/wgsim_read2.fq  FASTQ   DNA   3,342,900  501,435,000      150      150      150
```

**c. These FASTQ files size:** 1.1G each file

```
+ echo 'These FASTA files size are:'
These FASTA files size are:
+ ls -lh reads/
total 5481816
-rw-r--r--  1 hpbichtram  staff   1.1G Sep 29 23:16 wgsim_read1.fq
-rw-r--r--  1 hpbichtram  staff   1.1G Sep 29 23:16 wgsim_read2.fq
```

**d. Compress the files and report how much space that saves:** 210M each file

```
+ echo 'These compressed FASTA files'\'' size are:'
These compressed FASTA files' size are:
+ ls -lh reads/
total 858648
-rw-r--r--  1 hpbichtram  staff   210M Sep 29 23:16 wgsim_read1.fq.gz
-rw-r--r--  1 hpbichtram  staff   210M Sep 29 23:16 wgsim_read2.fq.gz
```

**e. Discuss whether you could get the same coverage with different parameter settings (read length vs. read number):**


### 3. How much data would be generated when covering the Yeast,  the Drosophila or the Human genome at 30x?

When compressing a file, its size decreases by ~5.3 times (=1.1GB/210MB).

Read length = 150 bp 

Ratio of reads and size of new FASTA file: 1519500 (=3342900/(2 files*1.1GB)).

**a. Saccharomyces cerevisiae (yeast):** ~ 12 000 000 base pairs (bp)

Size of FASTA file: ~ 12.3 MB (0.1 MB for other parts of the file)

Number of FASTQ reads needed for 30x: 
(12 000 000 x 30) / 150 / 2 = 1 200 000

Size of the FASTQ files before compression: 
1 200 000 / 1 519 500 = 0.789 GB ~ 808 MB

Size of the FASTQ files after compression:
808/5.3 = 152.5 MB

**b. Drosophila melanogaster:** ~ 180 000 000 bp

Size of FASTA file: 183 MB (3 MB for other parts of the file)

Number of FASTQ reads needed for 30x: 
(180 000 000 x 30) / 150 / 2 = 18 000 000

Size of the FASTQ files before compression:
18 000 000 / 1 519 500 = 11.85 GB

Size of the FASTQ files after compression:
11.85/5.3 = 2.24 GB

**c. Homo sapiens:** ~ 3 200 000 000 bp

Size of FASTA file: 3.23 GB (0.03 GB for other parts of the file)

Number of FASTQ reads needed for 30x: 
(3 200 000 000 x 30) / 150 / 2 = 320 000 000

Size of the FASTQ files before compression:
320 000 000 / 1 519 500 = 210.6 GB

Size of the FASTQ files after compression:
210.6/5.3 = 39.7 GB
