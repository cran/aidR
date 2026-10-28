## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE---------------------------------------------------
library(aidR)

## ----include=FALSE------------------------------------------------------------
path <- system.file("extdata", "glooko_example.zip", package = "aidR")
tmpdir <- file.path(tempdir(), "glooko_example")
unzip(path, exdir = tmpdir)
files <- list.files(tmpdir, recursive = TRUE)

## ----comment = "", echo = FALSE-----------------------------------------------
sub("^[^/]+/", "", files) # removes glooko_example/ prefix

## ----comment = "", echo = FALSE-----------------------------------------------
writeLines(readLines(file.path(tmpdir, files[4]), n = 10))

## -----------------------------------------------------------------------------
data <- parse_data(id = "1", paths = path, clean = FALSE)

## ----comment=""---------------------------------------------------------------
head(data$alarm)

## ----comment=""---------------------------------------------------------------
head(data$SMBG)

## ----comment=""---------------------------------------------------------------
head(data$carbs_manual)

## ----comment=""---------------------------------------------------------------
head(data$cgm)

## ----comment=""---------------------------------------------------------------
head(data$basal)

## ----comment=""---------------------------------------------------------------
head(data$bolus)

## ----comment=""---------------------------------------------------------------
head(data$total_insulin)

