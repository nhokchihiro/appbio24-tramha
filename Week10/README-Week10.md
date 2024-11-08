This assignment requires writing a Makefile and a markdown report.

You can reuse the Makefile developed for your previous assignment, which generated a BAM file from SRA reads. You may need to get more data to obtain sufficient coverage over the genome. If the data shows no variants, find another dataset that does.

Call variants on the BAM file and discuss some information on the variants you found.

Your eye is an excellent variant caller.

Verify the variant caller's results by looking at a few example the alignments in the BAM file.

Find examples where the variant caller did not work as expected: false positives, false negatives, etc.

Go over a “checklist” and “score” the variant based on various characteristics.

How many reads carry the variant (depth)
Are the reads that carry variante on both strands
Is the variant evenly distributed across all positions
Is the coverage different around the variant
Is there another explanation that individually is not better, 
but overall across all reads would be better (this is a hard decision to make!)

> [!IMPORTANT]  
> Please install Bioinformatics Toolbox first by running `bio code`.

> [!IMPORTANT]
> Please copy and paste the whole codes in a new Makefile from your directory. If you just download Makefile, it will turn into Makefile.txt instead of a Makefile. If then, you need to modify Makefile.txt into Makefile.mk and the command into make -f Makefile.mk all

> [!WARNING]  
> This Makefile will run only with paired-end sequencing reads. If your SRA downloaded reads are single end, please modify the Makefile first.

## Variant calling in a BAM file

### 1. Variable settings:

```
# Accession number of the ebola genome.
ACC=AF086833

# The reference file.
REF=refs/zaire.fa

# The GFF file.
GFF=refs/zaire.gff

# The sequencing read accession number.
SRR=SRR1553606

# The number of reads to get
N=100000

# The name of the sample (see: bio search SRR1553425)
SAMPLE=NM042

# The path to read 1
R1=reads/${SAMPLE}_1.fastq

# The path to read 2
R2=reads/${SAMPLE}_2.fastq

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The resulting variant VCF file (compressed!).
VCF=vcf/${SAMPLE}.vcf.gz
```

make all  ACC=GCF_000063585.1 SRR=SRR28257549 SAMPLE=BMH-2021 REF=refs/botulinum.fa GFF=refs/botulinum.gff
