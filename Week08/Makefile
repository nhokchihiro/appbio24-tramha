#
# Makefile for aligning short reads with BWA
#

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
	@echo "make simulate      # simulate FASTQ output"
	@echo "make fastq         # download reads from SRA, please put the SRR of paired-end sequencing"
	@echo "make index         # index the reference genome"
	@echo "make align         # align the reads and convert to BAM"
	@echo "make stats         # generate alignment statistics"
	@echo "make clean         # remove the generated files"
	@echo "make all_simulate  # only run the targets related to simulating FASTQ output"
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

# Simulate FASTQ output with wgsim
simulate:
	# Make the directory that will hold the reads extracts
	mkdir -p ${LINK1}

	# Simulate with no errors and no mutations
	wgsim -N ${N} -1 ${L} -2 ${L} -r 0 -R 0 -X 0 \
	  ${REF} ${R1} ${R2}

	# Run read statistics
	seqkit stats ${R1} ${R2}
	echo "These FASTQ files' size are:"
	ls -lh ${LINK1}

# Download a subset of reads from SRA
# Remove the -X flag to get all data.
fastq:
	# Create the reads directory
	mkdir -p $(dir ${R3})

	# Download the reads
	fastq-dump -X ${N2} --outdir reads2 --split-files ${SRR}

# Index the reference genome
index:
	bwa index ${REF}

# Align the reads and convert to BAM. Use 4 threads
align:
	# Make the BAM directory
	mkdir -p $(dir ${BAM1})

	# Align the reads
	bwa mem -t 4 ${REF} ${R1} ${R2} | samtools sort  > ${BAM1}
	bwa mem -t 4 ${REF} ${R3} ${R4} | samtools sort  > ${BAM2}

	# Index the BAM file
	samtools index ${BAM1}
	samtools index ${BAM2}

# Generate alignment statistics
stats:
	samtools flagstat ${BAM1}
	samtools flagstat ${BAM2}

# Cleanup the generated files
clean:
	rm -rf ${REF} ${R1} ${R2} ${R3} ${R4} ${BAM1} ${BAM1}.bai ${BAM2} ${BAM2}.bai
	rm -f ncbi_dataset.zip

# Only run the targets related to simulating FASTQ output
all_simulate: info refs simulate clean

# Run all targets
all: info refs simulate fastq index align stats clean

# Mark the targets that do not create files.
.PHONY: all all_simulate usage info refs simulate fastq index align stats clean
