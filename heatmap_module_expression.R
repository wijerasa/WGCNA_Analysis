#Haetmap plots of module expression
modColour=c("red","cyan","grey60")
sizeGrWindow(8,9)
par(mfrow=c(length(modColour),1), mar=c(1, 2, 4, 1))

for (colour in modColour )
{


which.module=colour
plotMat(t(scale(datExprPetunia[,mergedColors==which.module ]) ),nrgcols=30,rlabels=T,
        clabels=T,rcols=which.module,
        title=which.module )
}
#table(dynamicColors)
#write.csv(table(dynamicColors), file="contigs_per_color_pre-merge.csv")
#table(mergedColors)
#write.csv(table(mergedColors), file="contigs_per_color_post-merge.csv")