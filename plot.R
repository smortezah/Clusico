library(ggplot2)
library(reshape2)
library(scales)
library(ggpubr)
library(ggplotify)
library(factoextra)
library(cluster)
# library(biclust)
library(svglite)
theme_set(theme_bw())

library(devtools)
# install_github("jokergoo/ComplexHeatmap")
library(ComplexHeatmap)
library(circlize)

plot.nrc.clus <- function(width, height) {
  nrc_mat <- as.matrix(read.table('result/nrc.tsv', header = TRUE))
  
  H <- Heatmap(nrc_mat)
  cl = kmeans(nrc_mat, centers = 1)$cluster
  pa = cluster::pam(nrc_mat, k = 3)
  group = kmeans(t(nrc_mat), centers = 3)$cluster

  a <- Heatmap(
    nrc_mat,
    # row_order = row_order(H),
    # column_order = column_order(H),
    row_names_side = c("left"),
    name = "NRC",
    col = colorRamp2(
      seq(0, 1, 0.1),
      hcl.colors(11, palette = "spectral")
    ),
    # column_title = "Normalized relative compression (NRC)", 
    # clustering_distance_rows = "pearson",
    # clustering_method_rows = "single",
    # cluster_rows = function(x) fastcluster::hclust(dist(x)),
    # cluster_columns = function(x) fastcluster::hclust(dist(x)),
    # cluster_columns = cluster_within_group(nrc_mat, group),
    # row_km = 3, row_km_repeats = 100,
    # column_km = 3, column_km_repeats = 100,
    # row_split = paste0("pam", pa$clustering),
    # column_split = paste0("pam", pa$clustering),
    show_row_dend = FALSE,
  )

  # pdf("nrc.pdf", width = width, height = height)
  svg("nrc.svg", width = width, height = height)
  draw(a)
  dev.off()
}

plot.nrc.ave.clus <- function(width, height) {
  nrc_mat <- as.matrix(read.table('result/nrc_ave.tsv', header = TRUE))
  
  H <- Heatmap(nrc_mat)
  
  a <- Heatmap(
    nrc_mat,
    # row_order = row_order(H),
    # row_order = NULL,
    # column_order = column_order(H),
    # column_order = NULL,
    row_names_side = c("left"),
    name = "NRC",
    col = colorRamp2(
      seq(0, 1, 0.1),
      hcl.colors(11, palette = "spectral")
    ),
    # column_title = "Normalized relative compression (NRC)", 
    # row_km = 3, row_km_repeats = 100,
    # column_km = 3, column_km_repeats = 100
  )
  
  # pdf("nrc.pdf", width = width, height = height)
  svg("nrc_ave.svg", width = width, height = height)
  draw(a)
  dev.off()
}

plot.nrc.clus(11, 10)
plot.nrc.ave.clus(11, 10)