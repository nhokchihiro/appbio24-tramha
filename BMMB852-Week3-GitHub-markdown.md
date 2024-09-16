## 1. Reformat your previous assignment

Link to the markdown file: https://github.com/nhokchihiro/appbio24-tramha/blob/main/BMMB852-Week2-GitHub-markdown.md

## 2. Visualize the GFF file of your choice.

Species: Saccharomyces cerevisiae

RefSeq: GCF_000146045.2

Resouce: NCBI


### a. Download the genome and annotation files for an organism of your choice.

```
$ datasets download genome accession GCF_000146045.2 --include gff3,cds,protein,rna,genome
```

Example:

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04
$ datasets download genome accession GCF_000146045.2 --include gff3,cds,protein,rna,genome
New version of client (16.28.0) available at https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/mac/datasets.
Collecting 1 genome record [================================================] 100% 1/1
Downloading: ncbi_dataset.zip    13.7MB valid zip structure -- files not checked
Validating package [================================================] 100% 9/9
(bioinfo) 

hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04
$ unzip ncbi_dataset.zip 
Archive:  ncbi_dataset.zip
  inflating: README.md               
  inflating: ncbi_dataset/data/assembly_data_report.jsonl  
  inflating: ncbi_dataset/data/GCF_000146045.2/GCF_000146045.2_R64_genomic.fna  
  inflating: ncbi_dataset/data/GCF_000146045.2/genomic.gff  
  inflating: ncbi_dataset/data/GCF_000146045.2/cds_from_genomic.fna  
  inflating: ncbi_dataset/data/GCF_000146045.2/protein.faa  
  inflating: ncbi_dataset/data/GCF_000146045.2/rna.fna  
  inflating: ncbi_dataset/data/dataset_catalog.json  
  inflating: md5sum.txt              
(bioinfo) 
```

### b. Use IGV to visualize the annotations relative to the genome.
Images on assignment CANVAS

### c. Separate intervals of type "gene" into a different file. If you don't have genes, pick another feature.

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04
$ cat ncbi_dataset/data/GCF_000146045.2/genomic.gff | awk ' $3=="gene" {print $0}' > ncbi_dataset/data/GCF_000146045.2/gene.gff
(bioinfo) 

hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04
$ cat ncbi_dataset/data/GCF_000146045.2/genomic.gff | awk ' $3=="CDS" {print $0}' > ncbi_dataset/data/GCF_000146045.2/CDS.gff
(bioinfo) 

hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04
$ cat ncbi_dataset/data/GCF_000146045.2/genomic.gff | awk ' $3=="telomere" {print $0}' > ncbi_dataset/data/GCF_000146045.2/telomere.gff
(bioinfo) 
```

Images on assignment CANVAS

### d. Using your editor create a GFF that represents a intervals in your genome. Load that GFF as a separate track in IGV.

```
hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04
$ cd ncbi_dataset/data/GCF_000146045.2/
(bioinfo) 

hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04/ncbi_dataset/data/GCF_000146045.2
$ code gffcreate.gff
(bioinfo) 

hpbichtram@Trams-MacBook-Pro ~/Desktop/Lecture04/ncbi_dataset/data/GCF_000146045.2
$ cat GCF_000146045.2_R64_genomic.fna | head -1
>NC_001133.9 Saccharomyces cerevisiae S288C chromosome I, complete sequence
(bioinfo) 
```

Images on assignment CANVAS





