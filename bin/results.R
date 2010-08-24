args <- commandArgs(trailingOnly = TRUE)
infile <- args[1]
counts <- read.csv(infile, head=FALSE) 
summary(counts$V2)
