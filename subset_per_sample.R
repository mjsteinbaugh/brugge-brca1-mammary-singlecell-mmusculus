library(bcbioSingleCell)
loadData(bcbFiltered, dir = "data")
sampleSubsets <- subsetPerSample(bcbFiltered)
saveData(sampleSubsets, dir = "data")
