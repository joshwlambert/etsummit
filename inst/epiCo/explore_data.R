# script to explore the temporal information in google trend and incidence data on Dengue

# load required packages
library(tibble)
library(incidence2)
library(ggplot2)
library(tidyr)

# read incidence data
incidence <- readRDS(system.file("epiCo", "inc_dep.rds", package = "etsummit", mustWork = TRUE))

# convert incidence to <incidence2>
# incidence <- incidence2::incidence()

# read in google dengue data
google_dengue_data <- read.csv(
  file = system.file(
    "epiCo", "google_dengue.csv",
    package = "etsummit",
    mustWork = TRUE
  ),
  sep = ";"
)

# explore google dengue data
dim(google_dengue_data)

# convert google dengue data to tibble
google_dengue_data <- tibble::as_tibble(google_dengue_data)

# convert date column to <Date>
google_dengue_data$date <- as.Date(google_dengue_data$date)

# create data frame of aggregrated incidence across Colombian departments
col_incidence <- data.frame(
  dates = incidence$dates,
  count = apply(incidence$counts, MARGIN = 1, FUN = sum)
)

# convert Colombia incidence data to tibble
col_incidence <- tibble::as_tibble(col_incidence)

# plot the incidence over time
ggplot2::ggplot(data = col_incidence) +
  ggplot2::geom_line(mapping = ggplot2::aes(x = dates, y = count)) +
  ggplot2::scale_x_continuous(name = "Dates") +
  ggplot2::scale_y_continuous(name = "Colombia Incidence Count") +
  ggplot2::theme_bw()

# create a data frame that has one column per Colombian department
col_departs_incidence <- data.frame(dates = incidence$dates)
col_departs_incidence <- cbind(col_departs_incidence, incidence$counts)
colnames(col_departs_incidence)
col_departs_incidence <- tibble::as_tibble(col_departs_incidence)

# tidy to department incidence long data
col_departs_incidence <- tidyr::pivot_longer(
  data = col_departs_incidence,
  cols = !dates,
  names_to = "depart_incidence",
  values_to = "count"
)

# plot the incidence for each department
ggplot2::ggplot(data = col_departs_incidence) +
  ggplot2::geom_line(
    mapping = ggplot2::aes(x = dates, y = count, colour = depart_incidence)
  ) +
  ggplot2::scale_x_date(name = "Dates") +
  ggplot2::scale_y_continuous(name = "Colombia Department Incidence Count") +
  ggplot2::theme_bw() +
  ggplot2::scale_colour_viridis_d(option="magma")

# tidy to google data long data
google_dengue_data_tidy <- tidyr::pivot_longer(
  data = google_dengue_data,
  cols = !date & !Region,
  names_to = "dengue_search_terms",
  values_to = "count"
)

# explore google data
google_dengue_data_tidy
unique(google_dengue_data_tidy$Region)
unique(google_dengue_data_tidy$dengue_search_terms)

# subset by one of the search terms to visualise
google_dengue_tidy_dengue <- subset(google_dengue_data_tidy, dengue_search_terms == "dengue")

# plot the google data
ggplot2::ggplot(data = google_dengue_tidy_dengue) +
  ggplot2::geom_point(mapping = ggplot2::aes(x = date, y = count, colour = Region)) +
  ggplot2::scale_x_date(name = "Dates") +
  ggplot2::scale_y_continuous(name = "Colombia Region Dengue Searches") +
  ggplot2::theme_bw() +
  ggplot2::scale_colour_viridis_d(option="magma")

# subset by mosquito.dengue of the search terms to visualise
google_dengue_tidy_mos <- subset(google_dengue_data_tidy, dengue_search_terms == "mosquito.dengue")

# plot the google data
ggplot2::ggplot(data = google_dengue_tidy_mos) +
  ggplot2::geom_point(mapping = ggplot2::aes(x = date, y = count, colour = Region)) +
  ggplot2::scale_x_date(name = "Dates") +
  ggplot2::scale_y_continuous(name = "Colombia Region Dengue Searches") +
  ggplot2::theme_bw() +
  ggplot2::scale_colour_viridis_d(option="magma")

# facet plot by each search term
ggplot2::ggplot(data = google_dengue_data_tidy) +
  ggplot2::geom_point(mapping = ggplot2::aes(x = date, y = count, colour = Region)) +
  ggplot2::facet_wrap(facets = ggplot2::vars(dengue_search_terms))

