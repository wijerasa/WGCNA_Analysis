sizeGrWindow(8,9);
#which.module="cyan"
#which.module="greenyellow"
which.module="red"
ME=MEs[, paste("ME",which.module, sep="")]
par(mfrow=c(2,1), mar=c(0.3, 5.5, 3, 2))

plotMat(t(scale(datExprPetunia[,mergedColors==which.module ]) ),
        nrgcols=30,rlabels=F,rcols=which.module,
        main=which.module, cex.main=1, clabels=Names)
par(mar=c(1, 4.2, 0, 0.7))
barplot(ME, col=which.module, main="", cex.main=2,
        ylab="eigengene expression",xlab="array sample")