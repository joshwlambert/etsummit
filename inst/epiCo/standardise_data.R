# script to standardise working with google trend data to predict incidence/outbreak

# load required packages
library(tibble)
library(janitor)


# read in google dengue data
google_dengue_data <- read.csv(
  file = system.file(
    "epiCo", "google_dengue.csv",
    package = "etsummit",
    mustWork = TRUE
  ),
  sep = ";"
)

# convert google dengue data to tibble
google_dengue_data <- tibble::as_tibble(google_dengue_data)

# clean column names
google_dengue_data <- janitor::clean_names(google_dengue_data)

# read in department dictionary
col_departs <- readRDS(system.file("epiCo", "col_departs.rds", package = "etsummit", mustWork = TRUE))

# convert regions to departments
google_dengue_data$region <- dplyr::case_match(
  .x = google_dengue_data$region,
  "CO-ANT" ~ "05",
  "CO-BOY" ~ "15",
  "CO-CAL" ~ "17",
  "CO-CUN" ~ "25",
  "CO-HUI" ~ "41",
  "CO-NSA" ~ "54",
  "CO-QUI" ~ "63",
  "CO-RIS" ~ "66",
  "CO-SAN" ~ "68",
  "CO-TOL" ~ "73",
  .default = NA
)
colnames(google_dengue_data)[which(colnames(google_dengue_data) == "region")] <- "department"

