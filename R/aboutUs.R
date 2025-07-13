# aboutUs.R

addResourcePath("ImgPath", "www/img")

tentangKami_ui <- function(id) {
  ns <- NS(id)
  fluidPage(
    # Link to the external CSS file
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
    ),
    
    div(class = "about-title", "Tentang Kami"),
    div(class = "about-container",
        div(id = "about-text-box-left",
            class = "about-left",
            div(class = "about-section",
                tags$h3("Siapa Kami?"),
                tags$p("Kami bertiga adalah seorang mahasiswa STIS jurusan Komputasi Statistik yang sedang menyelesaikan tugas akhir untuk mata kuliah Komputasi Statistik.
                       Tugas kami adalah membuat dashboard tentang climate change yang sedang hangat dibicarakan.")
            )
        ),
        div(id = "about-img-box", class = "about-center",
            # Using a placeholder image URL
            img(src = "ImgPath/Team.jpg", id = "about-img")
        ),
        div(id = "about-text-box-right",
            class = "about-right",
            div(class = "about-section",
                tags$h3("Apa Tujuan Kami?"),
                tags$p("Tujuan kami adalah untuk meningkatkan kesadaran tentang emisi metana di Asia Tenggara, menyediakan data yang transparan, dan mendukung upaya mitigasi perubahan iklim melalui informasi yang akurat dan mudah diakses.")
            )
        )
    ),

    div(class = "about-team", "Tim Kami"),
    fluidRow(
      column(4,
             div(class = "team-card",
                 div(class = "tooltip-overlay",
                     # Using a placeholder image URL
                     img(src = "ImgPath/Ari.jpg", class = "team-img"),
                     div(class = "overlay-text", "Ari fokus pada analisis data dan visualisasi.")
                 ),
                 div(class = "team-name", "Ari")
             )
      ),
      column(4,
             div(class = "team-card",
                 div(class = "tooltip-overlay",
                     # Using a placeholder image URL
                     img(src = "ImgPath/Zidan.jpg", class = "team-img"),
                     div(class = "overlay-text", "Zidan fokus pada pemodelan data.")
                 ),
                 div(class = "team-name", "Zidan")
             )
      ),
      column(4,
             div(class = "team-card",
                 div(class = "tooltip-overlay",
                     # Using a placeholder image URL
                     img(src = "ImgPath/Amel.jpg", class = "team-img"),
                     div(class = "overlay-text", "Amel fokus pada pengembangan antarmuka pengguna.")
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