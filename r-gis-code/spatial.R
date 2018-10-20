#! /usr/bin/env Rscript

install.packages(c(
  "tidyverse",
  "ggmap",
  "odbc",
  "RPostgres",
  "RSQLite",
  "sf",
  "sp",
  "stplanr",
  "tmap"),
  quiet = TRUE)
devtools::install_github("hrbrmstr/lodes", force=TRUE, build_vignettes = TRUE, quiet = TRUE)
