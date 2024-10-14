# Accession number & ID
ACC=GCF_000002985.6
ID=WBcel235

# The GFF file name.
GFF=ncbi_dataset/data/${ACC}/${ACC}_${ID}_genomic.fna

# The name of FASTQ link
GENOME=genome.fa

# The number of reads
N=3342900

# Lengh of the reads
L=150

# The files to write the reads to
R1=reads/wgsim_read1.fq
R2=reads/wgsim_read2.fq

# Link to the new FASTQ file
LINK2=reads/

# Number of reads to sample
N2=10000

# SRR number
SRR=SRR1553606

# The output read names
R3=reads2/${SRR}_1.fastq
R4=reads2/${SRR}_2.fastq

# Trimmed read names
T1=reads2/${SRR}_1.trimmed.fastq
T2=reads2/${SRR}_2.trimmed.fastq

# The reads directory
RDIR=reads2

# The reports directory
PDIR1=report_before_fastp
PDIR2=report_after_fastp

#-- VARIABLE SETTINGS ABOVE THIS LINE--#

SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Print all possible targets
usage:
	@echo "Here are all targets you can run"
	@echo "make -f Makefile.mk info          # summary information on the genome"
	@echo "make -f Makefile.mk genome        # download the genome file and detail information"
	@echo "make -f Makefile.mk simulate      # simulate FASTQ output"
	@echo "make -f Makefile.mk download      # download reads from SRA, please put the SRR of paired-end sequencing"
	@echo "make -f Makefile.mk trim          # trim the reads"
	@echo "make -f Makefile.mk clean         # remove the downloaded files"
	@echo "make -f Makefile.mk all_simulate  # only run the targets related to simulating FASTQ output"
	@echo "make -f Makefile.mk all_trim      # only run the targets related to trimming the reads"
	@echo "make -f Makefile.mk all           # run all the targets"

# Print the summary information on the genome.
info:
	@datasets summary genome accession ${ACC} | jq

# This is how we make the genome.
${GFF}:
	datasets download genome accession ${ACC} --include gff3,gtf,genome
	# Never overwrite files when unzipping!
	unzip -n ncbi_dataset.zip
	ln -sf ${GFF} ${GENOME} # Make a link to a simpler name

# Downloads the genome file and get detail information of the genome.
genome: ${GFF}

	echo "Size of the FASTQ file is:"   # Get size of the file
	ls -lh ${GENOME}
	echo "Total size of the genome is at column sum_len:"  # Get total size of the genome
	seqkit stats ${GENOME}
	echo "Total number of chromosomes is:"  # Get number of chromosomes in the genome
	grep -c "^>" ${GENOME}
	echo "ID and length of each chromosome are:"  # Get name and length of each chromosome in the genome
	seqkit fx2tab -n -l ${GENOME}

# Simulate FASTQ output with wgsim
simulate:
	mkdir -p reads  # Make the directory that will hold the reads extracts
	# Simulate with no errors and no mutations
	wgsim -N ${N} -1 ${L} -2 ${L} -r 0 -R 0 -X 0 \
	  ${GENOME} ${R1} ${R2}
	seqkit stats ${R1} ${R2}  # Run read statistics
	echo "These FASTQ files' size are:" #  Get size of the new files
	ls -lh ${LINK2}
	gzip ${R1} ${R2} # Compress the files
	echo "These compressed FASTQ files' size are:" # Size of new compressed files
	ls -lh ${LINK2}

# Download reads from SRA
download:
	mkdir -p ${RDIR} ${PDIR1} ${PDIR2}  # Make the necessary directories
	fastq-dump -X ${N2} --split-files -O ${RDIR} ${SRR}  # Download the FASTQ file
	fastqc -q -o ${PDIR1} ${R3} ${R4}  # Run fastqc for initial FASTQ file

#Trim the downloaded reads
trim:
	# Run fastp and trim for quality
	# Auto-detection of adapter sequence for paired-end sequence by detect_adapter_for_pe
	# Auto-trim the first 20 bases to remove bias by trim_front1 and trim_front2
	# Set minimum qualified value for a base as 20 by qualified_quality_phred 
	# Filter reads shorter than 50 bases by length_required
	# Remove reads with low complexity by low_complexity_filter
	fastp --detect_adapter_for_pe --trim_front1 20 --trim_front2 20 \
	  --qualified_quality_phred 20 --length_required 50 --low_complexity_filter \
	  -i ${R3} -I ${R4} -o ${T1} -O ${T2}
	fastqc -q -o ${PDIR2} ${T1} ${T2}  # Run fastqc for post-fastp
	micromamba run -n menv multiqc -o ${PDIR2} ${PDIR2} # Run the multiqc from the menv environment on the reports directory
	micromamba run -n menv multiqc -o ${PDIR1} ${PDIR1}

# Cleanup the downloaded files.
clean:
	rm -rf ncbi_dataset/
	rm -f md5sum.txt ncbi_dataset.zip fastp.html fastp.json README.md elegans.fa
	rm -rf reads2/

# Only run the targets related to simulating FASTQ output
all_simulate: info genome simulate clean

# Only run the targets related to trimming the reads
all_trim: download trim clean

# Run all targets
all: info genome simulate download trim clean

# Mark the targets that do not create files.
.PHONY: usage info genome clean
