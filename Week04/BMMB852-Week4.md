Your submission should be a link to a GitHub folder that contains a script and a report written in Markdown, all committed to your repository.

# Part 1: Write a script

1. To generate the new Bash script:

```
code work-week04.sh
```

2. To run the script on terminal:
Run your script on your original data and verify that it works. You were also assigned to review someone else's report.

```
bash work-week04.sh
```

![my result](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/my_species.png).

Now, run your script on their data. If the script is reusable, you can replace your variables with theirs and run the script. 

![Jessica Nicole Eckard](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/Jessica_species.png).

![Md. Mahib Ullah](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/Md_species.png).

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

