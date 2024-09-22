Your submission should be a link to a GitHub folder that contains a script and a report written in Markdown, all committed to your repository.

# Part 1: Write a script



In a previous assignment, you wrote a Markdown report on processing a GFF file to count feature types.

Rewrite all the code from that report as a Bash script. Your script should be:

1. Reusable: separate variable definitions from the code.
2. Documented: include comments that explain what each part of the script does.


```
code work-week04.sh
```

```
# Set the error handling and trace
set -uex

# Define all variables at the top.

# The URL of the file
URL="https://ftp.ensembl.org/pub/current_gff3/bubo_bubo/Bubo_bubo.BubBub1.0.112.gff3.gz"

# The name of the file
FILE="Bubo_bubo.BubBub1.0.112.gff3"

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
cat ${FILE} | grep -v '^#'| wc -l  

# C. Sequence regions (chromosomes) extraction
# Extract sequence regions (chromosomes) number from file
cat ${FILE} | grep '##sequence-region'| wc -l

# D. Listed genes extration
# Make a new GFF file with only the features of type gene
cat ${FILE} | awk '$3 == "gene"' > ${GENES}

# Print the number of genes
cat ${GENES} | wc -l

# E. Top-ten most annotated feature types (column 3) extraction
# Extract top-ten most annotated features from file
cat ${FILE} | cut -f 3 | grep -v "^#" | sort | uniq -c | sort -rn | head -10

# Count the pseudogene
cat ${FILE} | grep -w "pseudogene" | wc -l
```

Run your script on your original data and verify that it works. You were also assigned to review someone else's report.

```
bash work-week04.sh
```

Now, run your script on their data. If the script is reusable, you can replace your variables with theirs and run the script. 

Add more functions to the script that also print some of their results. Were you able to reproduce their results? Make a note in the report.

Commit the script to your repository.

# Part 2: Make use of ontologies

Lecture: Sequence OntologyLinks to an external site.



```
# Update the bio package
pip install bio --upgrade

# Download the latest database
bio --download

# Use bio to explain a term
bio explain gene
```

```
# Install genescape
pip install genescape

# Run genescape
genescape web
```

```
conda activate bioinfo 
```

```
bio explain mrna
```

```
# mrna
bio explain mrna --lineage
```

Choose a feature type from the GFF file and look up its definition in the sequence ontology.
Find both the parent terms and children nodes of the term.
Provide a short discussion of what you found.

mrna SO:0000234
Parent terms:  SO:0000233  mature_transcript

Children nodes:
- riboswitch (part_of)
- mrna_with_frameshift 
- attenuator (part_of)
- est (derives_from)
- polya_sequence (adjacent_to)
- monocistronic_mrna 
- polycistronic_mrna 
- exemplar_mrna 
- mrna_region (part_of)
- capped_mrna 
- polyadenylated_mrna 
- trans_spliced_mrna 
- edited_mrna 
- consensus_mrna 
- nsd_transcript 
- rna_thermometer (part_of)
- circular_mrna 
- recoded_mrna

Definition: Messenger RNA is the intermediate molecule between DNA and protein. It includes UTR and coding sequences. It does not contain introns.

Discussion: 

 ![hierarchy image](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/mrna-ontology.png).

Here is [the folder](https://github.com/nhokchihiro/appbio24-tramha/tree/main/Week04) containing my script and the report.

