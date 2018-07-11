# v0.1.16
# This release is required to load raw counts from Cell Ranger
library(bcbioSingleCell)
bcb <- readCellRanger(
    uploadDir = "cellranger",
    format = "mtx",
    filtered = FALSE,
    organism = "Mus musculus",
    refdataDir = "refdata-cellranger-mm10-1.2.0",
    sampleMetadataFile = "meta/sample_metadata.xlsx",
    interestingGroups = "genotype"
)
flat <- flatFiles(bcb)
saveData(bcb, flat, dir = file.path("data", Sys.Date()))
