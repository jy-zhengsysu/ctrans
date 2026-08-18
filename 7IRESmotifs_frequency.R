#zhengjiayu
## This script can be used for both human and mouse circRNAs, and both AUG and Non-AUG circRNAs
# Figure 1F,1G,S1G,S1H&S2A

library(Biostrings)

# Motif set: IRES positive sequences from Prof. Wang Zefeng, reference:https://doi.org/10.1038/s41467-022-31327-y
motifs <- c()

# Input CircRNA seq
fasta_file = ".fa"
sequences =readDNAStringSet(fasta_file)

# circRNA length
circRNA_length =width(sequences)

# extract junction sequences
# last 5 nt + first 5 nt, we have filte the length, and no circRNA legth < 6nt

junction_sequences <- DNAStringSet(
  paste0(
    substring(as.character(sequences),
              circRNA_length - 4,
              circRNA_length),
    substring(as.character(sequences),
              1,
              5)
  )
)

names(junction_sequences) <- names(sequences)

#count motifs
motif_counts_list = lapply(motifs, function(m){
  linear_counts = vcountPattern(m, sequences)
  junction_counts = vcountPattern(m, junction_sequences)
  linear_counts + junction_counts
})

#as.data.frame
motif_counts_mat = do.call(cbind, motif_counts_list)
motif_counts_df  = as.data.frame(motif_counts_mat)

colnames(motif_counts_df) = motifs
rownames(motif_counts_df) = names(sequences)

#set matrix
motif_counts_df$circRNA_length = circRNA_length

motif_counts_df$total_IRES_motifs <-
  rowSums(motif_counts_df[, motifs])

motif_counts_df$IRES_motif_density <-
  motif_counts_df$total_IRES_motifs /
  motif_counts_df$circRNA_length
#save
write.csv(
  motif_counts_df,
  ".csv",
  row.names = T
)