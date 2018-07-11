# seurat object
# load("~/Dropbox (HBC)/Consults/joan_brugge/brca1_mouse_mammary_scrnaseq/bcbFilteredSeuratSubset.rda")
seuratName <- load("~/Dropbox (HBC)/Consults/suzanne_devkota/cedars_gut_scrnaseq/bcb_filtered_seurat.rda")
seurat <- get(seuratName, inherits = FALSE)

# markers object
# load("~/Dropbox (HBC)/Consults/joan_brugge/brca1_mouse_mammary_scrnaseq/bcbFilteredMarkers.rda")
markersName <- load("~/Dropbox (HBC)/Consults/suzanne_devkota/cedars_gut_scrnaseq/bcb_filtered_seurat_markers.rda")
markers <- get(markersName, inherits = FALSE)

# FIXME
# Marker data.frame must contain: cluster, ensgene, symbol, pvalue
# Let's coerece this instead

# Rethink the code in the tSNE method

top <- topMarkers(markers)

# Let's take the top markers specific to cluster 0, as an example
cluster4 <- top %>%
    filter(cluster == 4) %>%
    pull(symbol)

# Fetch the t-SNE expression data for the desired gene symbols
dat <- fetchTSNEExpressionData(seurat, cluster4)
print(unique(dat$gene))

# To make t-SNE plot colored by geometric mean of topGenes
plotTSNEExpressionData(dat, colorpoints = "geomean")

# To make faceted t-SNE plot of each gene (looks good at up to 6 genes)
plotTSNEExpressionData(dat, colorpoints = "expression") +
    facet_wrap(~gene)
