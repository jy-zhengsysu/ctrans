# GC%
#zheng jiayu
# Figure 1D & S1E 
library(Biostrings)

# input
fasta_file = "extracted_non_atg_sequences.fa"
sequences = readDNAStringSet(fasta_file)


gc_counts = letterFrequency(sequences, letters = c("G", "C")) #Count GC
gc_counts

total_bases = width(sequences)  # circRNA length
total_bases

gc_content = rowSums(gc_counts)/total_bases*100

gc_content_df = data.frame(
  Sequence_Name = names(sequences),
  GC_percentage = gc_content
)

head(gc_content_df)

#save
write.csv(gc_content_df, file = "gc_extracted_non_atg_sequences.csv", row.names=F)