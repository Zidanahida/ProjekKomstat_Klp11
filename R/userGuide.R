userGuide_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    tags$head(
      tags$style(HTML("
        .guide-title {
          font-size: 28px;
          font-weight: bold;
          margin-bottom: 30px;
        }
        .guide-section {
          width: 100%;
          max-width: 900px;
          margin: auto;
        }
        .guide-btn {
          width: 100%;
          text-align: left;
          font-weight: bold;
          font-size: 18px;
          color: #333;
          background-color: transparent;
          border: none;
          padding: 12px 16px;
          margin-bottom: 8px;
          transition: background-color 0.3s ease, color 0.3s ease;
        }
        .guide-btn:hover {
          background-color: #f0f0f0;
          color: #007bff;
          border-radius: 5px;
        }
        .guide-step {
          padding: 15px;
          margin-bottom: 15px;
          background-color: #f9f9f9;
          border-left: 4px solid #007bff;
          border-radius: 5px;
        }
        .faq-box {
          padding: 15px;
          background-color: #f5f5f5;
          border-radius: 5px;
          margin-bottom: 10px;
          color: #000;
        }
        .guide-footer {
          text-align: center;
          margin-top: 40px;
          font-style: italic;
          color: #666;
        }
      "))
    ),
    includeCSS("www/css/style.css"),
    
    div(class = "guide-title", "Panduan Pengguna"),
    
    div(class = "guide-video d-flex justify-content-center mb-4",
        div(style = "max-width: 1000px; width: 100%;",
            embed_youtube("bdaCJtFDUak", height = 450)
        )
    ),
    
    div(class = "guide-section d-flex flex-column align-items-stretch",
        tags$button(class = "btn btn-link text-decoration-none guide-btn", 
                    `data-bs-toggle` = "collapse", 
                    `data-bs-target` = "#collapse1", 
                    "1. Beranda"),
        div(id = "collapse1", class = "collapse",
            div(class = "guide-step",
                tags$p("Beranda merupakan tampilan awal dashboard yang menyediakan visualisasi statistik dalam bentuk peta, barchart dan piechart untuk membandingkan kontribusi penyumbang gas Metana di Asia Tenggara. Terdapat fitur-fitur yang dapat disesuaikan oleh pengguna."),
                tags$ul(
                  tags$li("Masuk ke Dashboard: Saat aplikasi pertama kali dibuka, pengguna akan langsung diarahkan ke halaman Leaderboard secara otomatis."),
                  tags$li("Eksplorasi Peta Asia Tenggara."),
                  tags$li("Menyentuh Map untuk Melihat Detail."),
                  tags$li("Seleksi Negara melalui Sidebar."),
                  tags$li("Lihat Visualisasi Tambahan di Bagian Bawah."),
                  tags$li("Beralih antara Bar Chart dan Pie Chart."),
                  tags$li("Data Luas Wilayah dari World Bank untuk perbandingan."),
                  tags$li("Thumbnail informasi terkait pemanasan global dan gas metana.")
                )
            )
        ),
        
        tags$button(class = "btn btn-link text-decoration-none guide-btn", 
                    `data-bs-toggle` = "collapse", 
                    `data-bs-target` = "#collapse2", 
                    "2. Menu"),
        div(id = "collapse2", class = "collapse",
            div(class = "guide-step",
                tags$p("Menu menyediakan 2 opsi visualisasi data lebih lanjut berdasarkan beberapa kategori."),
                tags$ul(
                  tags$li(
                    tags$b("Emisi Gas Metana Berdasarkan Kategori Sumber: "),
                    "Visualisasi kategori FAO rata-rata tahun 2017–2022."
                  ),
                  tags$li(
                    tags$b("Time Series Berdasarkan Negara dan Sumber: "),
                    "Tren emisi metana berdasarkan sumber dan negara."
                  )
                )
            )
        ),
        
        tags$button(class = "btn btn-link text-decoration-none guide-btn", 
                    `data-bs-toggle` = "collapse", 
                    `data-bs-target` = "#collapse3", 
                    "3. Sumber"),
        div(id = "collapse3", class = "collapse",
            div(class = "guide-step",
                tags$p("Tab ini bertujuan untuk memberi transparansi dan akuntabilitas."),
                tags$ul(
                  tags$li("Sumber: FAOSTAT, World Bank, dan GeoJSON ASEAN Maps."),
                  tags$li("Masing-masing panel memiliki tautan ke halaman resmi sumber."),
                  tags$li("Menggunakan berbagai paket R seperti ggplot2, shiny, leaflet, dsb.")
                )
            )
        ),
        
        tags$button(class = "btn btn-link text-decoration-none guide-btn", 
                    `data-bs-toggle` = "collapse", 
                    `data-bs-target` = "#collapse4", 
                    "4. Unduh Data"),
        div(id = "collapse4", class = "collapse",
            div(class = "guide-step",
                tags$p("Menu ini memungkinkan pengguna untuk mengunduh data mentah yang telah difilter sesuai kebutuhan."),
                tags$ul(
                  tags$li("Pilih Negara dan Tahun yang diinginkan."),
                  tags$li("Pilih Kategori Emisi."),
                  tags$li("Klik tombol Unduh Data untuk mengunduh file.")
                )
            )
        ),
        
        tags$button(class = "btn btn-link text-decoration-none guide-btn", 
                    `data-bs-toggle` = "collapse", 
                    `data-bs-target` = "#collapse5", 
                    "5. Tentang Kami"),
        div(id = "collapse5", class = "collapse",
            div(class = "guide-step",
                tags$p("Halaman ini memperkenalkan siapa di balik platform ini dan menjawab pertanyaan umum dari pengguna."),
                tags$ul(
                  tags$li("Penjelasan bahwa CH4.SEasia adalah platform visualisasi emisi metana."),
                  tags$li("Data dari FAO dan sumber terbuka lainnya."),
                  tags$li("Pendekatan sains data digunakan untuk menyajikan informasi."),
                  tags$li("Struktur proyek, nama file, dan susunan folder tersedia di halaman ini.")
                )
            )
        )
    ),
    
    br(),
    div(class = "guide-title", "Pertanyaan Umum"),
    
    div(class = "guide-section",
        div(class = "faq-box",
            tags$strong("Apakah data bisa diunduh?"),
            tags$p("Ya, pengguna dapat mengunduh data yang telah difilter melalui menu Unduh Data.")
        ),
        div(class = "faq-box",
            tags$strong("Apakah hanya metana yang dianalisis?"),
            tags$p("Ya, fokus utama platform ini adalah emisi gas metana (CH4) karena dampaknya yang signifikan pada pemanasan global.")
        ),
        div(class = "faq-box",
            tags$strong("Dari mana data berasal?"),
            tags$p("Data berasal dari FAO (Food and Agriculture Organization), World Bank, dan peta GeoJSON ASEAN yang terbuka.")
        ),
        div(class = "faq-box",
            tags$strong("Bagaimana cara menjalankan aplikasi ini secara lokal?"),
            tags$p("Unduh ZIP dari repositori, ekstrak, install package yang diperlukan, lalu jalankan `shiny::runApp()`. Informasi lebih lanjut dapat diakses di: "),
            tags$span("GitHub Repositories :",tags$a(href = "https://github.com/Zidanahida/ProjekKomstat_Klp11", target = "_blank", "Click Here"))
            
        )
    )
  )
}
