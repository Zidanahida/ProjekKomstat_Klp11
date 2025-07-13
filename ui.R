# Load sumber eksternal
source("R/home.R")
source("R/menu.R")
source("R/sumber.R")
source("R/aboutUs.R")
source("R/userGuide.R")
#library(shinyjs)
#library(bslib)
#library(leaflet)
#library(sf)
#library(dplyr)
#library(shiny)
#library(bslib)
#library(ggplot2)
#library(tidyr)
#library(plotly)
#library(RColorBrewer)
#library(leaflet)
#library(sf)
#library(tidyr)
library(readxl)
library(dplyr)
library(tidyr)
library(leaflet)
library(bslib)
library(plotly)
library(sf)
library(vembedr)

# UI ----
fluidPage(
  theme = bslib::bs_theme(version = 5),#bootstrap 
  includeCSS("www/css/style.css"),
  navbarPage(
    title = "CH4.SEasia",
    id = "mainNavbar",
    collapsible = TRUE,
    tabPanel("Beranda", home_ui("home")),
    navbarMenu("Menu", menu1_ui("menu1"), menu2_ui("menu2")),
    tabPanel("Sumber", sumber_ui("Sumber")),
    tabPanel("Unduh Data", unduh_ui("unduh")),
    tabPanel("Tentang Kami", tentangKami_ui("tentang_kami")),
    tabPanel("UserGuide",userGuide_ui("User_Guide"))
  )
)

