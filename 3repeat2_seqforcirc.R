# This program generates duplicated circRNA sequences for identifying AUG-containing circRNAs
# This script can be used for both human and mouse circRNAs
#package require
#zhengjiayu

library(Biostrings)

# read fasta
fasta_file = "filtered_hg19_circRNAs.fa" #the fata flie from last step
sequences = readDNAStringSet(fasta_file)

# to create a function doubling the circRNA sequences form the line sequece
h19circR2seq <- DNAStringSet(sapply(sequences, function(seq) {
  concatenated_seq <- paste0(as.character(seq), as.character(seq))
  return(DNAString(concatenated_seq))
}))

# used the same seq Name
names(h19circR2seq) <- names(sequences)

# save the doubling seqs
output_file = "repeat2_filtered_hg19_circRNAs.fa"
writeXStringSet(h19circR2seq, filepath = output_file)