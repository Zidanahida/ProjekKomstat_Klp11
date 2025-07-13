menu1_ui <- function(id) {
  ns <- NS(id)
  tabPanel("Emisi Gas Metana Berdasarkan Kategori Sumber",
           sidebarLayout(sidebarPanel(selectInput("negara_pilih", "Negara:", choices = unique(dataClean$Area), selected = "Indonesia"),
                                      checkboxGroupInput("kategori", "Kategori:", choices = unique(dataClean$Item),
                                                         selected = unique(dataClean$Item)[c(2,3,5)]),
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
                    ),
           )
           )
           )
           
  )
}


menu2_ui <- function(id){
    ns <- NS(id)
    tabPanel("Time Series Metana Berdasarkan Kategori Sumber dan Negara",
                                               fluidRow(
                                                        column(width = 3,wellPanel(
                                                                                    h4("Negara"),
                                                                                    checkboxGroupInput("negara", "Pilih Negara",
                                                                                                       choices = sort(unique(areas)),
                                                                                                       selected = c("Thailand", "Malaysia", "Indonesia", "Singapore"),
                                                                                                       inline = FALSE),
                                                                                    
                                                                                    h4("Moving Average"),
                                                                                    selectInput("movingAvg", "Moving Average",
                                                                                                  choices = c("None" = "none", "3 Tahun" = "3", "5 Tahun" = "5"),
                                                                                                  selected = "none")
                                                                                  )
                                                              ),
                                                      column(width = 6,
                                                              h3("Emisi Gas Metana Berdasarkan Sumber", align = "center"),
                                                              plotOutput("plotEmisi", height = "500px", width = "100%")
                                                            ),
                                                      column(width = 3,
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
                                                      )
                                              )
}