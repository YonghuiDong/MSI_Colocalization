nodes <- read.csv("Example/Dataset1-Media-Example-NODES.csv", header=T, as.is=T)

links <- read.csv("Example/Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)

# set color
colrs <- c("gray80", "gold", "tomato")
colc <- cut(coloc_611_sub$correlation, breaks = c(0.7, 0.8, 0.9, 1), include.lowest = TRUE)

# prepare links
links <- cbind.data.frame(from = rep(611.155, dim(coloc_611_sub)[1]),
                   to = round(coloc_611_sub$mz,3),
                   weight = coloc_611_sub$correlation,
                   type = colrs[colc])
# prepare nodes
nodes <- cbind.data.frame(id = rep(611.155, dim(coloc_611_sub)[1]),
                          cor = coloc_611_sub$correlation)
## plot
net <- graph_from_data_frame(d = links, directed = T) 
V(net)$color <- colrs[colc]
plot(net, vertex.size=30, edge.arrow.size = 0)
