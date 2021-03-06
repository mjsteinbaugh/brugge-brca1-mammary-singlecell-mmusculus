library(edgeR)
library(basejump)
library(pbapply)
library(tidyverse)

de_dir <- file.path("results", "differential_expression", "zinger_edger")
dir.create(de_dir, recursive = TRUE, showWarnings = FALSE)

# Current Ensembl mouse annotations
anno <- annotable("Mus musculus")

cluster_de_files <-
  dir("data",
      pattern = "zinger_edger_lrt_cluster_",
      full.names = TRUE)

pblapply(seq_along(cluster_de_files), function(a) {
  dge_name <- load(cluster_de_files[[a]])
  message(dge_name)
  dge <- get(dge_name, inherits = FALSE)
  tbl <- rownames_to_column(dge$table, "ensgene") %>%
    left_join(anno, by = "ensgene")
  write_csv(tbl, file.path(de_dir, paste0(dge_name, ".csv.gz")))
}) %>%
  invisible()
