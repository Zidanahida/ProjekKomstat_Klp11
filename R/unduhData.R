unduh_ui <- function(id) {
  ns <- NS(id)
  
  fluidRow(
    column(
      width = 4,
      div(
        style = "background-color: #f9fafb; padding: 20px; border-radius: 10px; height: 100%; box-shadow: 0 2px 4px rgba(0,0,0,0.1);",
        
        h4("Filter Data", style = "color: #374151; margin-bottom: 20px;"),
        
        # Year Range Filter
        div(
          style = "margin-bottom: 20px;",
          sliderInput(
            ("year_range"), 
            "Rentang Tahun:",
            min = min(dataClean$Year, na.rm = TRUE),
            max = max(dataClean$Year, na.rm = TRUE),
            value = c(min(dataClean$Year, na.rm = TRUE), max(dataClean$Year, na.rm = TRUE)),
            step = 1, 
            sep = "",
            width = "100%"
          )
        ),
        
        # Area/Country Filter
        div(
          style = "margin-bottom: 20px;",
          checkboxInput(
            ("select_all_area"), 
            "Pilih Semua Negara", 
            value = FALSE
          ),
          div(
            style = "max-height: 150px; overflow-y: auto; border: 1px solid #e5e7eb; border-radius: 5px; padding: 10px; background-color: white;",
            checkboxGroupInput(
              ("area"), 
              "Negara:", 
              choices = sort(unique(dataClean$Area)),
              selected = NULL
            )
          )
        ),
        
        # Category Filter
        div(
          style = "margin-bottom: 20px;",
          checkboxInput(
            ("select_all_kategori"), 
            "Pilih Semua Kategori", 
            value = FALSE
          ),
          div(
            style = "max-height: 150px; overflow-y: auto; border: 1px solid #e5e7eb; border-radius: 5px; padding: 10px; background-color: white;",
            checkboxGroupInput(
              ("kategori"), 
              "Kategori:", 
              choices = sort(unique(dataClean$Item)),
              selected = NULL
            )
          )
        ),
        
        # Download Button
        div(
          style = "text-align: center; margin-top: 20px;",
          downloadButton(
            ("unduh_data"), 
            "Unduh Data", 
            class = "btn-primary", 
            style = "width: 100%; padding: 10px; font-weight: bold; border-radius: 5px;"
          )
        ),
        
        # Reset Button
        div(
          style = "text-align: center; margin-top: 10px;",
          actionButton(
            ("reset_filters"), 
            "Reset Filter", 
            class = "btn-secondary", 
            style = "width: 100%; padding: 8px; border-radius: 5px;"
          )
        )
      )
    ),
    
    column(
      width = 8,
      div(
        style = "padding: 10px;",
        # Data Summary
        div(
          style = "background-color: #f3f4f6; padding: 15px; border-radius: 8px; margin-bottom: 15px;",
          h5("Ringkasan Data", style = "color: #374151; margin-bottom: 10px;"),
          fluidRow(
            column(4, 
                   div(
                     style = "text-align: center; padding: 10px; background-color: white; border-radius: 5px; margin-right: 5px;",
                     strong(textOutput(("total_rows"), inline = TRUE)),
                     br(),
                     tags$small("Total Baris")
                   )
            ),
            column(4, 
                   div(
                     style = "text-align: center; padding: 10px; background-color: white; border-radius: 5px; margin: 0 2.5px;",
                     strong(textOutput(("total_countries"), inline = TRUE)),
                     br(),
                     tags$small("Total Negara")
                   )
            ),
            column(4, 
                   div(
                     style = "text-align: center; padding: 10px; background-color: white; border-radius: 5px; margin-left: 5px;",
                     strong(textOutput(("total_categories"), inline = TRUE)),
                     br(),
                     tags$small("Total Kategori")
                   )
            )
          )
        ),
        
        # Data Table
        div(
          style = "background-color: white; padding: 15px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1);",
          h5("Preview Data", style = "color: #374151; margin-bottom: 15px;"),
          DT::dataTableOutput(("tabel_data"))
        )
      )
    )
  )
}