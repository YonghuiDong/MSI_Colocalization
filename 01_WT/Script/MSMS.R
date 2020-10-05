#(1) load library and data
library(Cardinal)
library(plotly)
load("Result/MG_processed.rda")
load("Result/coloc_409.rda")
load("Result/coloc_611.rda")

#(2) creat MS/MS for DHB 409
## subset data, select correlation >= 0.9
MSe <- coloc_409[coloc_409$correlation >= 0.90,]
## extract intensity
int = as.vector(rep(NA, dim(MSe)[1]))
for (i in 1:length(MSe$mz)) {
   int[i] <- sum(spectra(MG2)[features(MG2,  mz = MSe$mz[i]),])
}
## interactive plot
spec = cbind.data.frame(mz = MSe$mz, Int = int)
p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)


#(2) creat MS/MS for Rutin 611
## subset data, select correlation > 0.9
MSe <- coloc_611[coloc_611$correlation >= 0.9,]
## extract intensity
int = as.vector(rep(NA, dim(MSe)[1]))
for (i in 1:length(MSe$mz)) {
  int[i] <- sum(spectra(MG2)[features(MG2,  mz = MSe$mz[i]),])
}
## interactive plot
spec = cbind.data.frame(mz = MSe$mz, Int = int)
p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)

#(3) create LC-MS/MS for Rutin 611.
LCMS <- read.csv("Data/Rutin.csv", header = T)
p = ggplot(LCMS, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)



