library(ggplot2)
# library(reshape2)
# library(scales)
# library(ggpubr)
# library(ggplotify)
library(factoextra)
library(cluster)
# library(biclust)
library(svglite)
library(dendextend)
# library(FactoMineR)
library(colorspace)
theme_set(theme_bw())

library(devtools)
# install_github("jokergoo/ComplexHeatmap")
library(ComplexHeatmap)
library(circlize)

plot.nrc <- function(width, height) {
  nrc_mat <- as.matrix(read.table('../result/nrc.tsv', header = TRUE))
  H <- Heatmap(nrc_mat)
  clus_colors <- rainbow_hcl(3, c = 90, l = 50)
  nrc_colors <- colorRamp2(seq(0, 1, 0.1), hcl.colors(11, palette = "spectral"))
  row_dend = as.dendrogram(hclust(dist(nrc_mat), method = "mcquitty"))
  row_dend = color_branches(row_dend, k = 3, col = clus_colors)
  column_dend = as.dendrogram(hclust(dist(t(nrc_mat)), method = "mcquitty"))
  column_dend = color_branches(column_dend, k = 3, col = clus_colors)

  a <- Heatmap(
    nrc_mat,
    row_names_side = c("left"),
    # column_names_side = c("top"),
    name = "NRC",
    col = nrc_colors,
    column_title = c(' '),
    column_title_side = c('bottom'),
    cluster_rows = FALSE,
    cluster_columns = FALSE,
    # show_heatmap_legend = FALSE
  )
  
  # pdf("nrc.pdf", width = width, height = height)
  svg("../result/nrc.svg", width = width, height = height)
  draw(a)
  dev.off()
}

plot.nrc.clus <- function(width, height) {
  nrc_mat <- as.matrix(read.table('../result/nrc.tsv', header = TRUE))
  
  # res <- hclust(dist(nrc_mat), method = "mcquitty")
  # res.pca <- PCA(nrc_mat, ncp = 3, graph = FALSE)
  # res.hcpc <- HCPC(res.pca, graph = FALSE)
  
  # fviz_dend(
  #   res,
  #   # rect = TRUE,
  #   # rect_fill = TRUE,
  #   k = 3,
  #   # k_colors = c("#2E9FDF", "#00AFBB", "#E7B800"),
  #   lwd = 1,
  #   # cex = 0.5,                 # label size
  #   # color_labels_by_k = TRUE,  # color labels by groups
  #   # palette = "jco",
  #   # ggtheme = theme_gray()     # Change theme
  #   cex = 0.7,                     # Label size
  #   palette = "jco",               # Color palette see ?ggpubr::ggpar
  #   rect = TRUE, rect_fill = TRUE, # Add rectangle around groups
  #   rect_border = "jco",           # Rectangle color
  #   # rect_border = c("#2E9FDF", "#00AFBB", "#E7B800"),           # Rectangle color
  #   labels_track_height = 0.8      # Augment the room for labels
  # )
  
  # fviz_cluster(res.hcpc,
  #              repel = TRUE,            # Avoid label overlapping
  #              show.clust.cent = TRUE, # Show cluster centers
  #              palette = "jco",         # Color palette see ?ggpubr::ggpar
  #              ggtheme = theme_minimal(),
  #              main = "Factor map"
  # )
  
  H <- Heatmap(nrc_mat)
  clus_colors <- rainbow_hcl(3, c = 90, l = 50)
  nrc_colors <- colorRamp2(seq(0, 1, 0.1), hcl.colors(11, palette = "spectral"))
  row_dend = as.dendrogram(hclust(dist(nrc_mat), method = "mcquitty"))
  row_dend = color_branches(row_dend, k = 3, col = clus_colors)
  column_dend = as.dendrogram(hclust(dist(t(nrc_mat)), method = "mcquitty"))
  column_dend = color_branches(column_dend, k = 3, col = clus_colors)
  pa = cluster::pam(nrc_mat, k = 3)
  
  a <- Heatmap(
    nrc_mat,
    row_names_side = c("left"),
    # column_names_side = c("top"),
    name = "NRC",
    col = nrc_colors,
    # clustering_method_rows = "mcquitty",
    # clustering_method_columns = "mcquitty",
    cluster_rows = row_dend,
    cluster_columns = column_dend,
    column_dend_height = unit(1.5, "cm"),
    row_split = 3,
    column_split = 3,
    row_title = c('Mammalia', 'Chondrichthyes', 'Actinopterygii'),
    # row_title_side = c('right'),
    column_title = c('Mammalia', 'Chondrichthyes', 'Actinopterygii'),
    column_title_side = c('bottom'),
    row_names_gp = gpar(col = clus_colors),
    column_names_gp = gpar(col = clus_colors),
    # row_split = paste0("pam", pa$clustering),
    # column_split = paste0("pam", pa$clustering),
    # show_row_dend = FALSE,
    show_column_dend = FALSE
  )
  
  # pdf("../result/nrc_clustered.pdf", width = width, height = height)
  svg("../result/nrc_clustered.svg", width = width, height = height)
  draw(a, heatmap_legend_side = "right")
  dev.off()
}

plot.nrc.ave.clus <- function(width, height) {
  nrc_mat <-
    as.matrix(read.table('../result/nrc_ave.tsv', header = TRUE))
  
  H <- Heatmap(nrc_mat)
  
  a <- Heatmap(
    nrc_mat,
    # row_order = row_order(H),
    # column_order = column_order(H),
    row_names_side = c("left"),
    name = "NRC",
    col = nrc_colors,
    # column_title = "Normalized relative compression (NRC)",
    clustering_distance_rows = "pearson",
    clustering_distance_columns = "pearson",
    # row_km = 3, row_km_repeats = 100,
    # column_km = 3, column_km_repeats = 100,
    show_row_dend = FALSE,
  )
  
  # pdf("../result/nrc_clustered_ave.pdf", width = width, height = height)
  svg("../result/nrc_clustered_ave.svg", width = width, height = height)
  draw(a)
  dev.off()
}

plot.nrc(8, 7)
plot.nrc.clus(8, 7)
# plot.nrc.ave.clus(11, 10)