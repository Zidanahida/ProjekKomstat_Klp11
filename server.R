# Load necessary packages
# install.packages("sf")
# install.packages("leaflet")
# install.packages("RColorBrewer")
# install.packages("plotly")
# install.packages("readxl")
# install.packages("tidyr")
# install.packages("dplyr")
# install.packages("ggplot")
# install.packages("bslib")
# install.packages("shiny")
library(readxl)
library(dplyr)
library(tidyr)
library(leaflet)
library(bslib)
library(plotly)
library(sf)
source("global.R")

##================== SERVER =================##
##===========================================##
shinyServer(function(input, output, session) {
  # Reactive expression to calculate average emissions by country
  dataAverageByCountry <- reactive({
    if (input$divide_by_area) {
      # If "Divide by Area" is selected
      dataClean %>%
        filter(Year >= input$year_range[1] & Year <= input$year_range[2]) %>%
        group_by(Area) %>%
        summarise(avg_emissions = sum(Value, na.rm = TRUE) /(input$year_range[2]-input$year_range[1])/ mean(Area.y, na.rm = TRUE), .groups = "drop")
    } else {
      # If "Raw Data" is selected
      dataClean %>%
        filter(Year >= input$year_range[1] & Year <= input$year_range[2]) %>%
        group_by(Area) %>%
        summarise(avg_emissions = sum(Value, na.rm = TRUE)/(input$year_range[2]-input$year_range[1]), .groups = "drop")
    }
  })
  
  ###============ Legend Home ==============###
  output$customLegendUI <- renderUI({
    legend_items <- lapply(areas, function(area) {
      color <- area_colors()[[area]]  # Get the color for the area
      tags$li(
        class = "legend-box",
        style = "list-style-type: none; cursor: pointer;",
        onclick = paste0("Shiny.setInputValue('select_country', '", area, "')"),  # Set input value on click
        div(class = "color-box", style = paste0("background-color:", color, "; width: 20px; height: 20px; display: inline-block; margin-right: 10px;")),
        span(area, class = "legend-item")
      )
    })
    
    tagList(
      h3("Negara"),
      tags$ul(
        style = "padding-left: 0;",
        legend_items
      )
    )
  })
  
  
  ##====== Color Palette ======##
  palet_metana <- reactive({
    colorNumeric(
      palette = colorRampPalette(c("white", "pink", "red"))(100),
      domain = dataAverageByCountry()$avg_emissions,
      na.color = "gray"
    )
  })
  
  area_colors <- reactive({
    data_avg <- dataAverageByCountry()
    warna_values <- palet_metana()(data_avg$avg_emissions)
    setNames(warna_values, data_avg$Area)
  })
  
  output$legendUI <- renderUI({
    legend_items <- lapply(areas, function(area) {
      tags$li(
        class = "legend-box", 
        id = paste0("box-", area),
        onclick = paste0("Shiny.setInputValue('select_country', '", area, "')"),
        div(class = "color-box", style = paste0("background-color:", area_colors()[[area]], "; margin-right:10px;")),
        span(area, class = "legend-item")
      )
    })
    
    tagList(
      h3("Negara"),
      tags$ul(
        style = "list-style-type:none; padding-left:0;",
        legend_items
      )
    )
  })
  
  ##============== Plot =================##
  output$emissionPlot <- renderPlotly({
    data_avg <- dataAverageByCountry()
    
    if (nrow(data_avg) == 0 || all(is.na(data_avg$avg_emissions)) || all(data_avg$avg_emissions == 0)) {
      return(NULL)
    }
    
    warna_values <- palet_metana()(data_avg$avg_emissions)
    
    if (input$ispiechart) {
      plot_ly(
        data_avg,
        labels = ~Area,
        values = ~avg_emissions,
        type = "pie",
        textinfo = "label+percent",
        hoverinfo = "label+value+percent",
        marker = list(
          colors = warna_values,  # Use colors from the palette
          line = list(color = "#FFFFFF", width = 1)
        ),
        key = ~avg_emissions
      ) %>%
        layout(title = "Rata-rata Emisi per Negara")
    } else {
      plot_ly(
        data_avg,
        x = ~avg_emissions,
        y = ~reorder(Area, avg_emissions),  # Order by value
        type = "bar",
        orientation = "h",
        key = ~avg_emissions,
        marker = list(color = warna_values),
        text = ~paste0(
          formatC(avg_emissions, format = "e", digits = 4),
          if (input$divide_by_area) " Kt/Km2" else " Kt"
        ),
        hoverinfo = "text"
      ) %>%
        layout(
          title = "Rata-rata Emisi per Negara",
          xaxis = list(title = if (input$divide_by_area) "Emisi CH4 (Kt/Km2)" else "Emisi (Kt)"),
          yaxis = list(title = NULL),
          margin = list(l = 100)  # Add left margin to prevent label cutoff
        )
    }
  })
  
  ##================ MAP ===============##
  geo_data <- st_read("data/AsiaTenggara.json") 
  geo_data <- geo_data %>% filter(name %in% areas)
  
  output$methaneLeafletMap <- renderLeaflet({
    # Store average data for each country
    data_avg <- dataAverageByCountry()
    
    # Merge spatial data and average data
    geo_merged <- geo_data %>%
      right_join(data_avg, by = c("name" = "Area"))
    
    # Create colors from reactive palette
    warna_values <- palet_metana()(geo_merged$avg_emissions)
    
    # Render leaflet
    leaflet(geo_merged, options = leafletOptions(minZoom = 3, maxZoom = 7)) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        data = geo_merged,
        layerId = ~name,
        fillColor = warna_values,
        weight = 1,
        opacity = 1,
        color = "lightblue",
        dashArray = "3",
        fillOpacity = 0.7,
        label = ~paste0(
          name, ": ",
          formatC(avg_emissions, format = "e", digits = 4),
          if (input$divide_by_area) " Kt/Km2" else " Kt"
        ),
        highlightOptions = highlightOptions(
          weight = 2,
          color = "lightblue",
          dashArray = "H",
          fillOpacity = 0.8,
          bringToFront = TRUE
        )
      ) %>%
      setMaxBounds(
        lng1 = 90, lat1 = -12,
        lng2 = 142, lat2 = 30
      )
  })
  
  ###========= Highlight MAP From Toggle =========###
  observeEvent(input$selected_area, {
    # Prepare spatial data
    data_avg <- dataAverageByCountry()
    
    # Merge spatial data with average emissions data
    geo_merged <- geo_data %>%
      right_join(data_avg, by = c("name" = "Area"))
    
    warna_values <- palet_metana()(geo_merged$avg_emissions)
    
    selected_countries <- input$selected_area
    
    if (length(selected_countries) == 1) {
      # If no countries are selected, revert to showing all countries
      leafletProxy("methaneLeafletMap") %>%
        clearShapes() %>%
        addProviderTiles("CartoDB.Positron") %>%
        addPolygons(
          data = geo_merged,
          layerId = ~name,
          fillColor = warna_values,
          weight = 1,
          opacity = 1,
          color = "lightblue",
          dashArray = "3",
          fillOpacity = 0.7,
          label = ~paste0(name, ": ", round(avg_emissions, 2), " Kt/Km2"),
          highlightOptions = highlightOptions(
            weight = 2,
            color = "lightblue",
            dashArray = "H",
            fillOpacity = 0.8,
            bringToFront = TRUE
          )
        ) %>%
        setMaxBounds(
          lng1 = 90, lat1 = -12,
          lng2 = 142, lat2 = 30
        )
    } else {
      # Update the Leaflet map based on selected countries
      leafletProxy("methaneLeafletMap") %>%
        clearShapes() %>%
        addPolygons(
          data = geo_merged %>% filter(name %in% selected_countries),  # Filter based on selected countries
          layerId = ~name,
          weight = 2,
          opacity = 1,
          color = "orange",  # Highlight color for selected countries
          dashArray = "3",
          fillOpacity = 0.7,
          label = ~paste0(name, ": ", round(avg_emissions, 2), " Kt/Km2"),
          highlightOptions = highlightOptions(
            weight = 2,
            color = "orange",
            dashArray = "H",
            fillOpacity = 0.8,
            bringToFront = TRUE
          )
        )
    }
  })
  
  ####========= Emisi Gas Metana Berdasarkan Kategori Sumber(menu 1) =========#####
  observeEvent(input$select_all, {
    if (input$select_all) {
      updateCheckboxGroupInput(session, "kategori", selected = unique(dataClean$Item))
    } else {
      updateCheckboxGroupInput(session, "kategori", selected = character(0))
    }
  })

  filteredDatas <- reactive({ # Data reaktif untuk barChart Menu 1
    req(input$negara_pilih, input$kategori) # <<< KOREKSI DI SINI: pakai input$negara_pilih

    dataClean %>%
      filter(Area == input$negara_pilih, Item %in% input$kategori, Year>=2019 & Year <=2022) %>% # <<< KOREKSI DI SINI: pakai input$negara_pilih
      group_by(Item) %>%
      summarise(avg_emission = sum(Value, na.rm = TRUE)/(2022-2019), .groups = 'drop')
  })

  output$barChart <- renderPlotly({
    df <- filteredDatas()

    if (nrow(df) == 0) {
      return(plotly_empty() %>% layout(title = "Tidak ada data yang tersedia"))
    }

    p <- ggplot(df, aes(x = reorder(Item, avg_emission), y = avg_emission, fill = Item,
                        text = paste("Kategori:", Item,
                                     "<br>Rata-rata Emisi:", round(avg_emission, 2), "Kt"))) +
      geom_col(width = 0.7) +
      labs(
        x = NULL,
        y = "Rata-rata Emisi (Kt)"
      ) +
      scale_fill_brewer(palette = "Pastel1") +
      theme_minimal(base_size = 14) +
      theme(
        legend.position = "none",
        axis.text.x = element_text(angle = 45, hjust = 1)
      )

    ggplotly(p, tooltip = "text") %>%
      layout(
        xaxis = list(
          tickfont = list(size = 10),
          title = list(text = "")
        ),
        yaxis = list(
          title = list(text = "Rata-rata Emisi (Kt)")
        ),
        hoverlabel = list(
          bgcolor = "white",
          font = list(size = 12)
        ),
        margin = list(b = 100, l = 50, r = 50, t = 50)
      ) %>%
      config(displayModeBar = TRUE,
             modeBarButtonsToRemove = c("pan2d", "select2d", "lasso2d", "autoScale2d"))
  })

  # --- Tambahkan bagian ini untuk logika interpretasi dinamis Menu 1 ---
  output$dynamic_interpretation_menu1 <- renderUI({ # ID output untuk Menu 1
    # Ambil data yang sudah difilter untuk barChart
    df_for_interpretation <- filteredDatas()

    # Pastikan ada lebih dari satu kategori yang dipilih untuk perbandingan
    if (nrow(df_for_interpretation) > 1) {
      # Temukan kategori dengan emisi rata-rata tertinggi
      kategori_tertinggi <- df_for_interpretation %>%
        arrange(desc(avg_emission)) %>%
        slice(1)

      # Temukan kategori dengan emisi rata-rata terendah
      kategori_terendah <- df_for_interpretation %>%
        arrange(avg_emission) %>%
        slice(1)

      # Buat teks interpretasi dalam format HTML
      HTML(paste0(
        "<p><strong>Analisis Kategori Sumber Emisi:</strong></p>",
        "<ul>",
        "<li>Untuk negara <strong>", input$negara_pilih, "</strong>, kategori <strong>", kategori_tertinggi$Item, "</strong> menunjukkan rata-rata emisi tertinggi (sekitar ", format(round(kategori_tertinggi$avg_emission, 2), nsmall = 2), " Kt) di antara kategori yang dipilih.</li>",
        "<li>Sementara itu, kategori <strong>", kategori_terendah$Item, "</strong> menunjukkan rata-rata emisi terendah (sekitar ", format(round(kategori_terendah$avg_emission, 2), nsmall = 2), " Kt) di antara kategori yang dipilih.</li>",
        "</ul>",
        "<p><i>Analisis ini didasarkan pada rata-rata emisi dari tahun 2019-2022 untuk negara dan kategori yang Anda pilih.</i></p>"
      ))
    } else if (nrow(df_for_interpretation) == 1) {
      # Pesan jika hanya satu kategori yang dipilih
      HTML("<p>Pilih **lebih dari satu** kategori untuk melihat perbandingan emisi sumber tertinggi dan terendah.</p>")
    } else {
      # Pesan jika tidak ada data atau kategori yang dipilih
      HTML("<p>Pilih negara dan setidaknya satu kategori dari daftar di samping untuk menampilkan grafik dan analisis.</p>")
    }
  })
  # --- Akhir logika interpretasi dinamis Menu 1 ---
  
  ####========= Time Series Metana Berdasarkan Kategori Sumber dan Negara(menu 2) =========#####
  datasetInput <- reactive({
    req(input$negara)
    
    AdjTimeSeries %>%
      filter(Area %in% input$negara) %>%
      dplyr::select(Year, Area, avg_emissions_adj) %>%
      rename(Value = avg_emissions_adj)
  })
  
  dataMovingAvg <- reactive({
    df <- datasetInput()
    if (input$movingAvg == "none") {
      df
    } else {
      n <- as.numeric(input$movingAvg)
      df %>%
        group_by(Area) %>%
        arrange(Year) %>%
        mutate(Value = zoo::rollmean(Value, k = n, fill = NA, align = "right")) %>%
        ungroup()
    }
  })
  
  output$plotEmisi <- renderPlot({
    df <- dataMovingAvg()
    validate(
      need(nrow(df) > 0, "Pilih setidaknya satu negara.")
    )
    
    ggplot(df, aes(x = Year, y = Value, color = Area)) +
      geom_line(size = 1.2) +
      scale_x_continuous(breaks = seq(min(df$Year), max(df$Year), by = 1)) +
      labs(x = NULL, y = NULL) +
      theme_minimal() +
      theme(
        legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(hjust = 0.5),
        axis.text.x = element_text(angle = 45, hjust = 1)
      ) +
      expand_limits(y = 0) +
      scale_y_continuous(labels = scales::comma)
  })
  
  # --- Tambahkan bagian ini untuk logika interpretasi dinamis menu 2 ---
  output$dynamic_interpretation_menu2 <- renderUI({
    # Pastikan ada lebih dari satu negara yang dipilih untuk perbandingan
    if (length(input$negara) > 1) {
      # Gunakan AdjTimeSeries untuk perhitungan, sesuai dengan sumber data grafik plotEmisi
      # Kolom yang relevan adalah 'Area' dan 'avg_emissions_adj'
      data_for_comparison <- AdjTimeSeries %>%
        filter(Area %in% input$negara) %>%
        group_by(Area) %>%
        summarise(
          rata_rata_emisi = mean(avg_emissions_adj, na.rm = TRUE) # Rata-rata dari kolom avg_emissions_adj
        ) %>%
        ungroup()
      
      # Temukan negara dengan rata-rata emisi tertinggi
      negara_tertinggi <- data_for_comparison %>%
        arrange(desc(rata_rata_emisi)) %>%
        slice(1)
      
      # Temukan negara dengan rata-rata emisi terendah
      negara_terendah <- data_for_comparison %>%
        arrange(rata_rata_emisi) %>%
        slice(1)
      
      # Buat teks interpretasi dalam format HTML
      HTML(paste0(
        "<p><strong>Analisis Perbandingan Emisi (Rata-rata Historis):</strong></p>",
        "<ul>",
        "<li>Dari negara-negara yang Anda pilih, <strong>", negara_tertinggi$Area, "</strong> menunjukkan rata-rata emisi metana tertinggi (sekitar ", format(round(negara_tertinggi$rata_rata_emisi, 3), nsmall = 3), " Kt sepanjang periode datanya.</li>",
        "<li>Sementara itu, <strong>", negara_terendah$Area, "</strong> menunjukkan rata-rata emisi metana terendah (sekitar ", format(round(negara_terendah$rata_rata_emisi, 3), nsmall = 3), " Kt 1000 Ton) sepanjang periode datanya.</li>",
        "</ul>",
        "<p><i>Catatan: Rata-rata ini dihitung dari nilai emisi asli setiap negara. Hal ini terlepas dari opsi 'Moving Average' yang dipilih pada grafik. Moving Average yang dipilih tidak akan mengubah interpretasi yang ada karena moving average hanya mengubah visual dari time seriesnya, bukan untuk mengubah nilai rata-rata yang dihasilkan</i></p>"
      ))
    } else if (length(input$negara) == 1) {
      # Pesan jika hanya satu negara yang dipilih
      HTML("<p>Pilih **lebih dari satu** negara untuk melihat perbandingan emisi tertinggi dan terendah.</p>")
    } else {
      # Pesan jika tidak ada negara yang dipilih
      HTML("<p>Pilih setidaknya satu negara dari daftar di samping untuk menampilkan grafik dan analisis.</p>")
    }
  })
  # --- Akhir logika interpretasi dinamis menu 2 ---
  
  ####========= UNDUH DATA =========#####
  
  # Observer untuk select all area
  observeEvent(input$select_all_area, {
    updateCheckboxGroupInput(session, "area",
                             selected = if (input$select_all_area) unique(dataClean$Area) else character(0)
    )
  })
  
  # Observer untuk select all kategori
  observeEvent(input$select_all_kategori, {
    updateCheckboxGroupInput(session, "kategori",
                             selected = if (input$select_all_kategori) unique(dataClean$Item) else character(0)
    )
  })
  
  # Observer untuk reset filters
  observeEvent(input$reset_filters, {
    updateSliderInput(session, "year_range", 
                      value = c(min(dataClean$Year, na.rm = TRUE), max(dataClean$Year, na.rm = TRUE))
    )
    updateCheckboxInput(session, "select_all_area", value = FALSE)
    updateCheckboxGroupInput(session, "area", selected = character(0))
    updateCheckboxInput(session, "select_all_kategori", value = FALSE)
    updateCheckboxGroupInput(session, "kategori", selected = character(0))
  })
  
  # Reactive data
  filteredData <- reactive({
    # Cek apakah ada pilihan area dan kategori
    selected_areas <- input$area
    selected_categories <- input$kategori
    year_range <- input$year_range
    
    # Jika tidak ada pilihan, return empty dataframe atau semua data
    if (is.null(selected_areas) || length(selected_areas) == 0) {
      return(dataClean[0, ])  # Return empty dataframe dengan struktur yang sama
    }
    
    if (is.null(selected_categories) || length(selected_categories) == 0) {
      return(dataClean[0, ])  # Return empty dataframe dengan struktur yang sama
    }
    
    if (is.null(year_range) || length(year_range) != 2) {
      return(dataClean[0, ])
    }
    
    # Filter data
    filtered <- dataClean %>%
      filter(
        Area %in% selected_areas,
        Item %in% selected_categories,
        Year >= year_range[1],
        Year <= year_range[2]
      )
    
    return(filtered)
  })
  
  # Render tabel
  output$tabel_data <- DT::renderDataTable({
    data <- filteredData()
    
    if (nrow(data) == 0) {
      # Jika tidak ada data, tampilkan pesan
      DT::datatable(
        data.frame(Message = "Tidak ada data yang sesuai dengan filter yang dipilih"),
        options = list(
          pageLength = 10,
          searching = FALSE,
          paging = FALSE,
          info = FALSE
        ),
        rownames = FALSE
      )
    } else {
      # Tampilkan data terpilih
      DT::datatable(
        data, 
        options = list(
          pageLength = 10,
          scrollX = TRUE,
          autoWidth = TRUE,
          columnDefs = list(
            list(className = 'dt-center', targets = '_all')
          )
        ),
        rownames = FALSE
      )
    }
  })
  
  # Output untuk summary statistics (jika menggunakan UI yang sudah diperbaiki)
  output$total_rows <- renderText({
    nrow(filteredData())
  })
  
  output$total_countries <- renderText({
    length(unique(filteredData()$Area))
  })
  
  output$total_categories <- renderText({
    length(unique(filteredData()$Item))
  })
  
  # Download handler dengan penanganan error
  output$unduh_data <- downloadHandler(
    filename = function() {
      paste0("data_filtered_", Sys.Date(), ".xlsx")
    },
    content = function(file) {
      data <- filteredData()
      
      if (nrow(data) > 0) {
        write_xlsx(data, path = file)
      } else {
        # Buat data kosong dengan hanya kolom dari dataClean
        empty_data <- dataClean[0, ]
        write_xlsx(empty_data, path = file)
      }
    }
  )
  
  # Optional: Debug output untuk melihat status filter
  output$debug_info <- renderText({
    paste(
      "Areas selected:", length(input$area %||% character(0)),
      "| Categories selected:", length(input$kategori %||% character(0)),
      "| Year range:", paste(input$year_range %||% c(0,0), collapse = "-"),
      "| Filtered rows:", nrow(filteredData())
    )
  })
})