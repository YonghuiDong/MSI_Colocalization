#(1) load package and data
## The data are from ....".
## Orbitrap XL, mass range: 300-2000
library(Cardinal)
library(BiocParallel)
library(plotly)
path <- paste0("Data/test_POS", ".imzML")
Brain <- readMSIData(path, resolution = 5, units = "ppm",  mass.range = c(300, 2000), 
                    attach.only = T)

#(2) pre-processing
Brain2 <- 
  Brain %>%
  normalize(method = "tic") %>%
  peakPick(method = "mad", SNR = 6) %>%
  peakAlign(tolerance = 5, units = "ppm") %>%
  process(BPPARAM = SerialParam())

## check m/z 855.55, make sure preprocessing parameters are ok.
darkmode()
image(Brain, mz = 856.584, smooth.image = "gaussian", plusminus = 0.03, 
      colorscale = magma, contrast.enhance = "suppression")

## save the objects
save(Brain2, file = "Result/Brain2_processed.rda", compress = "xz") 

#(3) Co-localization

#(3.1) co-localization PC36:1
coloc_826 <- colocalized(Brain2, mz= 826.572, n = 100, BPPARAM = SerialParam())
#(3.2) co-localization PC38:6
coloc_844 <- colocalized(Brain2, mz= 844.525, n = 100, BPPARAM = SerialParam())
#(3.3) co-localization PC40:6
coloc_872 <- colocalized(Brain2, mz= 872.557, n = 100, BPPARAM = SerialParam())

#(4) extract MS/MS

#(4.1) PC36:1
mycoloc <- as.data.frame(coloc_826)
MSe <- mycoloc[mycoloc$correlation >= 0.90,]
## extract intensity
int = as.vector(rep(NA, dim(MSe)[1]))
for (i in 1:length(MSe$mz)) {
  int[i] <- sum(spectra(Brain2)[features(Brain2,  mz = MSe$mz[i]),])
}
## interactive plot
spec = cbind.data.frame(mz = MSe$mz, Int = int)
p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)

#(4.2) PC38:6
mycoloc <- as.data.frame(coloc_844)
MSe <- mycoloc[mycoloc$correlation >= 0.90,]
## extract intensity
int = as.vector(rep(NA, dim(MSe)[1]))
for (i in 1:length(MSe$mz)) {
  int[i] <- sum(spectra(Brain2)[features(Brain2,  mz = MSe$mz[i]),])
}
## interactive plot
spec = cbind.data.frame(mz = MSe$mz, Int = int)
p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)

#(4.3) PC40:6
mycoloc <- as.data.frame(coloc_872)
MSe <- mycoloc[mycoloc$correlation >= 0.90,]
## extract intensity
int = as.vector(rep(NA, dim(MSe)[1]))
for (i in 1:length(MSe$mz)) {
  int[i] <- sum(spectra(Brain2)[features(Brain2,  mz = MSe$mz[i]),])
}
## interactive plot
spec = cbind.data.frame(mz = MSe$mz, Int = int)
p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)

#(5) plot MALDI images

#(5.1) PC36:1
mycoloc <- as.data.frame(coloc_826)
MSe <- mycoloc[mycoloc$correlation >= 0.90,]
pdf(file = file.path("Result/colocalization_826.pdf"), onefile = TRUE)
for(i in 1:dim(MSe)[1]){
  darkmode()
  print(image(Brain2, mz = MSe$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, 
              contrast.enhance="suppression", normalize.image = "linear"))
  legend("topleft", legend= paste("correlation = ", round(MSe$correlation[i], 2)))
}
dev.off()

#(5.2) PC38:6
mycoloc <- as.data.frame(coloc_844)
MSe <- mycoloc[mycoloc$correlation >= 0.90,]
pdf(file = file.path("Result/colocalization_844.pdf"), onefile = TRUE)
for(i in 1:dim(MSe)[1]){
  darkmode()
  print(image(Brain2, mz = MSe$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, 
              contrast.enhance="suppression", normalize.image = "linear"))
  legend("topleft", legend= paste("correlation = ", round(MSe$correlation[i], 2)))
}
dev.off()

#(5.3) PC38:6
mycoloc <- as.data.frame(coloc_872)
MSe <- mycoloc[mycoloc$correlation >= 0.90,]
pdf(file = file.path("Result/colocalization_872.pdf"), onefile = TRUE)
for(i in 1:dim(MSe)[1]){
  darkmode()
  print(image(Brain2, mz = MSe$mz[i], smooth.image = "gaussian", 
              plusminus = 0.003, colorscale=magma, 
              contrast.enhance="suppression", normalize.image = "linear"))
  legend("topleft", legend= paste("correlation = ", round(MSe$correlation[i], 2)))
}
dev.off()

