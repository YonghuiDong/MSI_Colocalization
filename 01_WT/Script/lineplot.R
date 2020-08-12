library(Cardinal)
library(ggpubr)
load("Result/MG_processed.rda")

#(1) subset three m/z values for scatter plot
## 611.160
F611 <- features(MG2, 611.157 <= mz & mz <= 611.163)
Data611 <- MG2[F611, ]
Int611 = as.matrix(Data611@imageData$data$intensity)
darkmode()
image(Data611, smooth.image = "gaussian", 
      plusminus = 0.003, colorscale=magma, 
      contrast.enhance="suppression", normalize.image = "linear")
## 303.049
F303 <- features(MG2, 303.046 <= mz & mz <= 303.052)
Data303 <- MG2[F303, ]
Int303 = as.matrix(Data303@imageData$data$intensity)
darkmode()
image(Data303, smooth.image = "gaussian", 
      plusminus = 0.003, colorscale=magma, 
      contrast.enhance="suppression", normalize.image = "linear")
## 409.055
F409 <- features(MG2, 409.052 <= mz & mz <= 409.058)
Data409 <- MG2[F409, ]
Int409 = as.matrix(Data409@imageData$data$intensity)
darkmode()
image(Data409, smooth.image = "gaussian", 
      plusminus = 0.003, colorscale=magma, 
      contrast.enhance="suppression", normalize.image = "linear")

## simulate a data, it has the same distribution as 303, but intensities are different
Datasimu <- Data611
Ints <- Int611
n <- sum(Ints > 0)
Ints[Ints > 0] = 500
Datasimu@imageData$data$intensity <- Ints
image(Datasimu, smooth.image = "gaussian", 
            plusminus = 0.003, colorscale=magma, 
            contrast.enhance="suppression", normalize.image = "linear")



mydata <- cbind.data.frame(Int611 = t(Int611), Int303 = t(Int303), 
                           Int409 = t(Int409), Ints = t(Ints))


#(2) plot
p1 <- ggscatter(mydata, y = "Int611", x = "Int303",
          alpha = 0.5,
          add = "reg.line",  
          add.params = list(color = "tomato2"),
          conf.int = F) + 
      stat_cor(method = "pearson", label.x = 100, label.y = 950)
p1

p2 <- ggscatter(mydata, y = "Int611", x = "Int409",
                alpha = 0.5,
                add = "reg.line",  
                add.params = list(color = "tomato2"),
                conf.int = F) + 
  stat_cor(method = "pearson", label.x = 400, label.y = 1300)

p2

p3 <- ggscatter(mydata, y = "Int611", x = "Ints",
                alpha = 0.5,
                add = "reg.line",  
                add.params = list(color = "tomato2"),
                conf.int = F) + 
  stat_cor(method = "pearson", label.x = 100, label.y = 1300)

p3





