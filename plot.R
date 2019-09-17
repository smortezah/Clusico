library(ggplot2)
library(reshape2)
library(scales)
library(ggpubr)
library(ggplotify)
library(factoextra)
library(cluster)
# library(biclust)
theme_set(theme_bw())

library(devtools)
# install_github("jokergoo/ComplexHeatmap")
library(ComplexHeatmap)
library(circlize)

plot.nrc <- function(width, height) {
  nrc_mat <- as.matrix(read.table('nrc.tsv', header = TRUE))
  
  H <- Heatmap(nrc_mat)

  a <- Heatmap(
    nrc_mat,
    row_order = row_order(H),
    column_order = column_order(H),
    row_names_side = c("left"),
    name = "NRC",
    # col = colorRamp2(
    #   breaks = seq(0, 2, 1),
    #   colors = c("#A71B4B", "#FEFDBE", "#584B9F")
    # ),
    column_title = "Normalized relative compression (NRC)"
  )

  # pdf("nrc.pdf", width = width, height = height)
  # draw(a)
  # dev.off()
}

plot.nrc(40, 20)