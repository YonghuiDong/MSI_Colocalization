# This script provides 3 different ways to reduce the total data analysis time;
# Examples are given on Rutin
library(Cardinal)
library(BiocParallel)
load("Result/MG_processed.rda")

## Method 1: Reduce the number of features, up to m/z 650
MG650 <- MG2[mz(MG2) < 650,]
coloc_611 <- colocalized(MG650, mz= 611.161, n = 100, BPPARAM = SerialParam())
save(coloc_611, file = "Result/coloc_611_upto650.rda", compress = "xz")

## Method 2: 
##(2.1) subset every 100 pixel
pixel = dim(MG2@elementMetadata)[1]
MG_sub100 <- MG2[, c(seq(1, pixel, 100))]
coloc_611_sub100 <- colocalized(MG_sub100, mz= 611.161, n = 100, BPPARAM=SerialParam())
save(coloc_611_sub100, file = "Result/coloc_611_sub100.rda", compress = "xz")

##(2.2) subset every 10 pixel
MG_sub10 <- MG2[, c(seq(1, pixel, 10))]
coloc_611_sub10 <- colocalized(MG_sub10, mz= 611.161, n = 100, BPPARAM=SerialParam())
save(coloc_611_sub10, file = "Result/coloc_611_sub10.rda", compress = "xz")

## Method 3: Reduce the number of pixel by selecting the pixels where the intensity of m/z of interest is > 0

## (3.1) Auto selection of region of interest
MG_pix611 <- MG2[mz(MG2) < 611.17 & mz(MG2) > 611.15 ,]
##2 select intensity > 0
int611 <- as.matrix(iData(MG_pix611, "intensity")) 
pix611 <- which(int611 > 0)
# subset MG2 by m/z and intensity
MG_subpix <- MG2[, pix611]
coloc_611_pixsub <- colocalized(MG_subpix, mz= 611.161, n = 100, BPPARAM = SerialParam())

##(3.2) manual selection of region of interest
ROI611 <- selectROI(MG2, mz = 611.160)
MG_ROI611 <- MG2[, ROI611]
coloc_611_ROIsub <- colocalized(MG_ROI611, mz= 611.161, n = 100, BPPARAM = SerialParam())

##4. We could also combine these different approaches to further reduce the data analysis time

