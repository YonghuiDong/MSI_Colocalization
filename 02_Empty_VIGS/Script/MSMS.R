library(Cardinal)
library(plotly)
load("Result/Empty2_processed.rda")
myColoc = get(load("Result/coloc_919.rda"))
MSe <- myColoc[myColoc$correlation >= 9,]

int = as.vector(rep(NA, dim(MSe)[1]))
for (i in 1:length(MSe$mz)) {
   int[i] <- sum(spectra(Empty2)[features(Empty2,  mz = MSe$mz[i]),])
}

spec = cbind.data.frame(mz = MSe$mz, Int = int)

p = ggplot(spec, aes(x = mz, ymax = Int/max(Int)*100, ymin = 0, colour = "red")) +
  geom_linerange() +
  scale_y_continuous(expand = c(0, 0), limits = c(0, 100*1.1)) +
  theme_bw()
ggplotly(p)
