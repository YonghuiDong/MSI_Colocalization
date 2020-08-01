#(1) load package and data
library(Cardinal)
load("Result/MG_processed.rda")

#(2) subset and colocalization analysis of DHB 409
## subset every 100 pixel
pixel = dim(MG2@elementMetadata)[1]
MG_sub100 <- MG2[, c(seq(1, pixel, 100))]
coloc_409_sub100 <- colocalized(MG_sub100, mz= 409.055, n = 100, BPPARAM=SerialParam())
save(coloc_409_sub100, file = "Result/coloc_409_sub100.rda", compress = "xz")

## subset every 10 pixel
MG_sub10 <- MG2[, c(seq(1, pixel, 10))]
coloc_409_sub10 <- colocalized(MG_sub10, mz= 409.055, n = 100, BPPARAM=SerialParam())
save(coloc_409_sub10, file = "Result/coloc_409_sub10.rda", compress = "xz")

#(3) subset and colocalization analysis of Rutin 611
pixel = dim(MG2@elementMetadata)[1]
MG_sub100 <- MG2[, c(seq(1, pixel, 100))]
coloc_611_sub100 <- colocalized(MG_sub100, mz= 611.161, n = 100, BPPARAM=SerialParam())
save(coloc_611_sub100, file = "Result/coloc_611_sub100.rda", compress = "xz")


## subset every 10 pixel
MG_sub10 <- MG2[, c(seq(1, pixel, 10))]
coloc_611_sub10 <- colocalized(MG_sub10, mz= 611.161, n = 100, BPPARAM=SerialParam())
save(coloc_611_sub10, file = "Result/coloc_611_sub10.rda", compress = "xz")


#(4) subset and colocalization analysis of tomatine 1034, it takes about 11.25 min
pixel = dim(MG2@elementMetadata)[1]
MG_sub100 <- MG2[, c(seq(1, pixel, 100))]
start.time <- Sys.time()
coloc_1034_sub100 <- colocalized(MG_sub100, mz= 1034.553, n = 100, BPPARAM=SerialParam())
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
save(coloc_1034_sub100, file = "Result/coloc_1034_sub100.rda", compress = "xz")


## subset every 10 pixel
MG_sub10 <- MG2[, c(seq(1, pixel, 10))]
start.time <- Sys.time()
coloc_1034_sub10 <- colocalized(MG_sub10, mz= 1034.553, n = 100, BPPARAM=SerialParam())
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken
save(coloc_1034_sub10, file = "Result/coloc_1034_sub10.rda", compress = "xz")


time.taken