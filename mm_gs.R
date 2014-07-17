###########################
######MM and GS identificaton
############################
# names (colors) of the modules
modNames = substring(names(MEs), 3)
geneModuleMembership = as.data.frame(cor(datExprPetunia, MEs, use = "p"));
nGenes = ncol(datExprPetunia);
nSamples = nrow(datExprPetunia);
MMPvalue = as.data.frame(corPvalueStudent(as.matrix(geneModuleMembership), nSamples));
names(geneModuleMembership) = paste("MM", modNames, sep="");
names(MMPvalue) = paste("p.MM", modNames, sep="");