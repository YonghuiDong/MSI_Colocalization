#(1) load package and data
library(Cardinal)
library(BiocParallel)
library(plotly)
path <- paste0("Data/MG/MG1", ".imzML")
## Attention: The resolution parameter is important 
MG <- readMSIData(path, resolution = 5, units = "ppm", attach.only = T)
## check resolution parameter by plotting known m/z
image(MG, mz = 611.160, smooth.image = "gaussian", plusminus = 0.003, 
      colorscale=magma, contrast.enhance="suppression")

#(2) pre-processing
  MG2 <- 
    MG %>%
    normalize(method = "tic") %>%
    peakPick(method = "simple", SNR = 10) %>%
    peakAlign(tolerance = 10, units = "ppm") %>%
    process(BPPARAM = SerialParam())

## check the distribution again of the same m/z again
## make sure no mistakes produced during pre-processing
image(MG2, mz = 611.160, smooth.image = "gaussian", plusminus = 0.003, 
      colorscale=magma, contrast.enhance="suppression")
## save the objects
save(MG2, file = "Result/MG_processed.rda", compress = "xz") 

## plot mean spectrum
pixel = dim(MG2@elementMetadata)[1]
MG2_sub100 <- MG2[, c(seq(1, pixel, 100))]
MG2_mean <- summarize(MG2_sub100, .stat = "mean", .as = "DataFrame")
spec = cbind.data.frame(mz = MG2_mean@mz, Int = MG2_mean$mean)
p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)


#(3). co-localization
#(3.1) co-localization of DHB, m/z 409.055
coloc_409 <- colocalized(MG2, mz= 409.055, n = 100, BPPARAM=SerialParam())
save(coloc_409, file = "coloc_409.rda", compress = "xz")

pdf(file = file.path("colocalization_409.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_409)[1]){
  darkmode()
  print(image(MG2, mz = coloc_409$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, 
              contrast.enhance="suppression", normalize.image = "linear"))
  legend("topleft", legend= paste("correlation = ", round(coloc_409$correlation[i], 2)))
}
dev.off()


#(3.2) co-localization of Rutin, m/z 611.161
BPPARAM  <- MulticoreParam(workers = 4, progressbar = T)
coloc_611 <- colocalized(MG2, mz= 611.161, n = 100, BPPARAM = BPPARAM)
save(coloc_611, file = "Result/coloc_611.rda", compress = "xz")

pdf(file = file.path("Result/colocalization_611.pdf"), onefile=TRUE)
for(i in 1:dim(coloc_611)[1]){
  darkmode()
  print(image(MG2, mz = coloc_611$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, 
              contrast.enhance="suppression", normalize.image = "linear"))
  legend("topleft", legend= paste("correlation = ", round(coloc_611$correlation[i], 2)))
}
dev.off()
