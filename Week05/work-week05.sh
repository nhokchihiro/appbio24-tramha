# Set the trace to show the commands as executed
set -uex

# Species RefSeq numnber
GCF="GCF_000002985.6"

# The name of FASTQ link
GENOME="elegans.fa"

# Link to the main file
LINK=ncbi_dataset/data/GCF_000002985.6/GCF_000002985.6_WBcel235_genomic.fna

# The number of reads
N=3342900

# Lengh of the reads
L=150

# The files to write the reads to
R1=reads/wgsim_read1.fq
R2=reads/wgsim_read2.fq

# ------ NO CHANGES NECESSARY BELOW THIS LINE ------

# Download the genome
datasets download genome accession ${GCF}

# Unpack the data (Overwrite files if they already exist)
unzip -o ncbi_dataset.zip

# Make a link to a simpler name
ln -sf ${LINK} ${GENOME}

# Question 1:

# Get size of the file
echo " "
echo "Size of the FASTQ file is:"
ls -lh ${LINK}

# Get total size of the genome
echo " "
echo "Total size of the genome is at column sum_len:"
seqkit stats ${GENOME}

# Get number of chromosomes in the genome
echo " "
echo "Total number of chromosomes is:"
grep -c "^>" ${GENOME}

# Get name (id) and length of each chromosome in the genome
echo " "
echo "ID and length of each chromosome are:"
awk '/^>/ {if (seqlen) {print chrom, seqlen}; chrom=$0; seqlen=0; next} {seqlen += length($0)} END {print chrom, seqlen}' ${GENOME}

# Question 2: Simulate FASTQ output with wgsim. Target coverage is 10

# Make the directory that will hold the reads extracts 
# the directory portion of the file path from the read
mkdir -p $(dirname ${R1})

# Simulate with no errors and no mutations
wgsim -N ${N} -1 ${L} -2 ${L} -r 0 -R 0 -X 0 \
      ${GENOME} ${R1} ${R2}

# Run read statistics
seqkit stats ${R1} ${R2}

# Compress the files
gzip ${R1} ${R2}

echo "Thank you."