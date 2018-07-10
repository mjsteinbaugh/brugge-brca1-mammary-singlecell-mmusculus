# v0.1.17
library(bcbioSingleCell)
bcb <- readCellRanger(
    uploadDir = "cellranger",
    format = "mtx",
    filtered = FALSE,
    sampleMetadataFile = "meta/sample_metadata.xlsx",
    organism = "Mus musculus",
    refdataDir = "refdata-cellranger-mm10-1.2.0",
    interestingGroups = "genotype"
)
flat <- flatFiles(bcb)
saveData(bcb, flat, dir = file.path("data", Sys.Date()))
