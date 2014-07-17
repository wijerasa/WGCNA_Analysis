VSD_DATA<- "./data/libraries_resFilt.csv" #

#Read in the Petunia VSD (Variance Stabalize data) data set
expressed_genes_dataF = read.table(VSD_DATA, header=TRUE,row.names=1)


#Remove gene information and transpose the expression data
datExprPetunia=as.data.frame(t(expressed_genes_dataF))