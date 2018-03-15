source("setup.R")
library(Seurat)
library(tidyverse)

data(seuratTCellRemoval)
seurat <- seuratTCellRemoval
rm(seuratTCellRemoval)

colors <- c(WT = "darkgray", Het = "purple")

help("FetchData", "Seurat")

genes <- c("Cd24a", "Muc1")
unscaled <- FetchData(
    object = seurat,
    vars.all = genes,
    use.scaled = FALSE)
scaled <- FetchData(
    object = seurat,
    vars.all = genes,
    use.scaled = TRUE)

meta <- seurat@meta.data %>%
    as("tibble") %>%
    select(rowname, sampleName, genotype)
    
# Remove zero counts
unscaled_nonzero <- unscaled %>%
    .[!(apply(., 1, function(a) any(a == 0))), , drop = FALSE] %>%
    as("tibble") %>%
    left_join(meta)

# Scaled quadrant
scaled_quadrant <- scaled %>%
    as("tibble") %>%
    # Cd24a low (x-axis)
    filter(Cd24a < 0) %>%
    # Muc1 high (y-axis)
    filter(Muc1 > 0) %>%
    left_join(meta)



# Correlations ====
# gene.cor <- round(x = cor(x = data.plot$x, y = data.plot$y), digits = 2)
scaled_quadrant_wt <- scaled_quadrant %>%
    filter(genotype == "WT")
scaled_quadrant_het <- scaled_quadrant %>%
    filter(genotype == "Het")
unscaled_nonzero_wt <- unscaled_nonzero %>%
    filter(genotype == "WT")
unscaled_nonzero_het <- unscaled_nonzero %>%
    filter(genotype == "Het")

scaled_cor_wt <-
    cor(x = scaled_quadrant_wt$Cd24a,
        y = scaled_quadrant_wt$Muc1,
        method = "pearson") %>%
    round(digits = 3)
scaled_cor_het <-
    cor(x = scaled_quadrant_het$Cd24a,
        y = scaled_quadrant_het$Muc1,
        method = "pearson") %>%
    round(digits = 3)
unscaled_cor_wt <-
    cor(x = unscaled_nonzero_wt$Cd24a,
        y = unscaled_nonzero_wt$Muc1,
        method = "pearson") %>%
    round(digits = 3)
unscaled_cor_het <-
    cor(x = unscaled_nonzero_het$Cd24a,
        y = unscaled_nonzero_het$Muc1,
        method = "pearson") %>%
    round(digits = 3)

writeLines(c(
    paste("WT quadrant (scaled):", scaled_cor_wt),
    paste("Het quadrant (scaled):", scaled_cor_het),
    paste("WT non-zero (unscaled):", unscaled_cor_wt),
    paste("Het non-zero (unscaled):", unscaled_cor_het)
))



# Statistical test approach ====
# Wilcoxon signed-rank test
# Wilcoxon-Mann-Whitney test (Mann-Whitney U test)
# https://en.wikipedia.org/wiki/Wilcoxon_signed-rank_test
# https://stat.ethz.ch/R-manual/R-devel/library/stats/html/wilcox.test.html
# Already supported in limma?
# help("rankSumTestWithCorrelation", "limma")
# help("wilcox.test", "stats")
# wilcox.test(x, y = NULL,
#             alternative = c("two.sided", "less", "greater"),
#             mu = 0, paired = FALSE, exact = NULL, correct = TRUE,
#             conf.int = FALSE, conf.level = 0.95, ...)



# Plot and save PDF ====
pdf(file.path("results", "cd24a_low_muc1_high_correlation.pdf"),
    height = 8, width = 8)
ggplot(scaled_quadrant,
       aes(x = Cd24a,
           y = Muc1,
           color = genotype)) +
    geom_point(size = 2) +
    ggtitle("Muc1 high, Cd24a low quadrant (scaled)") +
    scale_color_manual(values = colors)
ggplot(unscaled_nonzero,
       aes(x = Cd24a,
           y = Muc1,
           color = genotype)) +
    geom_point(size = 2) +
    scale_color_manual(values = colors) +
    ggtitle("non-zero counts (unscaled)")
dev.off()

