#
# Generate an RNA-Seq count matrix.
#

# Accession number of the Lyssavirus rabies genome.
ACC=GCF_000859625.1

# The reference file.
REF=refs/rabies.fa

# The GTF file.
GTF=refs/rabies.gtf

# The design file.
DESIGN = design.csv

# The number of reads to get.
N=100000

# File to save downloaded reads
LINK=reads/

# The resulting BAM file.
BAM=bam/${SAMPLE}.bam

# The counts in tab delimited format.
COUNTS_TXT = res/counts-hisat.txt

# Final combinted counts in CSV format.
COUNTS_CSV = res/counts-hisat.csv

# Flags passed to parallel.
FLAGS = --eta --lb --header : --colsep ,

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
	@echo "# RNA-Seq count matrix generation"
	@echo "#"
	@echo "# ACC=${ACC}"
	@echo "# REF=${REF}"
	@echo "# GTF=${GTF}"
	@echo "# DESIGN=${DESIGN}"
	@echo "#"
	@echo "# make design      # create the design.csv file."
	@echo "# make index       # download the reference data and generate the HISAT2 index."
	@echo "# make data        # download the sequencing data from design file."
	@echo "# make align       # run the alignment with SRA from design file by HISAT2."
	@echo "# make count       # generate the count matrix in CSV format."
	@echo "# make clean       # clean all files after every run."
	@echo "# make all         # proceed all the targets."
	@echo "#"

# Create the design file.
design:
	# Group column is sample_alias.
	@cat << EOF > ${DESIGN}
	sample,group
	ERR2097150,RV2981
	ERR2097160,Sub 5792
	ERR2097161,Sub5790
	EOF

	# Show the design file.
	@ls -lh ${DESIGN}

	@echo "Design file is generated. Thank you!"

# Download the reference data and generate the HISAT2 index.
index:
	# Create the reference directory.
	mkdir -p $(dir ${REF})
	
	# Download the sequencing data.
	datasets download genome accession ${ACC} --include genome,gtf

	# Unzip the genome, skip the README and md5sum files.
	unzip -n ncbi_dataset.zip -x README.md md5sum.txt 

	# Copy the genome and gtf to the reference file.
	cp -f ncbi_dataset/data/${ACC}*/${ACC}*_genomic.fna ${REF}
	cp -f ncbi_dataset/data/${ACC}*/genomic.gtf ${GTF}

	# Generate the HISAT2 index.
	make -f src/run/hisat2.mk index REF=${REF}

	@echo "Genome is indexed. Thank you!"

# Download the sequencing data from design file.
data: ${DESIGN}
	# Create the reads directory.
	mkdir -p $(dir ${LINK})

	# Loop through the SRR IDs in the sample column of the DESIGN file
	csvcut -c 1 ${DESIGN} | tail -n +2 | parallel \
		"fastq-dump -X ${N} --outdir ${LINK} --split-files {} && \
		echo 'Downloaded: {}'"
	
	@echo "All RNA-seq data are downloaded. Thank you!"

# Run the alignment with SRA from design file by HISAT2.
align: ${DESIGN}
	cat ${DESIGN} | parallel ${FLAGS} \
		make -f src/run/hisat2.mk \
		REF=${REF} \
		R1=reads/{sample}_1.fastq \
		BAM=bam/{sample}.bam \
		run
	@echo "The alignment is completed. Thank you!"

# The counts file.
${COUNTS_TXT}:
	# Make the directory name for the counts
	mkdir -p $(dir $@)

	# Count the features
	cat ${DESIGN} | \
		parallel --header : --colsep , -k echo bam/{sample}.bam | \
		parallel -u --xargs featureCounts -a ${GTF} -o ${COUNTS_TXT} {}

# Generate the count matrix in CSV format.
${COUNTS_CSV}: ${COUNTS_TXT}
	micromamba run -n stats Rscript src/r/format_featurecounts.r -c ${COUNTS_TXT} -o ${COUNTS_CSV}

# List all count files
count: ${COUNTS_CSV}
	@ls -lh ${COUNTS_TXT}
	@ls -lh ${COUNTS_CSV}
	@echo "The count matrix files are generated. Thank you!"

# Run all the steps.
all: design index data align count
	@echo "The progress is completed. Thank you!"

# Remove all the generated files.
clean:
	rm -rf refs/ reads/ bam/ res/ ncbi_dataset/ ncbi_dataset.zip design.csv

# These targets do not correspond to files.
.PHONY: usage design index data align count clean all