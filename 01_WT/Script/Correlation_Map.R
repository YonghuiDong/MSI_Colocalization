library(igraph)

#(1) Calculate network for Rutin 611.155
myColoc <- get(load("Result/coloc_611.rda"))
myColoc_sub <- myColoc[myColoc$correlation >= 0.7,]
setColour <- c("#f7f7f7", "#a1d76a", "#e9a3c9")
myBreaks <- cut(myColoc_sub$correlation, breaks = c(0.7, 0.8, 0.9, 1), include.lowest = T)

## prepare links
links <- cbind.data.frame(from = rep(611.155, dim(myColoc_sub)[1]),
                          to = round(myColoc_sub$mz,3),
                          weight = myColoc_sub$correlation)
                          
## prepare nodes
nodes <- cbind.data.frame(id = round(myColoc_sub$mz,3),
                          mycolor = setColour[myBreaks],
                          mysize = c(15, 20, 30)[myBreaks])
## plot
net <- graph_from_data_frame(d = links, vertices = nodes, directed = T) 
V(net)$color <- V(net)$mycolor
V(net)$size <- V(net)$mysize
plot(simplify(net), edge.arrow.size = 0, edge.curved = 0, edge.width = 2)


