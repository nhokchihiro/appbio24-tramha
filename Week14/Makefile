#
# An RNA-Seq analysis from RNA-seq count simulations.
#

#----

# Custom makefile settings.
SHELL = bash
.ONESHELL:
.SHELLFLAGS = -eu -o pipefail -c
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

# Print the usage of the makefile.
usage:
	@echo "#"
	@echo "# RNA-Seq analysis from count simulations"
	@echo "#"
	@echo "# Design file = design.csv"
	@echo "# Simulated count file = counts.csv"
	@echo "#"
	@echo "# make simulate      # create the design and simulated count files."
	@echo "# make analysis      # conduct differential expression based on design.csv and counts.csv."
	@echo "# make plot          # generate PCA plot and heatmap."
	@echo "# make all           # proceed all the targets."
	@echo "# make clean         # clean all files after every run."
	@echo "#"

# Create the design and simulated count files.
simulate:
	mkdir -p files

	# Generate two groups of samples, each has 4 duplicates and 40,000 genes.
	Rscript src/r/simulate_counts.r -n 40000 -r 4 -d files/design.csv -o files/counts.csv

# Conduct differential expression based on design.csv and counts.csv.
analysis:
	Rscript src/r/deseq2.r -d files/design.csv -c files/counts.csv -o files/deseq2.csv
	Rscript src/r/evaluate_results.r -a files/counts.csv -b files/deseq2.csv -o files/summary.csv

# Generate PCA plot and heatmap.
plot:
	#Create the folder plots.
	mkdir -p plots

	#Generate PCA plot and heatmap.
	src/r/plot_pca.r -d files/design.csv -c files/deseq2.csv -o plots/pca.pdf
	src/r/plot_heatmap.r -d files/design.csv -c files/deseq2.csv -o plots/heatmap.pdf

# Run all the steps.
all: simulate analysis plot
	@echo "The progress is completed. Thank you!"

# Remove all the generated files.
clean:
	rm -rf files/ plots/
	@echo "All created files are removed. Thank you!"

# These targets do not correspond to files.
.PHONY: usage simulate analysis plot all clean
