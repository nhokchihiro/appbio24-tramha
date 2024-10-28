#
# Makefile for filter and work with BAM file
#

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

#-- VARIABLE SETTINGS ABOVE THIS LINE--#

# Setting useful defaults.
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


# Print all possible targets
usage:
	@echo "Here are all targets you can run"
	@echo "make info          # summary information on the genome"
	@echo "make refs          # download the genome file and detail information"
	@echo "make fastq         # download reads from SRA, please put the SRR of paired-end sequencing"
	@echo "make index         # index the reference genome"
	@echo "make align         # align the reads and convert to BAM"
	@echo "make count         # counting in a BAM file"
	@echo "make filter        # filter a BAM file"
	@echo "make stats         # generate alignment statistics"
	@echo "make clean         # remove the generated files"
	@echo "make all           # run all the targets"

# Print the summary information on the reference genome.
info:
	@datasets summary genome accession ${ACC} | jq

# Obtain the reference genome
refs:
	# Create the reference directory
	mkdir -p $(dir ${REF})

	# Use datasets to download the genome.
	datasets download genome accession ${ACC}

	# Unzip the genome, skip the README and md5sum files.
	unzip -n ncbi_dataset.zip -x README.md md5sum.txt 

	# Copy the genome to the reference file.
	cp -f ncbi_dataset/data/${ACC}*/${ACC}*_genomic.fna ${REF}

# Download a subset of reads from SRA
# Remove the -X flag to get all data.
fastq:
	# Create the reads directory
	mkdir -p $(dir ${R1})

	# Download the reads
	fastq-dump -X ${N} --outdir reads --split-files ${SRR}

# Index the reference genome
index:
	bwa index ${REF}

# Align the reads and convert to BAM. Use 4 threads
align:
	# Make the BAM directory
	mkdir -p $(dir ${BAM1})

	# Align the reads
	bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM1}

	# Index the BAM file
	samtools index ${BAM1}

# Counting in a BAM file
count:
	# Count unmapped reads
	@echo "Counting unmapped reads..."
	@echo "Total unmapped reads did not align with the reference genome:"
	samtools view -c -f 4 $(BAM1)

	# Count primary, secondary, and supplementary alignments
	@echo "Counting alignments..."
	@echo "Total primary alignments in the BAM file:"
	samtools view -c -F 256 -F 2048 $(BAM1)
	@echo "Total secondary alignments in the BAM file:"
	samtools view -c -f 256 $(BAM1)
	@echo "Total supplementary alignments in the BAM file:"
	samtools view -c -f 2048 $(BAM1)

	# Count properly paired alignments on the reverse strand
	@echo "Total properly paired alignments on the reverse strand:"
	samtools view -c -f 1 -f 2 -f 16 -f 64 $(BAM1)

# Filter BAM file
filter:
	# Create a new BAM file with filtered alignments
	@echo "Creating filtered BAM file with only the properly paired primary alignments with a mapping quality of over 10..."
	samtools view -b -h -q 10 -f 2 -F 256 -F 2048 $(BAM1) > $(BAM2)
	samtools index ${BAM2}

# Generate alignment statistics
stats:
	@echo "Stats for original BAM file:"
	samtools flagstat ${BAM1}
	@echo "Stats for filtered BAM file:"
	samtools flagstat ${BAM2}
	@echo "Thank you."

# Cleanup the files
clean:
	rm -rf ${REF} ${R1} ${R2} ncbi_dataset/ refs/
	rm -f ncbi_dataset.zip

# Run all targets
all: info refs fastq index align count filter stats clean

# Mark the targets that do not create files.
.PHONY: all usage info refs fastq index align count filter stats clean