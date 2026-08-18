# the atg and non-atg circRNA seq Name had been extracted in 4ATGandNon-ATG_circRNAs.R
# This script can be used for both human and mouse circRNAs
#zhengjiayu
library(Biostrings)


total.circ = ""# the total  .fa file

# Read sequence names from text files，the last step out
atg_names = readLines("atg_sequence_names.txt")
non_atg_names = readLines("non_atg_sequence_names.txt")

total.circ = readDNAStringSet(total.circ)

#Extract corresponding sequences from the new DNAStringSet
sequences_atg = total.circ[names(total.circ) %in% atg_names]
sequences_non_atg = total.circ[names(total.circ) %in% non_atg_names]

# Save seqs
writeXStringSet(sequences_atg, filepath = "extracted_atg_sequences.fa")
writeXStringSet(sequences_non_atg, filepath = "extracted_non_atg_sequences.fa")
