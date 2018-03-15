library(basejump)
library(tidyverse)

load("data/bcb.rda")
load("data/differential_expression.rda")

resultsDir <-
    file.path("results",
              "differential_expression",
              "seurat",
              "NegBinomDETest")
dir.create(resultsDir, recursive = TRUE, showWarnings = FALSE)



g2s <- metadata(bcb)$gene2symbol
# Use fresh annotations from ensembldb instead
# rowdata <- as.data.frame(rowData(bcb))
anno <- annotable("Mus musculus", release = 90)



# Save the DEG results tables. P value only, no fold change — this isn't output by Seurat currently.
deg_tables <- lapply(differential_expression, function(object) {
    object %>%
        camel %>%
        rownames_to_column("symbol") %>%
        as_tibble %>%
        left_join(g2s, by = "symbol") %>%
        # Re-map Ensembl 90 symbols based off gene identifier
        select(-symbol) %>%
        left_join(anno, by = "ensgene") %>%
        select(ensgene, symbol, pVal, description, biotype) %>%
        arrange(pVal)
})
saveData(deg_tables)



# Write the CSVs to disk (e.g. "cluster_0.csv")
lapply(seq_along(deg_tables), function(a) {
    name <- paste("cluster", names(deg_tables)[[a]], sep = "_")
    tbl <- deg_tables[[a]]
    readr::write_csv(tbl, file.path(resultsDir, paste0(name, ".csv.gz")))
}) %>%
    invisible
