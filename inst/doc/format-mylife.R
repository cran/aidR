## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(aidR)

## ----include=FALSE------------------------------------------------------------
path <- system.file("extdata", "mylife_example.csv", package = "aidR")

## ----comment = "", echo = FALSE-----------------------------------------------
writeLines(readLines(path, n = 10))

## -----------------------------------------------------------------------------
data <- parse_data(id = "1", paths = path, clean = FALSE)

## ----comment=""---------------------------------------------------------------
head(data$Bolus)

## ----comment=""---------------------------------------------------------------
head(data$Kohlenhydrate)

## ----comment=""---------------------------------------------------------------
head(data$`Blutzucker manuelle Eingabe`)

