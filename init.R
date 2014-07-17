WORKING_DIR="./"
##Load R Libraries and Set working directory path" ###
library(WGCNA)
library(cluster)
options(stringsAsFactors = FALSE)
allowWGCNAThreads()
#export ALLOW_WGCNA_THREADS=10
setwd(WORKING_DIR)

