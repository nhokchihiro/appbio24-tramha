SSR number: SRR1553606
Sequencing instrument: Illumina HiSeq 2500
Title: SRX674267 - Zaire ebolavirus genome sequencing from 2014 outbreak in Sierra Leone

1. Write a script to download data from the SRA database.

```
# Set the variables

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
```

```
# Download the FASTQ file
fastq-dump -X ${N} --split-files -O ${RDIR} ${SRR}
```

```
# Run fastqc
fastqc -q -o ${PDIR1} ${R1} ${R2}
```

2. Evaluate the quality of the downloaded data.
3. Improve the quality of the reads in the dataset.

```
# Run fastp and trim for quality
# Auto-detection of adapter sequence for paired-end sequence by detect_adapter_for_pe
# Auto-trim the first 20 bases to remove bias by trim_front1 and trim_front2
# Set minimum qualified value for a base as 20 by qualified_quality_phred 
# Filter reads shorter than 50 bases by length_required
# Remove reads with low complexity by low_complexity_filter

fastp --detect_adapter_for_pe --trim_front1 20 --trim_front2 20 \
      --qualified_quality_phred 20 --length_required 50 --low_complexity_filter \
      -i ${R1} -I ${R2} -o ${T1} -O ${T2}
```

4. Evaluate the quality again and document the improvements.

```
# Run the multiqc from the menv environment on the reports directory
micromamba run -n menv multiqc -o ${PDIR2} ${PDIR2}
```

Your script should include all necessary code. The markdown report should explain the data and publication it corresponds to and present the results of your analysis.
