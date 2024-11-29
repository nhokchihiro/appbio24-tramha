#
# Variant effect prediction in a BAM file
#

# Accession number of the Zaire ebolavirus genome.
ACC=GCA_000848505.1

# The reference file.
REF=refs/zaire.fa

# The GFF file.
GFF=refs/zaire.gff

# The sequencing read accession number.
SRR=SRR1553606

# The number of reads to get
N=100000

# The name of the sample 
SAMPLE=NM042

# The path to SRA reads
R1=reads/${SAMPLE}_1.fastq
R2=reads/${SAMPLE}_2.fastq

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The resulting variant VCF file (compressed!).
VCF=vcf/${SAMPLE}.vcf.gz

#----

# Custom makefile settings.
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Print the usage of the makefile.
usage:
	@echo "#"
	@echo "# SNP call demonstration"
	@echo "#"
	@echo "# ACC=${ACC}"
	@echo "# SRR=${SRR}"
	@echo "# SAMPLE=${SAMPLE}"
	@echo "# BAM=${BAM}"
	@echo "# VCF=${VCF}"
	@echo "#"
	@echo "# make bam          # create the BAM alignment file."
	@echo "# make vcf          # call the SNPs and produce VCF file."
	@echo "# make variants     # variant effect prediction."
	@echo "# make all          # run all the steps."
	@echo "# make clean        # clean the file after every run."
	@echo "#"

# Create the BAM alignment file.
bam: 
	# Get the reference genome and the annotations.
	make -f src/run/genbank.mk ACC=${ACC} REF=${REF} GFF=${GFF} fasta gff

	# Index the reference genome.
	make -f src/run/bwa.mk REF=${REF} index

	# Download the sequence data.
	@echo "Download sequence data and start aligning to the reference genome..."
	make -f src/run/sra.mk SRR=${SRR} R1=${R1} R2=${R2} N=${N} run

	# Align the reads to the reference genome. 
	make -f src/run/bwa.mk SM=${SAMPLE} REF=${REF} R1=${R1} R2=${R2} BAM=${BAM} run stats
	@echo "The alignment is done."

# Call the SNPs and produce VCF file.
vcf:
	make -f src/run/bcftools.mk REF=${REF} BAM=${BAM} VCF=${VCF} run
	@echo "Variants is completely recorded in VCF file."

# Variant effect prediction.
variants:
	# To build the custom database match with our REF.
	make -f src/run/snpeff.mk GFF=${GFF} REF=${REF} build

	# Run snpEff for variant prediction.
	make -f src/run/snpeff.mk GFF=${GFF} REF=${REF} VCF=${VCF} run

	@echo "Variant effect prediction by snpEff is finished."

# Run all the steps.
all: bam vcf variants
	@echo "The progress is completed. Thank you!"

# Remove all the generated files.
clean:
	rm -rf refs/ reads/ bam/ vcf/ results/ idx/ stat.txt snpeff.config

# These targets do not correspond to files.
.PHONY: bam vcf variants all usage clean
