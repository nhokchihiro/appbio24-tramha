**SSR number:** SRR1553606

**Sequencing instrument:** Illumina HiSeq 2500

**Title:** SRX674267 - Zaire ebolavirus genome sequencing from 2014 outbreak in Sierra Leone


### 1. Write a script to download data from the SRA database

**a. To set the variables:**

```
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

**b. To download the FASTQ files and run initial quality control:**

```
# Download the FASTQ file
fastq-dump -X ${N} --split-files -O ${RDIR} ${SRR}

# Run fastqc
fastqc -q -o ${PDIR1} ${R1} ${R2}
```

### 2. Evaluate the quality of the downloaded data

Summary of both files: 
- Both files have the Warnings for Adapter content (higher amount at the tails), meaning there are adapter sequences in more than 5% of all reads.
- Both files have different Warnings and Failures for each category.

![Image1](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image1.png)

**a. Evaluation of File 1:**
- Per base sequence content: Failure - The sequence contents of A, T, C, G fluctuates strongly across the reads and there are some points the difference between A and T and G and C is more than 20% (position 9 bp, or 2 bp).

![Image2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image2.png)

- Per sequence GC content: Warning - The total deviations from the theoretical distribution is more than 15% but less than 30% across all reads.

![Image3](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image3.png)

- Overrepresented sequences: Failure - There are 11 sequences are found to appear more than 15% of the read.

![Image4](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image4.png)

- Adapter Content: Warning (as describe above)

![Image5](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image5.png)

**b. Evaluation of File 2:**
- Per base sequence quality: Failure - The sequence quality decreases, especially at the final of the reads. Average quality scores are from 25-30.

![Image6](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image6.png)

- Per base sequence content: Failure - The sequence contents of A, T, C, G fluctuates, especially of the first ten bps of the reads.

![Image7](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image7.png)

- Per sequence GC content: Failure - Mean GC content is strongly different to the theoretical distribution, with the total of deviations is up to 30%.

![Image8](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image8.png)

- Adapter Content: Warning (as describe above)

![Image9](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image9.png)

### 3. Improve the quality of the reads in the dataset

**a. Run the code below to conduct the quality control process:**

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

**b. To test the quality control command of each FASTQ file:**

```
# Run fastqc for post-fastp
fastqc -q -o ${PDIR2} ${T1} ${T2}
```

### 4. Evaluate the quality again and document the improvements

**a. Comparision between before-fastp and post-fastp process:**

- File 1:

*Per base sequence content:* from Failure to Good

![Image10](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image10.png)

*Per sequence GC content:* still Warning 

![Image11](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image11.png)

*Overrepresented sequences:* from Failure to Good 

![Image12](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image12.png)

*Adapter Content:* from Warning to Good

![Image13](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image13.png)

*Sequence Length Distribution:* from Good to Warning

![Image18](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image18.png)


- File 2:

*Per base sequence quality:* from Failure to Good 

![Image14](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image14.png)

*Per base sequence content:* from Failure to Good 

![Image15](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image15.png)

*Per sequence GC content:* from Failure to Warning

![Image16](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image16.png)

*Adapter Content:* from Warning to Good

![Image17](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image17.png)

*Sequence Length Distribution:* from Good to Warning

![Image19](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image19.png)


**b. Evaluation for final improvements of both FASTQ files:**

- Run the code below to get the results:

```
# Run the multiqc from the menv environment on the reports directory
micromamba run -n menv multiqc -o ${PDIR2} ${PDIR2}
```

- Evaluation:

  Almost all failured- and warned- issues from both files are solved, except the Per sequence GC content and Sequence Length Distribution are evaluated as Warnings.
  
  I utilized several different QC methods, including cutadapt, yet it seems that the Per sequence GC content cannot be improved more. Reasons could be due to the preparation steps or natural characteristics of this virus.
  
  The changes in Sequence Length Distribution post-QC perhaps due to the trim and filter steps removed some shorter reads - which actually improved other measurements but also lower Sequence length distribution.
  
  These issues should be investigated more.
  
  Overall, my QC process by fastp improved almost the crucial categories in comparing to the original FASTQ files. This is the summary of status checks - the upper image is of the original FASTQ files, the lower image is of the trimmed FASTQ files.

![Image20](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week06/Images/Image20.png)
  


