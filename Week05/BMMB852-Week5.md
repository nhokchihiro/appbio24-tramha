Genome: [Caenorhabditis elegans](https://www.ncbi.nlm.nih.gov/datasets/taxonomy/6239/)

RefSeq:  GCF_000002985.6

### 1. Select a genome, then download the corresponding FASTA file.


a. The size of the file: 97M

```
+ echo 'Size of the FASTQ file is:'
Size of the FASTQ file is:
+ ls -lh ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
-rw-------  1 hpbichtram  staff    97M Sep 29 23:48 ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna
```

b. The total size of the genome: 100,286,401

```
+ echo 'Total size of the genome is at column sum_len:'
Total size of the genome is at column sum_len:
+ seqkit stats elegans.fa
file        format  type  num_seqs      sum_len  min_len       avg_len     max_len
elegans.fa  FASTA   DNA          7  100,286,401   13,794  14,326,628.7  20,924,180
```

c. The number of chromosomes in the genome: 7

```
+ echo 'Total number of chromosomes is:'
Total number of chromosomes is:
+ grep -c '^>' elegans.fa
7
```

d. The name (id) and length of each chromosome in the genome:

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

## 2. Generate a simulated FASTQ output for a sequencing instrument of your choice.  Set the parameters so that your target coverage is 10x.

a. How many reads have you generated?

b. What is the average read length?
c. How big are the FASTQ files?
d. Compress the files and report how much space that saves.
e. Discuss whether you could get the same coverage with different parameter settings (read length vs. read number).

## 3. How much data would be generated when covering the Yeast,  the Drosophila or the Human genome at 30x?

Now imagine that instead of your genome, each instrument generated reads that cover the Yeast, Drosophila, and Human genomes at 30x coverage (separate runs for each organism). You don't have to run the tool all you need is to estimate.

Using the information you've obtained in the previous points, for each of the organisms, estimate the size of the FASTA file that holds the genome, the number of FASTQ reads needed for 30x, and the size of the FASTQ files before and after compression.
