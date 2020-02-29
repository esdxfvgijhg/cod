library(RColorBrewer)

plot_legend_color <- function(gnet,data,titre){
  drink_text = brewer.pal(length(levels(as.factor(data))), "Set1")
  plot(gnet, vertex.color=drink_text[data], edge.label=NA, vertex.label=NA, vertex.size=6)
  legend("bottomleft", legend=levels(as.factor(data)), text.col=drink_text, col=drink_text, bty="n", pch=20 , pt.cex=2, cex=1,
         title = titre, title.col ="black")
}

norm <- function(data){(data - min(data)) / (max(data) - min(data)) * 20}
norm2 <- function(data){(data - min(data)) / (max(data) - min(data)) * .11}

plot_legend_size <- function(gnet,data,titre, scale){
  plot(gnet, vertex.size=norm(data), edge.size=norm(data), edge.label=NA, vertex.label=NA)
  data_plot <- c(min(data), max(data)/2, max(data))
  legend("topleft",legend=data_plot, bty="n" , pt.cex=data_plot, cex=1,
         title = titre, title.col ="black")
  a <- legend('topleft', legend=data_plot, pt.cex=data_plot, col='white', pch=1, pt.bg='white', cex=1, bty="n",
              title = titre, title.col ="black")
  x <- (a$text$x + a$rect$left) / 2
  y <-  a$text$y
  symbols(x, y, circles=norm2(data_plot), inches=FALSE, add=TRUE, bg='orange')
}
