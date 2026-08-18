#fliter CircRNA by length
# This script can be used for both human and mouse circRNAs
#zhengjiayu
library(Biostrings)
#the human or mice circRNAs were download from https://www.circbase.org/cgi-bin/downloads.cgi
fasta_file = "input.fa"
sequences <- readDNAStringSet(fasta_file)

# Total number of sequences
total_sequences=length(sequences)

total_sequences


# Filter N sequences
sequences_no_N = sequences[!grepl("N", sequences, ignore.case = TRUE)]  # Ignore case for 'N'
sequences_with_N =sequences[grepl("N", sequences, ignore.case = TRUE)]  # Sequences containing 'N' or 'n'
num_sequences_with_N = length(sequences_with_N)
cat("Sequences removed: ", num_sequences_with_N, "\n")

# Filter sequences with length outside the range 100 to 4000，
#according to 
#"a spliced circular molecule can range from smaller than 100 to larger than 4000 nucleotides, 
#but the most common circRNAs in human cells are a few hundred nucleotides long."
#PMID: 34645386 PMCID: PMC8513298 DOI: 10.1186/s12859-021-04418-8

# Sequences out of range
sequences_out_of_range = sequences_no_N[width(sequences_no_N) < 100 | width(sequences_no_N) > 4000]

# Final filtered sequences
filtered_sequences = sequences_no_N[width(sequences_no_N) >= 100 & width(sequences_no_N) <= 4000]

# Number of sequences after filtering
num_out_of_range_sequences = length(sequences_out_of_range)

# Number of sequences after filtering
num_filtered_sequences = length(filtered_sequences)

num_filtered_sequences

# Save
writeXStringSet(filtered_sequences, "circRNAs.fa")