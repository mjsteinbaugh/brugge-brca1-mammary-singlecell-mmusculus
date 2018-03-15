library(Seurat)
library(tidyverse)

load("data/bcbFilteredSeurat.rda")

seurat <- bcbFilteredSeurat
print(seurat)

# Generate gene-cell matrices using the raw counts
counts <- seurat@raw.data
dim(counts)
# 27998 16928

# Cell cluster identity mappings
ident <- seurat@ident

class(ident)
# factor

length(ident)
# 16928

# Split the main counts matrix per cluster, but keep the counts sparse
counts_by_cluster <- lapply(seq_along(levels(ident)), function(a) {
    cells <- ident[ident == a]
    counts[, sort(names(cells)), drop = FALSE]
})
save(counts_by_cluster, file = "data/counts_by_cluster.rda")

# Now we want to loop across our sparse counts list, make dense, and write as CSV file
resultsDir <- "results/counts_by_cluster"
dir.create(resultsDir, recursive = TRUE)
invisible(lapply(
    seq_along(counts_by_cluster), function(a) {
        cluster <- levels(ident)[[a]]
        matrix <- as.matrix(counts_by_cluster[[a]])
        write.csv(matrix, file = file.path(resultsDir, paste0("cluster", cluster, ".csv")))
    }
))
