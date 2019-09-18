library(ggplot2)
library(reshape2)
library(scales)
library(ggpubr)
library(ggplotify)
library(factoextra)
library(cluster)
# library(biclust)
library(svglite)
library(dendextend)
library(FactoMineR)
# theme_set(theme_bw())

library(devtools)
# install_github("jokergoo/ComplexHeatmap")
library(ComplexHeatmap)
library(circlize)

plot.nrc.clus <- function(width, height) {
  nrc_mat <- as.matrix(read.table('result/nrc.tsv', header = TRUE))
  
  res <- hclust(dist(nrc_mat), method = "mcquitty")
  res.pca <- PCA(nrc_mat, ncp = 3, graph = FALSE)
  res.hcpc <- HCPC(res.pca, graph = FALSE)
  
  fviz_dend(
    res,
    # rect = TRUE,
    # rect_fill = TRUE,
    k = 3,
    # k_colors = c("#2E9FDF", "#00AFBB", "#E7B800"),
    lwd = 1,
    # cex = 0.5,                 # label size
    # color_labels_by_k = TRUE,  # color labels by groups
    # palette = "jco",
    # ggtheme = theme_gray()     # Change theme
    cex = 0.7,                     # Label size
    palette = "jco",               # Color palette see ?ggpubr::ggpar
    rect = TRUE, rect_fill = TRUE, # Add rectangle around groups
    rect_border = "jco",           # Rectangle color
    # rect_border = c("#2E9FDF", "#00AFBB", "#E7B800"),           # Rectangle color
    labels_track_height = 0.8      # Augment the room for labels
  )

  # fviz_cluster(res.hcpc,
  #              repel = TRUE,            # Avoid label overlapping
  #              show.clust.cent = TRUE, # Show cluster centers
  #              palette = "jco",         # Color palette see ?ggpubr::ggpar
  #              ggtheme = theme_minimal(),
  #              main = "Factor map"
  # )
  
  
  # H <- Heatmap(nrc_mat)
  # cl = kmeans(nrc_mat, centers = 1)$cluster
  # pa = cluster::pam(nrc_mat, k = 3)
  # row_dend = as.dendrogram(hclust(dist(nrc_mat), method = "mcquitty"))
  # row_dend = color_branches(row_dend, k = 3)
  # column_dend = as.dendrogram(hclust(dist(t(nrc_mat)), method = "mcquitty"))
  # column_dend = color_branches(column_dend, k = 3)
  # 
  # a <- Heatmap(
  #   nrc_mat,
  #   # row_order = row_order(H),
  #   # column_order = column_order(H),
  #   row_names_side = c("left"),
  #   name = "NRC",
  #   col = colorRamp2(
  #     seq(0, 1, 0.1),
  #     hcl.colors(11, palette = "spectral")
  #   ),
  #   # column_title = "Normalized relative compression (NRC)",
  #   # clustering_distance_rows = "pearson",
  #   # clustering_distance_columns = "pearson",
  #   # clustering_method_rows = "ward.D",
  #   # clustering_method_columns = "ward.D",
  #   cluster_rows = row_dend,
  #   cluster_columns = column_dend,
  #   # cluster_rows = function(x) fastcluster::hclust(dist(x)),
  #   # cluster_columns = function(x) fastcluster::hclust(dist(x)),
  #   # row_km = 3, row_km_repeats = 100,
  #   # column_km = 3, column_km_repeats = 100,
  #   row_split = 3,
  #   column_split = 3,
  #   # row_split = paste0("pam", pa$clustering),
  #   # column_split = paste0("pam", pa$clustering),
  #   show_row_dend = FALSE,
  # )
  # 
  # # pdf("nrc.pdf", width = width, height = height)
  # # svg("nrc.svg", width = width, height = height)
  # draw(a)
  # # dev.off()
}

plot.nrc.ave.clus <- function(width, height) {
  nrc_mat <-
    as.matrix(read.table('result/nrc_ave.tsv', header = TRUE))
  
  H <- Heatmap(nrc_mat)
  
  a <- Heatmap(
    nrc_mat,
    # row_order = row_order(H),
    # row_order = NULL,
    # column_order = column_order(H),
    # column_order = NULL,
    row_names_side = c("left"),
    name = "NRC",
    col = colorRamp2(seq(0, 1, 0.1),
                     hcl.colors(11, palette = "spectral")),
    # column_title = "Normalized relative compression (NRC)",
    clustering_distance_rows = "pearson",
    clustering_distance_columns = "pearson",
    # row_km = 3, row_km_repeats = 100,
    # column_km = 3, column_km_repeats = 100,
    show_row_dend = FALSE,
  )
  
  # pdf("nrc.pdf", width = width, height = height)
  # svg("nrc_ave.svg", width = width, height = height)
  draw(a)
  # dev.off()
}

plot.nrc.clus(11, 10)
# plot.nrc.ave.clus(11, 10)