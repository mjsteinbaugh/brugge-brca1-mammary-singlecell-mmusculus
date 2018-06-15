# v0.1.15
library(bcbioSingleCell)
bcb <- readCellRanger(
    uploadDir = "cellranger",
    refdataDir = "annotations/refdata-cellranger-mm10-1.2.0",
    sampleMetadataFile = "meta/sample_metadata.xlsx",
    interestingGroups = "genotype"
)
saveData(bcb, dir = file.path("data", Sys.Date()))
