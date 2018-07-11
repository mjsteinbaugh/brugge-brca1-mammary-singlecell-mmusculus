# Cells per cluster
# August 14, 2017
source("setup.R")
library(tidyverse)

outputDir <- file.path("results", "cells_per_cluster")
dir.create(outputDir, recursive = TRUE, showWarnings = FALSE)

data(bcbFilteredSeurat)
seurat <- bcbFilteredSeurat
rm(bcbFilteredSeurat)

slotNames(seurat)

# Normalized counts
# seurat@data

# Cluster IDs per cell as named character vector
ident <- seurat@ident
head(ident)

meta <- seurat@meta.data %>%
    .[, c("sampleName", "genotype")]

master <- tibble(
    cellularBarcode = names(ident),
    cluster = ident) %>%
    cbind(meta) %>%
    arrange(sampleName, cluster)
write_csv(master, file.path(outputDir, "master.csv.gz"))

cellsPerCluster <- master %>%
    group_by(!!!syms(c("sampleName", "cluster"))) %>%
    summarize(count = n())
write_csv(cellsPerCluster, file.path(outputDir, "cellsPerCluster.csv.gz"))

relativeAbundance <- cellsPerCluster %>%
    group_by(sampleName) %>%
    mutate(sampleTotal = sum(count),
           relativeCount = count / sampleTotal)
write_csv(relativeAbundance, file.path(outputDir, "relativeAbundance.csv.gz"))

# PDF
ylab <- "relative abundance per sample"
pdf(file = file.path(outputDir, "relativeAbundance.pdf"),
    height = 10, width = 10)
ggplot(
    relativeAbundance,
    aes(x = sampleName,
        y = relativeCount,
        fill = cluster)) +
    geom_bar(stat = "identity") +
    labs(y = ylab) +
    theme(axis.text.x = element_text(angle = 90, hjust = 1, size = 10))
ggplot(
    relativeAbundance,
    aes(x = cluster,
        y = relativeCount,
        fill = cluster)) +
    geom_bar(stat = "identity") +
    facet_wrap(~sampleName) +
    labs(y = ylab) +
    theme(axis.text.x = element_text(size = 8))
ggplot(
    relativeAbundance,
    aes(x = cluster,
        y = relativeCount,
        fill = sampleName)) +
    geom_bar(stat = "identity") +
    labs(y = ylab)
ggplot(
    relativeAbundance,
    aes(x = sampleName,
        y = relativeCount,
        fill = sampleName)) +
    geom_bar(stat = "identity") +
    facet_wrap(~cluster) +
    labs(y = ylab) +
    theme(axis.text.x = element_blank(),
          axis.title.x = element_blank())
dev.off()
