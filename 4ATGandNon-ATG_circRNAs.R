#zhengjiayu
# This script can be used for both human and mouse circRNAs
#Figure 1C & S1D
library(Biostrings)

# Attention: input sequences must be duplicated before input to identify junction sequences containing AUG
fasta_file = ""#input dobuling circRNA file from previous step
output_atg_names = "atg_sequence_names.txt"  # Output file for ATG sequence names
output_non_atg_names = "non_atg_sequence_names.txt"  # Output file for non-ATG sequence names

# Read circRNA file
sequences =readDNAStringSet(fasta_file)

# make empty vectors for atg and non-atg circRNAs
atg_names = c()
non_atg_names = c()

# a loop to process each sequence
for (i in seq_along(sequences)) {
  seq <- sequences[i]
  seq_name <- names(seq)
 # Check if the sequence contains "ATG"
  if (grepl("ATG", as.character(seq), ignore.case = TRUE)) {
    atg_names <- c(atg_names, seq_name)
  } else {
    non_atg_names <- c(non_atg_names, seq_name)
  }
}

# save thecircRNA seq
writeLines(atg_names, output_atg_names)
writeLines(non_atg_names, output_non_atg_names)

#report
report_file ="ATG_Non-ATGcircRNA_report.txt"
total_sequences =length(sequences)
total_atg = length(atg_names)
total_non_atg = length(non_atg_names)
report_content = c(
  "classify reports(AUGcircRNA & Non-AUG circRNAs)",
  paste("input file path:", fasta_file),
  paste("total circRNAAs", total_sequences),
  paste("num. AUG circRNAs:", total_atg),
  paste("num. non-AUG circRNAs:", total_non_atg)
)
#save report
writeLines(report_content, report_file)