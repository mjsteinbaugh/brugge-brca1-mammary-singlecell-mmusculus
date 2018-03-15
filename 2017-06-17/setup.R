# ggplot2 ====
library(ggplot2)
theme_set(theme_light(base_size = 14))

# knitr ====
library(knitr)
opts_chunk$set(
    audodep = TRUE,
    cache = TRUE,
    cache.lazy = FALSE,
    dev = c("png", "pdf", "svg"),
    error = FALSE,
    fig.height = 7,
    fig.width = 7,
    message = TRUE,
    tidy = TRUE,
    warning = TRUE)

# bcbioSinglecell ====
library(bcbioSinglecell)
