library(RColorBrewer)

plot_djoudi <- function(gnet, 
                         node_data = c(rep(0, vcount(gnet))), 
                         edge_data = c(rep(0, ecount(gnet))), 
                         node_titre = "",
                         edge_titre = "",
                         main ="",  
                         index = NA) {
  
  edge_unique_data <- sort(unique(edge_data))
  edge_color_function <- colorRampPalette(c("gray80", rgb(.8,0,0, .7)))
  edge_unique_color <- sort(edge_color_function(length(edge_unique_data)), decreasing = T)
  # edge_unique_color <- sort(brewer.pal(length(edge_unique_data), "Set1"), decreasing = T)
  edge_colors <- edge_unique_color[match(edge_data, edge_unique_data)]
  
  node_unique_data <- sort(unique(node_data))
  # node_unique_color <- sort(brewer.pal(length(node_unique_data), "Spectral"), decreasing = T)
  node_unique_color <- sort(brewer.pal(length(node_unique_data), "Set1"), decreasing = T)
  node_colors <- node_unique_color[match(node_data, node_unique_data)]
  node_colors[index] <- '#000000'
  
  plot(gnet, edge.color=edge_colors, vertex.color=node_colors, edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  legend("bottomleft", 
         legend= edge_unique_data, 
         text.col= edge_unique_color, 
         col= edge_unique_color, 
         bty="n", pch='-' , pt.cex=2, cex=1,
         title = edge_titre, title.col ="black")
  
  legend("bottomright", 
         legend= node_unique_data, 
         text.col= node_unique_color, 
         col= node_unique_color, 
         bty="n", pch=20 , pt.cex=2, cex=1,
         title = node_titre, title.col ="black")
}

plot_aghiles <- function(gnet, 
                      node_data = c(rep(0, vcount(gnet))), 
                      edge_data = c(rep(0, ecount(gnet))), 
                      node_titre = "",
                      edge_titre = "",
                      main ="",  
                      index = NA) {
  
  edge_unique_data <- sort(unique(edge_data))
  # edge_color_function <- colorRampPalette(c(rgb(1,1,1, .2),rgb(.8,0,0, .7)))
  edge_color_function <- colorRampPalette(c("gray80", rgb(.8,0,0, .7))) 
  edge_unique_color <- sort(edge_color_function(length(edge_unique_data)), decreasing = T)
  edge_colors <- edge_unique_color[match(edge_data, edge_unique_data)]
  
  node_unique_data <- sort(unique(node_data))
  node_color_function <- colorRampPalette(c("gray80", rgb(.8,0,0, .7))) 
  node_unique_color <- sort(node_color_function(length(node_unique_data)), decreasing = T)
  node_colors <- node_unique_color[match(node_data, node_unique_data)]
  node_colors[index] <- '#000000'
  l <- layout_with_lgl(gnet)
  plot(gnet, edge.color=edge_colors, vertex.color=node_colors, edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main, layout=l)
  
  legend("bottomleft", 
         legend= edge_unique_data, 
         text.col= edge_unique_color, 
         col= edge_unique_color, 
         bty="n", pch='-' , pt.cex=2, cex=1,
         title = edge_titre, title.col ="black")
  
  node_unique_data <- signif(c(min(node_unique_data), mean(node_unique_data), max(node_unique_data)),1)
  node_unique_color <- sort(node_color_function(length(node_unique_data)), decreasing = T)
  legend("bottomright", 
         legend= node_unique_data, 
         text.col= node_unique_color, 
         col= node_unique_color, 
         bty="n", pch=20 , pt.cex=2, cex=1,
         title = node_titre, title.col ="black")
}
