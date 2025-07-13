#install.packages("sf")
#install.packages("leaflet")
#install.packages("plotly")
#install.packages("readxl")
#install.packages("tidyr")
#install.packages("dplyr")
#install.packages("ggplot")
#install.packages("bslib")
#install.packages("shiny")
#install.packages("htmltools")
library(readxl)
library(dplyr)
library(tidyr)
library(leaflet)
library(bslib)
library(plotly)
library(sf)
library(vembedr)
library(htmltools)

#import Data
dataMain <- read_xls("data/DATA FAO.xls")
areaAsia <- read_xls("data/Data Area.xls")

# data luas negara
areaAsia <- areaAsia %>%
  filter(`Country Name` %in% c(
    "Indonesia", "Thailand", "Lao PDR", "Viet Nam", "Singapore", "Malaysia", 
    "Timor-Leste", "Philippines", "Cambodia", "Brunei Darussalam", "Myanmar"
  )) %>%
  mutate(`Country Name` = case_when(
    `Country Name` == "Lao PDR" ~ "Laos",
    `Country Name` == "Viet Nam" ~ "Vietnam",
    `Country Name` == "Brunei Darussalam" ~ "Brunei-Darussalam",
    TRUE ~ `Country Name`
  )) %>%
  pivot_longer(
    cols = -`Country Name`,
    names_to = "Year",
    values_to = "Area"
  ) %>%
  mutate(
    Year = as.numeric(Year),
    Area = as.numeric(Area)
  )


# Pembersihan data
dataClean <- dataMain %>%
  select(Area, Item, Year, Value) %>%
  mutate(
    Area = case_when(
      Area == "Lao People's Democratic Republic" ~ "Laos",
      Area == "Viet Nam" ~ "Vietnam",
      Area == "Brunei Darussalam" ~ "Brunei-Darussalam",
      TRUE ~ Area
    ),
    Year = as.numeric(Year)
  ) %>%
  left_join(areaAsia, by = c("Area" = "Country Name", "Year" = "Year"))


# Gabungkan dengan data luas area
AdjTimeSeries <- dataClean %>%
  group_by(Year, Area) %>%
  summarise(avg_emissions = sum(Value, na.rm = TRUE), .groups = "drop") %>%
  left_join(areaAsia, by = c("Area" = "Country Name", "Year" = "Year")) %>%
  mutate(avg_emissions_adj = avg_emissions / Area.y) %>%
  filter(!is.na(avg_emissions_adj))  # Pastikan tidak ada NA

# Nama negara
areas <- sort(unique(areaAsia$`Country Name`))
