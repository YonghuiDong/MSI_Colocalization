#(1) load data
library(Cardinal)
path <- paste0("Data/empty", ".imzML")
## Attention: The resolution parameter is important 
Empty <- readMSIData(path, resolution = 10, units = c("ppm"), attach.only = T)
## check resolution parameter by plotting known m/z
image(Empty, mz = 317.065, smooth.image = "gaussian", plusminus = 0.001, 
      colorscale=magma, contrast.enhance="suppression")

#(2) pre-processing
Empty2 <- 
  Empty %>%
  normalize(method = "tic") %>%
  peakPick(method = "simple", SNR = 6) %>%
  peakAlign(tolerance = 5, units = "ppm") %>%
  process(BPPARAM=SerialParam())

## check the distribution again, make sure no mistakes produced during pre-processing
image(Empty2, mz = 317.065, smooth.image = "gaussian", plusminus = 0.001, 
      colorscale=magma, contrast.enhance="suppression")
## save the objects
save(Empty2, file = "Empty2.rda", compress = "xz") 
load("Empty2.rda") 

#(3). co-localization
#(3.1) co-localization of petunidin m/z 317.0065
coloc_317 <- colocalized(Empty2, mz= 317.065, n = 100, BPPARAM=SerialParam())
save(coloc_317, file = "coloc_317.rda", compress = "xz")

pdf(file = file.path("colocalization_317.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_skin)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_skin$mz[i], smooth.image = "gaussian", 
              plusminus = 0.001, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_skin$correlation[i], 2)))
}
dev.off()

#(3.2) co-localization of malvidin m/z 331.08
coloc_317 <- colocalized(Empty2, mz= 317.065, n = 100, BPPARAM=SerialParam())
save(coloc_317, file = "coloc_317.rda", compress = "xz")

pdf(file = file.path("colocalization_317.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_317)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_317$mz[i], smooth.image = "gaussian", 
              plusminus = 0.001, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_317$correlation[i], 2)))
}
dev.off()


#(3.2) co-localization of Petunidin 3- (p-coumaroyl)- rutinoside-5-glucoside m/z 949.261
coloc_933 <- colocalized(Empty2, mz= 933.266, n = 100, BPPARAM=SerialParam())
save(coloc_933, file = "coloc_933.rda", compress = "xz")

pdf(file = file.path("colocalization_933.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_933)[1]){
  darkmode()
  print(image(Empty2, mz = coloc_933$mz[i], smooth.image = "gaussian", 
              plusminus = 0.001, colorscale=magma, contrast.enhance="suppression"))
  legend("topleft", legend= paste("correlation = ", round(coloc_933$correlation[i], 2)))
}
dev.off()

