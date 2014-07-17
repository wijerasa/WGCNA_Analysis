#Calculate adjacencies
adjacencyP = adjacency(datExprPetunia, power = softPower, type=NETWORKTYPE);

#Topological Overlap Matrix (TOM)
TOM = TOMsimilarity(adjacencyP, TOMType=NETWORKTYPE, verbose=1);
#TOM=TOMsimilarityFromExpr(datExprPetunia,power=softPower,corType="bicor", networkType="signed", TOMType="signed", nThreads=20, verbose=5)
dissTOM = 1-TOM

#Clustering using TOM
# Call the hierarchical clustering function
geneTree = flashClust(as.dist(dissTOM), method = "average");

# Plot the resulting clustering tree (dendrogram)
sizeGrWindow(12,9)
plot(geneTree, xlab="", sub="", main = "Gene clustering on TOM-based dissimilarity",
     labels = FALSE, hang = 0.04);

# We like large modules, so we set the minimum module size relatively high:
MIN_MODULE_SIZE=30
DEEP_SPLIT=0

# Module identification using dynamic tree cut:
dynamicMods = cutreeDynamic(dendro = geneTree, distM = dissTOM,
                            deepSplit = DEEP_SPLIT, pamRespectsDendro = FALSE,
                            minClusterSize = MIN_MODULE_SIZE);
table(dynamicMods)

# Convert numeric lables into colors
dynamicColors = labels2colors(dynamicMods)
table(dynamicColors)

# Plot the dendrogram and colors underneath
sizeGrWindow(8,6)
plotDendroAndColors(geneTree, dynamicColors, "Dynamic Tree Cut",
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05,
                    main = "Gene dendrogram and module colors")
#Merging of modules whose expression profiles are very similar
# Calculate eigengenes
MEList = moduleEigengenes(datExprPetunia, colors = dynamicColors)
MEs = MEList$eigengenes
# Calculate dissimilarity of module eigengenes
MEDiss = 1-cor(MEs);
# Cluster module eigengenes
METree = flashClust(as.dist(MEDiss), method = "average");
# Plot the result
sizeGrWindow(7, 6)
plot(METree, main = "Clustering of module eigengenes",xlab = "", sub = "")

#We choose default tree height cut of 0.25
MEDISSTHRES = 0.25
# Plot the cut line into the dendrogram
abline(h=MEDISSTHRES, col = "red")
# Call an automatic merging function
merge = mergeCloseModules(datExprPetunia, dynamicColors, cutHeight = MEDISSTHRES, verbose = 3)
# The merged module colors
mergedColors = merge$colors;
# Eigengenes of the new merged modules:
mergedMEs = merge$newMEs;

sizeGrWindow(12, 9)
#pdf(file = "Plots/geneDendro-3.pdf", wi = 9, he = 6)
plotDendroAndColors(geneTree, cbind(dynamicColors, mergedColors),
                    c("Dynamic Tree Cut", "Merged dynamic"),
                    dendroLabels = FALSE, hang = 0.03,
                    addGuide = TRUE, guideHang = 0.05)

# Rename to moduleColors
moduleColors = mergedColors
# Construct numerical labels corresponding to the colors
colorOrder = c("grey", standardColors(50));
moduleLabels = match(moduleColors, colorOrder)-1;
MEs = mergedMEs;


# Save module colors and labels for use in subsequent parts
save(MEs, moduleLabels, moduleColors, geneTree, file = "Petunia-networkConstruction-stepByStep.RData")
