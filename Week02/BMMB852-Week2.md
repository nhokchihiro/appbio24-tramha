Chosen organism: bubo_bubo

The organism is Bubo bubo (or Uhu) - which is the Eurasian Eagle-Owl. This is one of the largest owl species, recognized for its large orange eyes and prominent ear tufts. It inhabits a wide range across Europe, Asia, and parts of North Africa, typically in rocky landscapes and forests. These birds weigh between three to nine pounds and have an impressive wingspan of more than six feet. Their diet includes small mammals (rats,...), birds (hunt woodpeckers, herons,...), and larger animals like hares. They can live up to 20 years, with some reaching 60 years. These birds are beneficial to farmers for controlling rodent populations.

## A. Data download and unzip:

```
wget https://ftp.ensembl.org/pub/current_gff3/bubo_bubo/Bubo_bubo.BubBub1.0.112.gff3.gz 
gunzip Bubo_bubo.BubBub1.0.112.gff3.gz
ls -l
```

Example:

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ wget https://ftp.ensembl.org/pub/current_gff3/bubo_bubo/Bubo_bubo.BubBub1.0.112.gff3.gz
--2024-09-08 18:32:31--  https://ftp.ensembl.org/pub/current_gff3/bubo_bubo/Bubo_bubo.BubBub1.0.112.gff3.gz
Resolving ftp.ensembl.org (ftp.ensembl.org)... 193.62.193.169
Connecting to ftp.ensembl.org (ftp.ensembl.org)|193.62.193.169|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 8817664 (8.4M) [application/x-gzip]
Saving to: 'Bubo_bubo.BubBub1.0.112.gff3.gz'

Bubo_bubo.BubBub1.0 100%[===================>]   8.41M   710KB/s    in 13s     

2024-09-08 18:32:44 (644 KB/s) - 'Bubo_bubo.BubBub1.0.112.gff3.gz' saved [8817664/8817664]

hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ gunzip Bubo_bubo.BubBub1.0.112.gff3.gz 

hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ ls -l
total 253312
-rw-r--r--  1 hpbichtram  staff   124M Mar  5  2024 Bubo_bubo.BubBub1.0.112.gff3
```

## B. Features extraction:

```
cat Bubo_bubo.BubBub1.0.112.gff3 | grep -v '^#'| wc -l  
```

Example:

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ cat Bubo_bubo.BubBub1.0.112.gff3 | grep -v '^#'| wc -l
  779129
```

## C. Sequence regions (chromosomes) extraction: 

```
cat Bubo_bubo.BubBub1.0.112.gff3 | grep '##sequence-region'| wc -l
```

Example:

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ cat Bubo_bubo.BubBub1.0.112.gff3 | grep '##sequence-region'| wc -l
   35666
```

## D. Listed genes extration: 

```
cat Bubo_bubo.BubBub1.0.112.gff3 | grep -w 'gene' | wc -l
```

Example:

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ cat Bubo_bubo.BubBub1.0.112.gff3 | grep -w 'gene' | wc -l
   40715
```

## E. Top-ten most annotated feature types (column 3) extraction:

```
cat Bubo_bubo.BubBub1.0.112.gff3 | cut -f 3 | grep -v "^#" | sort | uniq -c | sort -rn | head -10
```

Example: 

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/BMMB852
$ cat Bubo_bubo.BubBub1.0.112.gff3 | cut -f 3 | grep -v "^#" | sort | uniq -c | sort -rn | head -10
339008 exon
333762 CDS
35666 region
25237 mRNA
14407 gene
11904 biological_region
9763 five_prime_UTR
8311 three_prime_UTR
 458 ncRNA_gene
 185 snoRNA
```

## F. This genome is well-annotated since the number of CDS and exons seems balanced. This genome includes all essential features (e.g. exons, CDS, mRNA, genes, five prime UTR,...).

Each features also include with enough information (e.g. exons have protein id, exon id). 
The number of genes (14407) is also equal with the official information (https://useast.ensembl.org/Bubo_bubo/Info/Annotation), so it is completed.
However, this genome seems highly fragmented with lots of small chromosomes, some are just 520 or 600 bp. Thus, the genome is poorly assembled and lacks continuity.
Additionally, lines are sorted randomly, not by fragment size from largest to smallest.
And numbers of rRNA, snRNA, and other small RNAs are low, perhaps it is potentially incompleted in annotation.

## G. Other insights.

With the unbalanced numbers of 14,407 genes and 25,237 mRNAs, it seems that some genes are alternatively spliced, producing multiple mRNA isoforms per gene.
Numbers of five prime UTRs and three prime UTRs are quite balanced.
Numbers of some non-coding RNAs (snRNA, scRNA,...) and especially rRNA are quite low - which suggest that non-coding RNAs perhaps less annotated or less prevalent in this genome (or missing in case of rRNA).
This genome is highly fragmented, could lead to missing or partial features when assembling - maybe the reason why some non-coding RNAs are quite low. 
