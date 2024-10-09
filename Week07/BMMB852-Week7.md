This assignment requires writing a Makefile and a markdown report.

In the previous assignments you were asked to write a scripts to simulate reads and in the second assignment yo wrote a script to obtain and trim reads for a realistic dataset.

Merge both scripts into a single Makefile. The makefile should have the following targets:

usage - Print the help
genome - Download the genome
simulate - Simulate reads for the genome
download - Download reads from SRA
trim - Trim reads
Add additional targets you think would be useful.

Have your makefile generate fastqc reports upon downloading and trimming data.

The report should explain how the makefile works and how to run it to achieve the various tasks. You don't have to include the plots in the report since you have already done that before.

Use variables in your Makefile. Here are some recommendations:

R1 - The first read file 
R2 - The second read file
SRR - The accession number at SRA
ACC - The accession number for the genome (if applicable) use URL if obtaining data from Ensembl.
GENOME - The resulting genome file 
N - The number of reads to simulate or download
