##################################################
## Project: CpG islands in FASTA files
## Script purpose:  Build a table with the Nucleotide Ref and the Number of CpGs in mtDNAs
##                  This script assumes that 
##                  the actual sequences of each mtDNA are downloaded via https://github.com/odinokov/MitoAge2FASTA
##                  and processed via Perl script to predict the number of CpG islands (CGIs) http://bioinfo2.ugr.es/CpGcluster/
##################################################
rm(list = ls())
setwd("D:/Dropbox/MitoAge/fasta")
dataFiles <- lapply(Sys.glob("*CpGcluster.txt-log.txt"), read.csv)
how_many_records <- length(dataFiles)
CpGs_table <- data.frame(Nucleotide_Ref = character(), Number_of_CpGs_in_sequence = character())
for(i in 1:how_many_records)
  {
  x <- names(dataFiles[[i]])
  ref_ID <- substr(x, nchar(x)-10, nchar(x))
  # get the number of CpGs
  CpGs <- toString(dataFiles[[i]][[1]][4])
  # get a FASTA length
  # toString(dataFiles[[i]][[1]][1:1])
  CpGs <- substring(CpGs, 29)
  CpGs_table <- rbind(CpGs_table, data.frame(Nucleotide_Ref = ref_ID, Number_of_CpGs_in_sequence = CpGs))
  }
write.csv(CpGs_table, file="all_CpGs_from_fasta.csv")
