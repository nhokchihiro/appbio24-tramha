This assignment requires writing a Makefile and a markdown report.

Use the Makefile developed for your previous assignment that contains rules for simulating reads and obtaining reads from SRA.

Make a new version of the Makefile that includes rules for aligning reads to a reference genome.

Add new targets called index and align to the Makefile.

The index target should create an index for the reference genome. The align target should align the reads to the reference genome. The output of the align target should be a sorted, indexed BAM alignment file.

Visualize the resulting BAM files for your simulated reads and the reads downloaded from SRA.

Generate alignment statistics for the reads from both sources, simulated and SRA.

Briefly describe the differences between the two datasets.

The default paramters are set to:

GCF_004799605: Halobacterium salinarum, collection date: 1934 (add link)
SRR28572035: Halobacterium salinarum strain:KBTZ01, collection date: 2021

GCF_000848505.1 Zaire ebolavirus genome assembly ViralProj14703 collection date:1976, assembly 2000
https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_000848505.1/
 
SRR1553606 Zaire ebolavirus genome sequencing from 2014 outbreak in Sierra Leone 	2014,  2014-08-19
https://www.ncbi.nlm.nih.gov/sra/SRR1553606
