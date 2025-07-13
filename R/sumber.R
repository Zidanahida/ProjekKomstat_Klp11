sumber_ui <- function(id){
  tabPanel(id, 
           div(
             style = "
               background-color: #111827; 
               border-radius: 15px; 
               padding: 20px; 
               color: white; 
               box-shadow: 0 4px 8px rgba(0,0,0,0.3); 
               margin-bottom: 20px;",
             
             h3("Sumber Data", style = "font-weight:bold;"),
             p("Data Emisi Gas Metana dan Luas Area Negara ASEAN dalam dashboard ini diperoleh dari beberapa sumber resmi berikut:"),
             
             # FAO
             div(
               style = "
                 background-color: #d1d5db;
                 border-radius: 15px;
                 padding: 20px;
                 color: #111827;
                 box-shadow: 0 2px 4px rgba(0,0,0,0.2);
                 margin-bottom: 20px;
                 border: 2px solid #e5e7eb;",
               tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/db/FAO_logo.svg/2017px-FAO_logo.svg.png", 
                        style = "width:40px; margin-bottom:10px;"),
               h4("FAOSTAT Emisi Gas Rumah Kaca", style="font-weight:bold;"),
               p("Disediakan oleh FAO (Food and Agriculture Organization)."),
               tags$a("Kunjungi FAOSTAT", href = "https://www.fao.org/faostat/en/#data/GT", 
                      target = "_blank", 
                      style = "color:#3B82F6; font-weight:bold; text-decoration:none;")
             ),
             
             # World Bank
             div(
               style = "
                 background-color: #d1d5db;
                 border-radius: 15px;
                 padding: 20px;
                 color: #111827;
                 box-shadow: 0 2px 4px rgba(0,0,0,0.2);
                 margin-bottom: 20px;
                 border: 2px solid #e5e7eb;",
               tags$img(src = "https://ifs.org.uk/sites/default/files/styles/og_image/public/2025-04/The%20World%20Bank%20Group%20logo.png?itok=-MahtDxK", 
                        style = "width:70px; margin-bottom:10px;"),
               h4("World Bank Surface Area Data", style="font-weight:bold;"),
               p("Luas permukaan negara berdasarkan data dari World Bank."),
               tags$a("Kunjungi World Bank", href = "https://data.worldbank.org/indicator/AG.SRF.TOTL.K2", 
                      target = "_blank", 
                      style = "color:#3B82F6; font-weight:bold; text-decoration:none;")
             ),
             
             # GeoJSON
             div(
               style = "
                 background-color: #d1d5db;
                 border-radius: 15px;
                 padding: 20px;
                 color: #111827;
                 box-shadow: 0 2px 4px rgba(0,0,0,0.2);
                 margin-bottom: 20px;
                 border: 2px solid #e5e7eb;",
               tags$img(src = "https://plugins.jetbrains.com/files/26592/724922/icon/default.svg", 
                        style = "width:40px; margin-bottom:10px;"),
               h4("GeoJSON ASEAN Maps", style="font-weight:bold;"),
               p("Peta wilayah Asia Tenggara berbasis GeoJSON."),
               tags$a("Kunjungi GeoJSON Maps", href = "https://geojson-maps.kyd.au/?utm_source=self&utm_medium=redirect", 
                      target = "_blank", 
                      style = "color:#3B82F6; font-weight:bold; text-decoration:none;")
             ),
             
             p("Periode data yang digunakan: 2000–2022.")
           ),
           
           div(
             style = "
               background-color: #111827; 
               border-radius: 15px; 
               padding: 20px; 
               color: white; 
               box-shadow: 0 4px 8px rgba(0,0,0,0.3); 
               margin-bottom: 20px;",
             
             div(style = "display:flex; gap:10px;",
                 tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/R_logo.svg/724px-R_logo.svg.png", style = "width:38px;"),
                 tags$img(src = "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bf/Shiny_hex_logo.svg/1774px-Shiny_hex_logo.svg.png", style = "width:38px;"),
                 tags$img(src = "https://readxl.tidyverse.org/logo.png", style = "width:38px;"),
                 tags$img(src = "https://www.zigya.com/blog/wp-content/uploads/2021/01/tidyr.png", style = "width:38px;"),
                 tags$img(src = "https://media.robotwealth.com/wp-content/uploads/2020/04/21162058/dplyr.png", style = "width:38px;"),
                 tags$img(src = "https://ggplot2.tidyverse.org/logo.png", style = "width:38px;"),
                 tags$img(src = "https://rstudio.github.io/bslib/logo.png", style = "width:38px;"),
                 tags$img(src = "https://cran.r-project.org/web/packages/plotly/readme/man/figures/plotly.png", style = "width:38px;"),
                 tags$img(src = "https://rstudio.github.io/bslib/logo.png", style = "width:38px;"),
                 tags$img(src = "https://r-spatial.github.io/sf/logo.png", style = "width:38px;"),
                 
             ),
             p("Data dalam dashboard ini diambil dari beberapa sumber resmi yang memuat estimasi emisi gas metana di kawasan Asia Tenggara. 
               Data diproses untuk keperluan edukasi dan analisis akademik."),
             p("Pengolahan data menggunakan R dengan bantuan package:"),
             tags$ul(
               tags$li("`readxl`, `tidyr`, `dplyr`, `ggplot2`, `shiny`, `bslib`, `plotly`, `RColorBrewer`, dan `sf`.")
             )
           )
  )
}
