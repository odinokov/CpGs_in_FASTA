##################################################
## Project: CpG islands in FASTA files
## Script purpose:  Build a table with the Nucleotide Ref and the Number of CpGs in mtDNAs
##                  R script to get the actual sequences of each mtDNA https://github.com/odinokov/MitoAge2FASTA
##                  Perl script to predict the number of CpG islands (CGIs) http://bioinfo2.ugr.es/CpGcluster/
##                  system('perl CpGcluster.pl ./fasta/ 50 0.00005')
##################################################
rm(list = ls())
setwd("D:/Dropbox/MitoAge/fasta")
# read CpGcluster results
dataFiles <- lapply(Sys.glob("*CpGcluster.txt-log.txt"), read.csv)
how_many_records <- length(dataFiles)
CpGs_table <- data.frame(Nucleotide_Ref = character(), Number_of_CpGs_in_sequence = numeric(), Sequence_Length = integer(), CpG_ratio = numeric())
for(i in 1:how_many_records)
{
  x <- names(dataFiles[[i]])
  ref_ID <- substr(x, nchar(x)-10, nchar(x))
  # get the number of CpGs
  CpGs <- toString(dataFiles[[i]][[1]][4])
  CpGs <- substring(CpGs, 29)
  # get the sequence length
  sequence_length <- toString(dataFiles[[i]][[1]][1:1])
  sequence_length <- substring(sequence_length, 9)
  # get the ratio CpGs/sequence length
  ratio <- 2 * as.numeric(CpGs) / as.numeric(sequence_length)
  CpGs_table <- rbind(CpGs_table, data.frame(Nucleotide_Ref = ref_ID, Number_of_CpGs_in_sequence = CpGs, Sequence_Length = sequence_length, CpG_ratio = ratio))
}
write.csv(CpGs_table, file="all_CpG_data_from_fasta.csv")
