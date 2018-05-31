library(bcbioSingleCell)
bcb <- readCellRanger(
    uploadDir = "cellranger",
    refDataDir = "annotations/refdata-cellranger-mm10-1.2.0",
    sampleMetadataFile = "meta/sample_metadata.xlsx",
    interestingGroups = "genotype"
)
saveData(bcb, dir = file.path("data", Sys.Date()))
