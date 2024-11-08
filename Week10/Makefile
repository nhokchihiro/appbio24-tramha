#
# Variant calling in a BAM file
#

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
	@echo "# make count        # counting variants in the resulting VCF file."
	@echo "# make all          # run all the steps."
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
	# Use a sample name in the readgroup.
	make -f src/run/bwa.mk SM=${SAMPLE} REF=${REF} R1=${R1} R2=${R2} BAM=${BAM} run stats
	@echo "The alignment is done."

# Call the SNPs and produce VCF file.
vcf:
	make -f src/run/bcftools.mk REF=${REF} BAM=${BAM} VCF=${VCF} run
	@echo "Variants is completely recorded in VCF file."

# Counting variants in the resulting VCF file.
count:
	# Counts all variant lines, ignoring headers
	@echo "Count all the variant lines in the VCF file:"
	bcftools view ${VCF} | wc -l

	# Count SNPs and indels
	@echo "Count all SNPs and indels in the VCF file:"
	bcftools view -v snps ${VCF} | wc -l
	bcftools view -v indels ${VCF} | wc -l

	# Count quality variants
	@echo "Count all the variants with QUAL >30:"
	bcftools filter -i 'QUAL > 30' ${VCF} | wc -l

# Run all the steps.
all: bam vcf count
	@echo "The progress is completed. Thank you!"

# Remove all the generated files.
clean:
	rm -rf refs/ reads/ bam/ vcf/

# These targets do not correspond to files.
.PHONY: bam vcf count all usage clean