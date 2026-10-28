## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(aidR)

## ----include=FALSE------------------------------------------------------------
path <- system.file("extdata", "dexcom_clarity_example.csv", package = "aidR")

## ----comment = "", echo = FALSE-----------------------------------------------
writeLines(readLines(path, n = 80))

## -----------------------------------------------------------------------------
data <- parse_data(id = "1", paths = path, clean = FALSE)

## ----comment=""---------------------------------------------------------------
head(data$cgm)

## -----------------------------------------------------------------------------
data_clean <- parse_data(id = "1", paths = path)
head(data_clean$cgm)

