## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup, message = FALSE, include = FALSE----------------------------------
library(aidR)
library(dplyr)

## ----eval = FALSE-------------------------------------------------------------
# install.packages("aidR")
# library(aidR)

## ----eval=FALSE---------------------------------------------------------------
# data <- parse_data(id = "1", paths = "./exports/my_export_file.csv")

## ----eval=FALSE---------------------------------------------------------------
# data <- parse_data(id = "1", paths = c("./exports/my_export_file_id_1_month_1.csv",
#                                        "./exports/my_export_file_id_1_month_2.csv",
#                                        "./exports/my_export_file_id_1_month_3.csv"
#                                        )
#                    )

## -----------------------------------------------------------------------------
path <- system.file("extdata", "tidepool_example.xlsx", package = "aidR")
data_raw <- parse_data(id = "1", paths = path, clean = FALSE)
str(data_raw, max.level = 1)

## -----------------------------------------------------------------------------
path <- system.file("extdata", "tidepool_example.xlsx", package = "aidR")
data_clean <- parse_data(id = "1", paths = path, clean = TRUE)
str(data_clean, max.level = 1)

## ----echo = FALSE, comment = ""-----------------------------------------------
path <- system.file("extdata", "example_slowly_absorbed_carbs_glooko.csv", package = "aidR")
cat(readLines(path, n = 15), sep = "\n")

## ----eval = FALSE-------------------------------------------------------------
# data <- parse_data(id = "1", paths = path, merge_slow_carbs = FALSE)

## -----------------------------------------------------------------------------
nrow(data_clean$cgm)
data_clean_filter <- filter_CGM(data_clean)
nrow(data_clean_filter$cgm)

## ----echo = FALSE, comment = ""-----------------------------------------------
path <- system.file("extdata", "example_carb_override_glooko.csv", package = "aidR")
cat(readLines(path, n = 15), sep = "\n")

## -----------------------------------------------------------------------------
path <- system.file("extdata", "glooko_example.zip", package = "aidR")
data_clean_2 <- parse_data(id = "1", paths = path, clean = TRUE)
data_clean_filter_2 <- filter_carbs(data_clean_2)
removed_entries(data_clean_filter_2)

## -----------------------------------------------------------------------------
check_completeness(data_clean)

## -----------------------------------------------------------------------------
check_completeness_range(
  data_clean,
  first_date = "2019-01-10",
  last_date  = "2019-05-31"
)

## -----------------------------------------------------------------------------
glooko_path <- system.file("extdata", "glooko_example.zip", package = "aidR")
data_glooko <- parse_data(id = "1", paths = glooko_path)
check_insulin_totals(data_glooko)

## -----------------------------------------------------------------------------
totals <- suppressMessages(
  check_insulin_totals(data_glooko, types = c("basal", "bolus"))
)
totals

## ----fig.width=9, fig.height=6.5, out.width="100%"----------------------------
plot_day(data_clean, id = "1", days = "2019-04-01")

## -----------------------------------------------------------------------------
path_2 <- system.file("extdata", "glooko_example.zip", package = "aidR")
data_2  <- parse_data(id = "2", paths = path_2) # Note: clean = TRUE by default

all_data <- list("1" = data_clean, "2" = data_2)

combined <- merge_all(all_data)

str(combined, max.level = 1)
head(combined$cgm)
tail(combined$cgm)

## ----comment="", fig.width=12, fig.height=7, out.width="100%", warning=FALSE----
iglu_1 <- get_iglu_format(data_clean)
head(iglu_1)
iglu::plot_agp(iglu_1)

## ----comment="", eval = requireNamespace("cgmquantify", quietly = TRUE)-------
cgmq_1 <- get_cgmquantify_format(data_clean)
head(cgmq_1)
cgmquantify::interdaycv(cgmq_1)
cgmquantify::J_index(cgmq_1)

## -----------------------------------------------------------------------------
diax_dir <- tempfile()
dir.create(diax_dir)
write_DIAX_format(combined, prefix = file.path(diax_dir, "diax_id_"))
list.files(diax_dir)

## ----eval = FALSE-------------------------------------------------------------
# # Define a data frame: first column is id, second column the export paths
# # An id may appear multiple times if multiple exports (e.g. across many months) are available
# # Note: filenames are not used to determine the file type and/or id
# input <- data.frame(id = c("1", "1", "1", "2", "3", "3", "4", "5"),
#                     paths = c(
#                       "./tidepool_id_1_period_1.xlsx",
#                       "./tidepool_id_1_period_2.xlsx",
#                       "./tidepool_id_1_period_3.xlsx",
#                       "./glooko_period_1.zip",
#                       "./yourloops_1.zip",
#                       "./yourloops_2.zip",
#                       "./tidepool_id_4_period_1.xlsx",
#                       "./carelink.csv"
#                       )
#                     )
# ids <- unique(input$id)
# all_data <- list()
# 
# options(warn = 1) # warn immediately
# 
# for (id in ids) {
#   all_data[[id]]          <- parse_data(id, input$paths[input$id == id])
#   all_data[[id]]          <- filter_CGM(all_data[[id]])
#   all_data[[id]]          <- filter_carbs(all_data[[id]])
#   check_completeness(all_data[[id]])
#   check_insulin_totals(all_data[[id]])
# }
# combined <- merge_all(all_data)
# # Inspect a single day of a single subject
# plot_day(combined, id = "1", days = "2026-06-22")
# # write DIAX files
# diax_dir <- "./diax"
# write_DIAX_format(combined, prefix = file.path(diax_dir, "diax_id_"))
# # Plot using iglu
# iglu_combined <- get_iglu_format(combined)
# iglu::plot_glu(iglu_combined, subjects = "2")

