## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(aidR)

## ----include=FALSE------------------------------------------------------------
path <- system.file("extdata", "tandem_source_example.zip", package = "aidR")
tmpdir <- file.path(tempdir(), "tandem_source_example")
unzip(path, exdir = tmpdir)
files <- list.files(tmpdir, recursive = TRUE)

## ----comment = "", echo = FALSE-----------------------------------------------
files

## ----comment = "", echo = FALSE-----------------------------------------------
writeLines(readLines(file.path(tmpdir, files[4]), n = 10))

## -----------------------------------------------------------------------------
data <- parse_data(id = "1", paths = path, clean = FALSE)

## ----comment=""---------------------------------------------------------------
head(data$cgm)

## ----comment=""---------------------------------------------------------------
head(data$basal)

## ----comment=""---------------------------------------------------------------
head(data$bolus)

## ----comment=""---------------------------------------------------------------
head(data$SMBG)

## ----comment=""---------------------------------------------------------------
head(data$hourly_basal)

