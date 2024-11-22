This assignment requires the presence of a Makefile, a README.md markdown file, and a design.csv file.

Please add all three files to your repository and submit the link to your repository.

You may reuse the Makefile created in previous assignments.

Create a Makefile that can produce a VCF file by downloading a reference genome, indexing it, and then downloading fastq files from SRA, aligning them to the reference and calling variants.
Create a README.md file that explains how to run the Makefile
Collect a set of samples from the SRA database that match your genome.
Create a design.csv file that lists the samples to be processed.
Using GNU parallel or any other method of your choice run the Makefile on all (or a a subset) of the samples
Merge the resulting VCF files into a single one.
Discuss what you see in your VCF file.
