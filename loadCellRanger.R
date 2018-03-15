library(bcbioSingleCell)
bcb <- loadCellRanger(
    uploadDir = "data/cellranger",
    refDataDir = "annotations/refdata-cellranger-mm10-1.2.0",
    sampleMetadataFile = "meta/sample_metadata.xlsx",
    interestingGroups = "genotype"
)
saveData(bcb, dir = "data")
