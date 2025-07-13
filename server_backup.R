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
# install.packages("vembedr")

library(readxl)
library(dplyr)
library(tidyr)
library(leaflet)
library(bslib)
library(plotly)
library(sf)
library(vembedr)


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
        summarise(avg_emissions = mean(Value, na.rm = TRUE) / mean(Area.y, na.rm = TRUE), .groups = "drop")
    } else {
      # If "Raw Data" is selected
      dataClean %>%
        filter(Year >= input$year_range[1] & Year <= input$year_range[2]) %>%
        group_by(Area) %>%
        summarise(avg_emissions = mean(Value, na.rm = TRUE), .groups = "drop")
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
  
  ##============== Plot HOME =================##
  output$emissionPlot <- renderPlotly({
    data_avg <- dataAverageByCountry()
    
    if (nrow(data_avg) == 0 || all(is.na(data_avg$avg_emissions)) || all(data_avg$avg_emissions == 0)) {
      return(NULL)
    } # validation is data row available
    
    warna_values <- palet_metana()(data_avg$avg_emissions)# set colour
    
    if (input$ispiechart) { # render Pie chart 
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
    } 
    
    else { # render bar chart
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
          label = ~paste0(name, ": ",formatC(avg_emissions, format = "e", digits = 4), " Kt/Km2"),
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
          color = "blue",  # Highlight color for selected countries
          dashArray = "3",
          fillOpacity = 0.5,
          label = ~paste0(name, ": ", formatC(avg_emissions, format = "e", digits = 4), " Kt/Km2"),
          highlightOptions = highlightOptions(
            weight = 2,
            color = "blue",
            dashArray = "H",
            fillOpacity = 0.6,
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
      updateCheckboxGroupInput(session, "kategori", selected = character(0))  # Reset jika tidak dipilih
    }
  })
  
  filteredData <- reactive({
    dataClean %>%
      filter(Area == input$negara_pilih, Item %in% input$kategori, Year>=2019, Year<=2022) %>%
      group_by(Item) %>%
      summarise(avg_emission = mean(Value, na.rm = TRUE))
  })
  
  output$barChart <- renderPlot({
    ggplot(filteredData(), aes(x = reorder(Item, avg_emission), y = avg_emission, fill = Item)) +
      geom_col(width = 0.7) +
      labs(
        x = NULL,
        y = "Rata-rata Emisi (Kt)"
      ) +
      scale_fill_brewer(palette = "Pastel1") +
      theme_minimal(base_size = 14) +
      theme(legend.position = "none")
  })
  
  
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
})