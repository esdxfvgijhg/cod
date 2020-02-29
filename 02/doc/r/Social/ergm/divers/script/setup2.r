library(RColorBrewer)

plot_aghiles <- function(gnet,data,titre,main, ij = i){
  
  jsk <- colorRampPalette(c("gray80", "dark red")) 
  drink_text <- jsk(length(sort(unique(data))))
  ghj <- drink_text[match(data, sort(unique(data)))]
  ghj[ij] <- '#000000'
  plot(gnet, vertex.color=ghj, edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  kj <- as.array(order(sort(unique(data))))
  legend("bottomleft", legend=sort(unique(data)), text.col=drink_text[kj], col=drink_text[kj], bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
  
}

plot_node <- function(gnet,data,titre,main, ij = i) {
  unique_data <- sort(unique(data))
  color_function <- colorRampPalette(c("gray80", "dark red")) 
  unique_color <- sort(color_function(length(unique_data)), decreasing = T)
  colors <- unique_color[match(data, unique_data)]
  colors[ij] <- '#000000'

  plot(gnet, vertex.color=colors, edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  legend("bottomleft", 
         legend= unique_data, 
         text.col= unique_color, 
         col= unique_color, 
         bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
}

plot_edge <- function(gnet,data,titre,main) {
  unique_data <- sort(unique(data))
  color_function <- colorRampPalette(c("white", "dark red")) 
  unique_color <- sort(color_function(length(unique_data)), decreasing = T)
  colors <- unique_color[match(data, unique_data)]
  
  plot(gnet, edge.color=colors, vertex.color="#cccccc", edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  legend("bottomleft", 
         legend= unique_data, 
         text.col= unique_color, 
         col= unique_color, 
         bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
}

plot_node_legend_color <- function(gnet,data,titre,main, ij = i){
  b <- FALSE
  if (length(levels(as.factor(data))) > 9){
    b <- TRUE
    part  <- ceiling(max(data)/9)
    
    fgh <- 0
    fgh[which(data <  1*part)                   ] <- 1*part
    fgh[which(data <  2*part &  data >= 1*part)]  <- 2*part
    fgh[which(data <  3*part &  data >= 2*part)]  <- 3*part
    fgh[which(data <  4*part &  data >= 3*part)]  <- 4*part
    fgh[which(data <  5*part &  data >= 4*part)]  <- 5*part
    fgh[which(data <  6*part &  data >= 5*part)]  <- 6*part
    fgh[which(data <  7*part &  data >= 6*part)]  <- 7*part
    fgh[which(data <  8*part &  data >= 7*part)]  <- 8*part
    fgh[which(data <= 9*part &  data >= 8*part)]  <- max(data)
    data <- fgh
    data
  }

  drink_text = brewer.pal(length(levels(as.factor(data))), "Set1")
  ghj <- drink_text[match(data, sort(unique(data)))]
  ghj[ij] <- '#000000'
  plot(gnet, vertex.color=ghj, edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  kj <- as.array(order(sort(unique(data))))
  legend("bottomleft", legend=sort(unique(data)), text.col=drink_text[kj], col=drink_text[kj], bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
}

plot_edge_txt_legend_color <- function(gnet, edge_data, edge_titre,main){
  drive_text = brewer.pal(length(levels(as.factor(edge_data))), "Set1")
  plot(gnet, vertex.color="white", edge.color=drive_text[match(edge_data, sort(unique(edge_data)))], edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  kj <- as.array(order(sort(unique(edge_data))))
  legend("bottomright", legend=sort(unique(edge_data)), text.col=drive_text[kj], col=drive_text[kj], bty="n", pch='-' , pt.cex=2, cex=1,
         title = edge_titre, title.col ="black")
}

plot_edge_legend_color <- function(gnet, edge_data, edge_titre,main){
    b <- FALSE
    if (length(levels(as.factor(edge_data))) > 9){
    b <- TRUE
    part  <- ceiling(max(edge_data)/9)

    fgh <- 0
    fgh[which(edge_data <  1*part)                       ]  <- 1*part
    fgh[which(edge_data <  2*part &  edge_data >= 1*part)]  <- 2*part
    fgh[which(edge_data <  3*part &  edge_data >= 2*part)]  <- 3*part
    fgh[which(edge_data <  4*part &  edge_data >= 3*part)]  <- 4*part
    fgh[which(edge_data <  5*part &  edge_data >= 4*part)]  <- 5*part
    fgh[which(edge_data <  6*part &  edge_data >= 5*part)]  <- 6*part
    fgh[which(edge_data <  7*part &  edge_data >= 6*part)]  <- 7*part
    fgh[which(edge_data <  8*part &  edge_data >= 7*part)]  <- 8*part
    fgh[which(edge_data <= 9*part &  edge_data >= 8*part)]  <- max(edge_data)
    edge_data <- fgh
  }

  jsk <- colorRampPalette(c("gray80", "dark red")) 
  drive_text <- jsk(length(sort(unique(edge_data))))
  # drive_text = brewer.pal(length(levels(as.factor(edge_data))), "Set1")
  if (b){ drive_text[1] <- '#ffffff'}
  plot(gnet, edge.color=drive_text[match(edge_data, sort(unique(edge_data)))], edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  kj <- as.array(order(sort(unique(edge_data))))
  legend("bottomright", legend=sort(unique(edge_data)), text.col=drive_text[kj], col=drive_text[kj], bty="n", pch='-' , pt.cex=2, cex=1,
         title = edge_titre, title.col ="black")
}

plot_legend_color <- function(gnet,data, edge_data, titre, edge_titre, main){
  # drink_text = brewer.pal(length(levels(as.factor(data))), "Set1")
  # drive_text = brewer.pal(length(levels(as.factor(edge_data))), "Set1")
  
  jsk <- colorRampPalette(c("gray80", "dark red")) 
  drink_text <- jsk(length(sort(unique(data))))
  jsk <- colorRampPalette(c("gray80", "dark red")) 
  drive_text <- jsk(length(sort(unique(edge_data))))
  
  plot(gnet, vertex.color=drink_text[match(data, sort(unique(data)))], edge.color=drive_text[match(edge_data, sort(unique(edge_data)))], edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  kj <- as.array(order(sort(unique(data))))
  legend("bottomleft", legend=sort(unique(data)), text.col=drink_text[kj], col=drink_text[kj], bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
  kj <- as.array(order(sort(unique(edge_data))))
  legend("bottomright", legend=sort(unique(edge_data)), text.col=drive_text[kj], col=drive_text[kj], bty="n", pch='-' , pt.cex=2, cex=1,
         title = edge_titre, title.col ="black")
}

plot_agh_legend_color <- function(gnet,data, edge_data, titre, edge_titre, main){
  # drink_text = brewer.pal(length(levels(as.factor(data))), "Set1")
  drive_text = brewer.pal(length(levels(as.factor(edge_data))), "Set1")
  
  jsk <- colorRampPalette(c("gray80", "dark red")) 
  drink_text <- jsk(length(sort(unique(data))))
  # jsk <- colorRampPalette(c("gray80", "dark red")) 
  # drive_text <- jsk(length(sort(unique(edge_data))))
  drive_text[1] <- '#ffffff'
  
  plot(gnet, vertex.color=drink_text[match(data, sort(unique(data)))], edge.color=drive_text[match(edge_data, sort(unique(edge_data)))], edge.label=NA, vertex.label=NA, vertex.size=3, edge.size=6, main=main)
  kj <- as.array(order(sort(unique(data))))
  legend("bottomleft", legend=sort(unique(data)), text.col=drink_text[kj], col=drink_text[kj], bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
  kj <- as.array(order(sort(unique(edge_data))))
  legend("bottomright", legend=sort(unique(edge_data)), text.col=drive_text[kj], col=drive_text[kj], bty="n", pch='-' , pt.cex=2, cex=1,
         title = edge_titre, title.col ="black")
}

norm <- function(data){(data - min(data)) / (max(data) - min(data)) * 20}
norm2 <- function(data){(data - min(data)) / (max(data) - min(data)) * .11}

plot_legend_size <- function(gnet,data,titre, main){
  plot(gnet, vertex.size=norm(data), edge.size=norm(data), edge.label=NA, vertex.label=NA, main=main)
  data_plot <- c(min(data), max(data)/2, max(data))
  legend("topleft",legend=sort(data_plot), bty="n" , pt.cex=data_plot, cex=1,
         title = titre, title.col ="black")
  a <- legend('topleft', legend=sort(data_plot), pt.cex=data_plot, col='white', pch=1, pt.bg='white', cex=1, bty="n",
              title = titre, title.col ="black")
  x <- (a$text$x + a$rect$left) / 2
  y <-  a$text$y
  symbols(x, y, circles=norm2(data_plot), inches=FALSE, add=TRUE, bg='orange')
}
