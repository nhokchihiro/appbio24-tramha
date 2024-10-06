# Set the trace
set -uex

# Number of reads to sample
N=10000

# SRR number
SRR=SRR1553606

# The output read names
R1=reads/${SRR}_1.fastq
R2=reads/${SRR}_2.fastq

# Trimmed read names
T1=reads/${SRR}_1.trimmed.fastq
T2=reads/${SRR}_2.trimmed.fastq

# The reads directory
RDIR=reads

# The reports directory
PDIR1=report_before_fastp
PDIR2=report_after_fastp

# ----- actions below ----

# Make the necessary directories
mkdir -p ${RDIR} ${PDIR1} ${PDIR2}

# Download the FASTQ file
fastq-dump -X ${N} --split-files -O ${RDIR} ${SRR} 

# Run fastqc for initial FASTQ file
fastqc -q -o ${PDIR1} ${R1} ${R2}

# Run fastp and trim for quality
# Auto-detection of adapter sequence for paired-end sequence by detect_adapter_for_pe
# Auto-trim the first 20 bases to remove bias by trim_front1 and trim_front2
# Set minimum qualified value for a base as 20 by qualified_quality_phred 
# Filter reads shorter than 50 bases by length_required
# Remove reads with low complexity by low_complexity_filter

fastp --detect_adapter_for_pe --trim_front1 20 --trim_front2 20 \
      --qualified_quality_phred 20 --length_required 50 --low_complexity_filter \
      -i ${R1} -I ${R2} -o ${T1} -O ${T2}

# Run fastqc for post-fastp
fastqc -q -o ${PDIR2} ${T1} ${T2}

# Run the multiqc from the menv environment on the reports directory
micromamba run -n menv multiqc -o ${PDIR2} ${PDIR2}

micromamba run -n menv multiqc -o ${PDIR1} ${PDIR1}


