addResourcePath("ImgPath", "www/img")

tentangKami_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    
    div(class = "about-title", "Tentang Kami"),
    div(class = "about-container",
        div(id = "about-text-box-left",
            class = "about-left",
            div(class = "about-section",
                tags$h3("Siapa Kami?"),
                tags$p("Kami adalah tiga mahasiswa dari Program Studi Komputasi Statistik, Politeknik Statistika STIS, yang saat ini sedang mengerjakan tugas akhir untuk mata kuliah Komputasi Statistik. 
                        Proyek ini merupakan bagian dari upaya kami dalam memberikan informasi akan ancaman gas metana yang jarang menjadi sorotan bagi khalayak publik")
            )
        ),
        div(id = "about-img-box", class = "about-center",
            img(src = "ImgPath/Team.jpg", id = "about-img")
        ),
        div(id = "about-text-box-right",
            class = "about-right",
            div(class = "about-section",
                tags$h3("Apa Tujuan Kami?"),
                tags$p("Dashboard ini dikembangkan untuk mengidentifikasi sektor-sektor utama yang berkontribusi terhadap emisi metana di Asia Tenggara. Melalui analisis ini, diharapkan dapat dihasilkan dasar 
                       ilmiah yang mendukung pengambilan kebijakan mitigasi yang lebih efektif dan terfokus pada sektor-sektor prioritas. Sekaligus memberikan informasi yang interaktif dan mudah diterima oleh 
                       masyarakat umum")
            )
        )
    ),
    
    div(class = "about-team", "Tim Kami"),
    fluidRow(
      column(4,
             div(class = "team-card",
                 div(class = "tooltip-overlay",
                     img(src = "ImgPath/Ari.jpg", class = "team-img"),
                     div(class = "overlay-text", "Ari bertanggung jawab dalam analisis data dan visualisasi.")
                 ),
                 div(class = "team-name", "Ari")
             )
      ),
      column(4,
             div(class = "team-card",
                 div(class = "tooltip-overlay",
                     img(src = "ImgPath/Zidan.jpg", class = "team-img"),
                     div(class = "overlay-text", "Zidan berfokus pada pengolahan dan pemodelan data.")
                 ),
                 div(class = "team-name", "Zidan")
             )
      ),
      column(4,
             div(class = "team-card",
                 div(class = "tooltip-overlay",
                     img(src = "ImgPath/Amel.jpg", class = "team-img"),
                     div(class = "overlay-text", "Amel menangani pengembangan antarmuka pengguna (UI) aplikasi.")
                 ),
                 div(class = "team-name", "Amel")
             )
      )
    ),
    br(),
    h4("Make Moves. Go Big. Get What’s Heating Up.", align = "center", style = "color: #999999; font-style: italic;"),
    
    tags$script(HTML("
      $(document).ready(function() {
        function matchHeight() {
          var leftTextHeight = $('#about-text-box-left').outerHeight();
          var rightTextHeight = $('#about-text-box-right').outerHeight();
          var maxHeight = Math.max(leftTextHeight, rightTextHeight);
          
          if ($('#about-img').length) {
            $('#about-img').css('height', maxHeight + 'px');
          }

          $('#about-text-box-left .about-section').css('height', maxHeight + 'px');
          $('#about-text-box-right .about-section').css('height', maxHeight + 'px');
        }

        matchHeight();

        $(window).on('resize', function() {
          matchHeight();
        });

        $('#about-img').on('load', function() {
            matchHeight();
        });
      });
    "))
  )
}
