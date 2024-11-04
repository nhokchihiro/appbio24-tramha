This assignment requires writing a Makefile and a markdown report.

You can reuse the Makefile developed for your previous assignment, which generated a BAM file from SRA reads. You may need to get more data to obtain sufficient coverage over the genome. If the data shows no variants, find another dataset that does.

Call variants on the BAM file and discuss some information on the variants you found.

Your eye is an excellent variant caller.

Verify the variant caller's results by looking at a few example the alignments in the BAM file.

Find examples where the variant caller did not work as expected: false positives, false negatives, etc.

Go over a “checklist” and “score” the variant based on various characteristics.

How many reads carry the variant (depth)
Are the reads that carry variante on both strands
Is the variant evenly distributed across all positions
Is the coverage different around the variant
Is there another explanation that individually is not better, 
but overall across all reads would be better (this is a hard decision to make!)
