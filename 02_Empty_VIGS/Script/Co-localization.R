#(1) load data
library(Cardinal)
library(BiocParallel)
path <- paste0("Data/empty", ".imzML")
## Attention: The resolution parameter is important 
Empty <- readMSIData(path, resolution = 5, units = c("ppm"), attach.only = T)
## check resolution parameter by plotting known m/z
image(Empty, mz = 317.065, smooth.image = "gaussian", plusminus = 0.003, 
      colorscale=magma, contrast.enhance="suppression")

#(2) pre-processing
Empty2 <- 
  Empty %>%
  normalize(method = "tic") %>%
  peakPick(method = "simple", SNR = 6) %>%
  peakAlign(tolerance = 10, units = "ppm") %>%
  process(BPPARAM=SerialParam())

## check the distribution again, make sure no mistakes produced during pre-processing
image(Empty2, mz = 317.065, smooth.image = "gaussian", plusminus = 0.003, 
      colorscale=magma, contrast.enhance="suppression")
## save the objects
save(Empty2, file = "Result/Empty2_processed.rda", compress = "xz") 
load("Result/Empty2_processed.rda") 

#(3). co-localization
#(3.1) co-localization of petunidin m/z 317.0065
coloc_317 <- colocalized(Empty2, mz= 317.065, n = 100, BPPARAM=SerialParam())
save(coloc_317, file = "Result/coloc_317.rda", compress = "xz")

pdf(file = file.path("colocalization_317.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_317)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_317$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_317$correlation[i], 2)))
}
dev.off()

#(3.2) co-localization of malvidin m/z 331.081
coloc_331 <- colocalized(Empty2, mz= 331.081, n = 100, BPPARAM=SerialParam())
save(coloc_331, file = "Result/coloc_331.rda", compress = "xz")

pdf(file = file.path("colocalization_331.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_331)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_331$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_331$correlation[i], 2)))
}
dev.off()

#(3.2) co-localization of delphinidin m/z 303.049
coloc_303 <- colocalized(Empty2, mz= 303.049, n = 100, BPPARAM=SerialPara())
save(coloc_303, file = "Result/coloc_303.rda", compress = "xz")

pdf(file = file.path("Result/colocalization_303.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_303)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_303$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_303$correlation[i], 2)))
}
dev.off()

#(3.2) co-localization of Delphinidin 3-(p-coumaroyl)- rutinoside-5-glucoside m/z 919.250
coloc_919 <- colocalized(Empty2, mz= 919.250, n = 100, BPPARAM=SerialParam())
save(coloc_919, file = "Result/coloc_919.rda", compress = "xz")


#(3.2) co-localization m/z 949.261
coloc_949 <- colocalized(Empty2, mz= 949.261, n = 100, BPPARAM=SerialParam())
save(coloc_949, file = "Result/coloc_949.rda", compress = "xz")

pdf(file = file.path("Result/colocalization_949.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_949)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_949$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_949$correlation[i], 2)))
}
dev.off()


#(3.4) co-localization of unknown peak 1069.274
pixel = dim(Empty2@elementMetadata)[1]
Empty2_sub10 <- Empty2[, c(seq(1, pixel, 10))]
coloc_1069 <- colocalized(Empty2_sub10, mz= 1069.284, n = 100, BPPARAM=SerialParam())
save(coloc_1069, file = "Result/coloc_1069.rda", compress = "xz")

#(3.5) co-localization of unknown peak 1087.292
pixel = dim(Empty2@elementMetadata)[1]
Empty2_sub10 <- Empty2[, c(seq(1, pixel, 10))]
coloc_1087 <- colocalized(Empty2_sub10, mz= 1087.292, n = 100, BPPARAM=SerialParam())
save(coloc_1087, file = "Result/coloc_1087.rda", compress = "xz")



pdf(file = file.path("Result/colocalization_933.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_933)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_933$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, 
              contrast.enhance="suppression", normalize.image = "linear"))
  legend("topleft", legend= paste("correlation = ", round(coloc_933$correlation[i], 2)))
}
dev.off()

