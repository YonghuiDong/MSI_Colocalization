library(tidyverse)
library(corrr)
library(igraph)
library(ggraph)

##(1) to calculate all feature correlation, the results are too compact to visulize
red_p2 <- process(peakFilter(Empty2, freq.min=0.05))
aa = as.matrix(spectra(Empty2))
test = cor(t(aa))
net <- test
net[net < 0.995]=0
network = graph_from_adjacency_matrix(net, weighted=T, mode="undirected", diag=F)

Isolated = which(degree(network)==0)
G2 = delete.vertices(network, Isolated)
LO = layout_as_tree(network)
LO2 = LO[-Isolated,]
plot(G2, layout=layout_randomly)

##(2) to calculate rutin network
load("Result/coloc_rutin.rda")
b = coloc_933[coloc_933$correlation >= 0.9,]
n = matrix(b$correlation, nrow = 1)
colnames(n) = round(b$mz,3)
row.names(n) = round(b$mz[1], 3)
network = graph_from_incidence_matrix(n, weighted=T)

##(2.1) use ggraph to beautify the result

layout <- create_layout(network, layout = 'igraph', algorithm = 'nicely')

ggraph(layout ) +
  geom_edge_link(aes(edge_alpha = abs(n[1,]), 
                     edge_width = abs(n[1, ]), color = n[1,])) +
  guides(edge_alpha = "none", edge_width = "none") +
  scale_edge_colour_gradientn(limits = c(0.8, 1), colors = c("#377EB8", "#FF7F00", "#E41A1C")) +
  geom_node_point(color = "black", alpha = 0.7, size = 2) +
  geom_node_text(aes(label = name), size = 7, repel = TRUE,alpha = 0.8, color = "black")+
  theme_graph()


##595
b = coloc_595[coloc_595$correlation >= 0.8,]
n = matrix(b$correlation, nrow = 1)
colnames(n) = round(b$mz,3)
row.names(n) = round(b$mz[1], 3)
network = graph_from_incidence_matrix(n, weighted=T)

##(2.1) use ggraph to beautify the result

layout <- create_layout(network, layout = 'igraph', algorithm = 'nicely')

ggraph(layout ) +
  geom_edge_link(aes(edge_alpha = abs(n[1,]), 
                     edge_width = abs(n[1, ]), color = n[1,])) +
  guides(edge_alpha = "none", edge_width = "none") +
  scale_edge_colour_gradientn(limits = c(0.8, 1), colors = c("#377EB8", "#FF7F00", "#E41A1C")) +
  geom_node_point(color = "black", alpha = 0.7, size = 2) +
  geom_node_text(aes(label = name), size = 7, repel = TRUE,alpha = 0.8, color = "black")+
  theme_graph()

