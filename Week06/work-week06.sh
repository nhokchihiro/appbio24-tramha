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

# Run fastqc
fastqc -q -o ${PDIR1} ${R1} ${R2}

# Run fastp and trim for quality
# There is a substantial difference between --cut_tail vs --cut_right
# both trim in a window but one goes from the right and the other from the left

fastp --detect_adapter_for_pe --trim_front1 20 --trim_front2 20 \
      --qualified_quality_phred 20 --length_required 50 --low_complexity_filter \
      -i ${R1} -I ${R2} -o ${T1} -O ${T2}

# Run fastqc
fastqc -q -o ${PDIR2} ${T1} ${T2}

# Assumes that you have installed multiqc like so
# conda create -y -n menv multiqc 

# Run the multiqc from the menv environment on the reports directory
micromamba run -n menv multiqc -o ${PDIR2} ${PDIR2}

