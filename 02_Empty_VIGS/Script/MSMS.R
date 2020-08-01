library(Cardinal)
library(plotly)
load("coloc_933.rda")
MSe <- coloc_933[coloc_933$correlation > 0.8,]

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
