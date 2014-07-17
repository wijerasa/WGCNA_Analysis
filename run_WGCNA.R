#1. DATA INPUT###################################################################
#Load necessary libraries and set working directory to current project directory
source("init.R")

#Current working directory
cat(getwd())

#To enable multithreading type
#export  ALLOW_WGCNA_THREADS=<number_of_processors>
#in your linux bash shell

#Prepare data for WGCNA
source("prepare_data_4_wgcna.R")

#2. Cleaning and Preprocessing####################################################
#Checking for too may missing values
gsg = goodSamplesGenes(datExprPetunia, verbose = 3);
#gsg$allOK

#if the last statment is "TRUE" go to next step or else run foloowing code
if (!gsg$allOK)
{
  # Optionally, print the gene and sample names that were removed:
  if (sum(!gsg$goodGenes)>0)
    printFlush(paste("Removing genes:", paste(names(datExprPetunia)[!gsg$goodGenes], collapse = ", ")));
  if (sum(!gsg$goodSamples)>0)
    printFlush(paste("Removing samples:", paste(rownames(datExprPetunia)[!gsg$goodSamples], collapse = ", ")));
  # Remove the offending genes and samples from the data:
  datExprPetunia = datExprPetunia[gsg$goodSamples, gsg$goodGenes]
}


#3.Step-by-dtep network construction and module detection
#3.1 Soft-thresholding power
source("soft_threshold_power.R")

#Set the Soft Power
softPower = 16;

#3. Co-expression similarity and adjacency
#Following setps will take a place here
#Topology overlap Matrix
#Clustering using TOM
#Merging of modules whose expression profiles are very similar
source("gene_clustering.R")

###########################
######MM and GS identificaton
############################
source("mm_gs.R")

###########################
######haetmap plots of module expression
############################
source("heatmap_module_expression.R")

###########################
######module heatmap  and eigengene
############################

source("heatmap_eigengene_expression.R")



