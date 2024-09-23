# Part 1: Write a script

**1. To generate the new Bash script:**

```
# generate new bash script
code work-week04.sh
```

**2. To run the script on terminal:**

```
# run the script file
bash work-week04.sh
```

a. Results with my species: *Bubo bubo*

![my result](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/my_species.png)

[My script file](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/work-week04.sh)

b. Results with peer-review 1 (Jessica Nicole Eckard): *Salmo trutta*

![Jessica Nicole Eckard](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/Jessica_species.png)

[Script file 1](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/peer-review/work-week04_Jessica.sh)

c. Results with peer-review 2 (Md. Mahib Ullah): *Nannospalax galili*

![Md. Mahib Ullah](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/Md_species.png)

[Script file 2](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/peer-review/work-week04_Md.sh)

# Part 2: Make use of ontologies

**Use Bio to explain mRNA ontology:**

a. Normal command:

```
# explain mRNA
bio explain mrna
```

Results:

 ![mRNA](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/mRNA.png)

b. Command to explain as a lineage:

```
# explain mRNA as a lineage
bio explain mrna --lineage
```

Results:

 ![mRNA_lineage](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/mrna_lineage.png)

**3. Answers:**
   
***mRNA SO:***   0000234

***Definition:*** Messenger RNA is the intermediate molecule between DNA and protein. It includes UTR and coding sequences. It does not contain introns.

***Parent terms:***  SO:0000233  mature_transcript

***Children nodes:***
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

***Discussion:*** It is interesting that there are many types of mRNA which I never learned before (e.g. monocistronic_mrna, capped_mrna,...). It somehow determines the a important role of mRNA in understanding gene expression and the functional genomics. And this ontology is definitely beneficial for us in undertsanding well the definition of all genomic terms.

![hierarchy image](https://github.com/nhokchihiro/appbio24-tramha/blob/main/Week04/Images/mrna-ontology.png).

*Here is [my folder](https://github.com/nhokchihiro/appbio24-tramha/tree/main/Week04) containing the script and the Markdown file.*

