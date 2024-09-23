# Set the error handling and trace
set -uex

# Define all variables at the top.

# 1. The URL of the files
# My species
#URL="https://ftp.ensembl.org/pub/current_gff3/bubo_bubo/Bubo_bubo.BubBub1.0.112.gff3.gz"

# Peer-review 1: Jessica Nicole Eckard
#URL="https://ftp.ensembl.org/pub/current_gff3/salmo_trutta/Salmo_trutta.fSalTru1.1.112.gff3.gz"

# Peer-review 2: Md. Mahib Ullah
URL="https://ftp.ensembl.org/pub/current_gff3/nannospalax_galili/Nannospalax_galili.S.galili_v1.0.112.gff3.gz"

# 2. The name of the file

#My species
#FILE="Bubo_bubo.BubBub1.0.112.gff3"

# Peer-review 1: Jessica Nicole Eckard
#FILE="Salmo_trutta.fSalTru1.1.112.gff3"

# Peer-review 2: Md. Mahib Ullah
FILE="Nannospalax_galili.S.galili_v1.0.112.gff3"

# 3. The name of file extraction only for gene features
GENES="genes.gff" 

# ------ ALL THE ACTIONS FOLLOW ------

# List all the actions here.

# Download the gff3 file if it doesn't exist
if [ ! -f ${FILE} ]; then
    wget ${URL} -O ${FILE}.gz
fi

# Unzip the file and keep the original
gunzip -k ${FILE}.gz

# B. Features extraction
# Extract feature number from file
NUM_FEATURES=$(cat ${FILE} | grep -v '^#'| wc -l)

# C. Sequence regions (chromosomes) extraction
# Extract sequence regions (chromosomes) number from file
NUM_SEQREG=$(cat ${FILE} | grep '##sequence-region'| wc -l)

# D. Listed genes extration
# Make a new GFF file with only the features of type gene
cat ${FILE} | awk '$3 == "gene"' > ${GENES}

# Print the number of genes
NUM_GENES=$(cat ${GENES} | wc -l)

# E. Top-ten most annotated feature types (column 3) extraction
# Extract top-ten most annotated features from file
TOP_TEN=$(cat ${FILE} | cut -f 3 | grep -v "^#" | sort | uniq -c | sort -rn | head -10)

# Count the pseudogene
NUM_PSEU=$(cat ${FILE} | grep -w "pseudogene" | wc -l)

# Count the CDS
NUM_CDS=$(cat ${FILE} | grep -w 'CDS' | wc -l)

# List top 10 mRNA
TOP_mRNA=$(cat ${FILE} | grep -w 'mRNA' | head -n 10)

# Print the outputs
echo " "
echo "Here are the final results."
echo "The number of features is ${NUM_FEATURES}"
echo "The number of sequence regions is ${NUM_SEQREG}"
echo "The number of genes is ${NUM_GENES}"
echo "The top-ten most annotated features are ${TOP_TEN}"
echo "The number of pseudogenes is ${NUM_PSEU}"
echo "The number of CDS is ${NUM_CDS}"
echo "Here are the first ten lines of mRNA: ${TOP_mRNA}"
echo "Thank you."
