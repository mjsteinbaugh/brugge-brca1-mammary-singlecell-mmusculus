# bcbioSinglecell ====
library(bcbioSinglecell)

# knitr ====
library(knitr)
opts_chunk$set(
    audodep = TRUE,
    cache = TRUE,
    cache.lazy = FALSE,
    dev = c("png", "pdf", "svg"),
    error = FALSE,
    fig.height = 6,
    fig.retina = 2,
    fig.width = 6,
    message = TRUE,
    tidy = TRUE,
    warning = TRUE)

# ggplot2 ====
library(ggplot2)
theme_set(theme_light(base_size = 14))
