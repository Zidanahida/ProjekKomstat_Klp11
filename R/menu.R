# menu.R

menu1_ui <- function(id) {
  ns <- NS(id)
  tabPanel("Emisi Gas Metana Berdasarkan Kategori Sumber",
           sidebarLayout(sidebarPanel(selectInput("negara_pilih", "Negara:", choices = unique(dataClean$Area), selected = "Indonesia"),
                                      checkboxGroupInput("kategori", "Kategori:", choices = unique(dataClean$Item),
                                                         # >>> PERUBAHAN DI BARIS INI <<<
                                                         selected = c("Manure Management", "Fires in organic soils", "Agrifood Systems Waste Disposal")),
                                      # >>> AKHIR PERUBAHAN <<<
                                      checkboxInput("select_all", "Pilih Semua Kategori", value = FALSE)
           ),
           mainPanel(div(
             style = "background-color: white; text-align:center; padding: 15px; border-radius: 5px; margin-bottom: 15px;",
             h3(strong("Emisi Gas Metana Berdasarkan Kategori Sumber"))
           ),
           fluidRow(column(8,plotlyOutput("barChart")),
                    column(4, card(div(style = "border-radius: 5px;",
                                       p(strong("Deskripsi")),
                                       p("Data merupakan rata-rata sepanjang tahun 2019–2022."),
                                       p(strong("Satuan")),
                                       p("Kilo Ton (Kt)"),
                                       p(strong("Terakhir Diupdate")),
                                       p("05 Mei 2025"),
                                       p(strong("Sumber Data")),
                                       a("https://www.fao.org/faostat/en/#data/GT",
                                         href = "https://www.fao.org/faostat/en/#data/GT", target = "_blank")
                    )
                    )
                    )
           ),
           fluidRow(
             column(12,
                    wellPanel(
                      h4("Analisis Kategori Sumber Emisi Terpilih"),
                      uiOutput("dynamic_interpretation_menu1")
                    )
             )
           )
           )
           )
  )
}

menu2_ui <- function(id){
  # ns <- NS(id) # Baris ini tidak digunakan untuk input/output ID jika server tidak pakai moduleServer dengan ns()
  tabPanel("Time Series Metana Berdasarkan Rata-Rata setiap Negara",
           fluidRow( # FluidRow ini berisi sidebar (kiri), grafik (tengah), dan deskripsi (kanan)
             column(width = 3,wellPanel( # Kolom Sidebar
               h4("Negara"),
               checkboxGroupInput("negara", "Pilih Negara",
                                  choices = sort(unique(areas)),
                                  selected = c("Thailand", "Malaysia", "Indonesia", "Singapore"),
                                  inline = FALSE),
               
               h4("Moving Average"),
               selectInput("movingAvg", "Moving Average",
                           choices = c("None" = "none", "3rd-Moving Average" = "3", "5th-Moving Average" = "5"),
                           selected = "none")
             )),
             column(width = 6, # Kolom untuk Grafik
                    h3("Emisi Gas Metana Berdasarkan Sumber", align = "center"),
                    plotOutput("plotEmisi", height = "500px", width = "100%")
                    # >>> Kotak analisis TIDAK lagi di sini <<<
             ),
             column(width = 3, # Kolom untuk Deskripsi
                    wellPanel(
                      strong("Deskripsi"), br(),
                      "Grafik ini ditujukan untuk membandingkan output gas metana yang dilepaskan ke atmosfer dari setiap negara di Asia Tenggara.", br(), br(),
                      strong("Satuan"), br(),
                      "Kilo Ton (Kt) 1000 Ton", br(), br(),
                      strong("Terakhir Diupdate"), br(),
                      "05 Mei 2025", br(), br(),
                      strong("Sumber Data"), br(),
                      tags$a(
                        href = "https://www.fao.org/faostat/en/#data/GT",
                        "https://www.fao.org/faostat/en/#data/GT",
                        target = "_blank",
                        style = "word-break: break-all; color: #0645ad; text-decoration: underline; max-width: 100%; display: inline-block; line-height: 1.2;"
                      )
                    )
             )
           ), # >>> AKHIR DARI FLUIDROW PERTAMA (yang berisi 3 kolom di atas) <<<
           
           # --- Tambahkan FLUIDROW BARU ini untuk kotak interpretasi dinamis yang full-width ---
           fluidRow(
             column(width = 12, # Kolom ini mengambil seluruh lebar (12 dari 12)
                    wellPanel( # Menggunakan wellPanel agar terlihat terstruktur
                      h4("Analisis Perbandingan Negara Terpilih"),
                      uiOutput("dynamic_interpretation_menu2") # ID output yang sama seperti di server.R
                    )
             )
           )
           # --- AKHIR DARI FLUIDROW BARU ---
  )
}