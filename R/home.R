
home_ui <- function(id) {
  ns <- NS(id)
  page_sidebar(title = "LEADER BOARD EMISI GAS METANA ASIA TENGGARA",
                                                 fluidRow(
                                                   column(8, card(style = "height:80vh", leafletOutput("methaneLeafletMap", height = "100%"), full_screen = TRUE)),
                                                   column(
                                                     width = 4, 
                                                     card(
                                                       style = "height:80vh;width: 100%; padding: 15px; border-radius: 15px; box-sizing : border-box",
                                                       
                                                       # Judul Deskripsi
                                                       tags$div(
                                                         style = "font-weight: bold; font-size: 18px; margin-bottom: 5px;",
                                                         "Deskripsi"
                                                       ),
                                                       
                                                       # Paragraf deskripsi lengkap
                                                       tags$p("Visualisasi merupakan hasil rata-rata pelepasan gas emisi metana dari berbagai sektor di Asia Tenggara, sepanjang tahun 2000–2022, yang dikelompokkan berdasarkan negara."),
                                                       
                                                       tags$hr(style="margin:0"),
                                                       
                                                       tags$div(
                                                         style = "font-weight: bold; font-size: 18px; margin-bottom: 5px;",
                                                         "Fitur"
                                                       ),
                                                       tags$p("Sesuaikan Slidebar 'Year Range' untuk mengatur rentang tahun yang akan dirata-ratakan. "),
                                                       tags$p("Klik tombol 'Divide by Area' untuk melihat perbandingan emisi metana relatif terhadap luas wilayah (Kt/km²) antar negara."),
                                                       
                                                       tags$hr(style="margin:0"),
                                                       
                                                       # Satuan
                                                       tags$div(
                                                         style = "font-weight: bold; font-size: 16px; margin-bottom: 3px;",
                                                         "Satuan"
                                                       ),
                                                       tags$p("Kilo Ton (Kt)"),
                                                       
                                                       tags$hr(style="margin:0"),
                                                       
                                                       # Tanggal update
                                                       tags$p(
                                                         tags$span(style = "font-weight: bold;", "Terakhir Diupdate"), br(),
                                                         tags$span(style = "color: grey;", "05 Mei 2025")
                                                       ),
                                                       
                                                       # Sumber data
                                                       tags$p(
                                                         tags$span(style = "font-weight: bold;", "Sumber Data"), br(),
                                                         tags$a(
                                                           href = "https://www.fao.org/faostat/en/#data/GT", 
                                                           "https://www.fao.org/faostat/en/#data/GT", 
                                                           target = "_blank"
                                                         )
                                                       ),
                                                       
                                                       tags$hr(style="margin:5px 0"),
                                                       
                                                       # Interpretasi data
                                                       tags$div(
                                                         style = "font-weight: bold; font-size: 16px; margin-bottom: 3px;",
                                                         "Interpretasi"
                                                       ),
                                                       tags$p("Dari peta visualisasi, terlihat bahwa Indonesia merupakan negara dengan warna merah paling pekat, menandakan tingginya pelepasan gas metana di kawasan Asia Tenggara, yaitu sebesar 1507,5 Kt/tahun. Sektor-sektor yang menjadi penyumbang emisi dapat ditinjau lebih lanjut pada menu 'Emisi gas metana berdasarkan kategori sumber'."),
                                                       tags$p("Di posisi kedua adalah Thailand dengan total emisi sebesar 580 Kt/tahun, yang bahkan tidak mencapai sepertiga dari emisi Indonesia. Posisi ketiga ditempati oleh Myanmar sebesar 547,5 Kt/tahun, atau setara 94% dari emisi Thailand."),
                                                       tags$p("Kondisi ini menunjukkan bahwa Indonesia menjadi kontributor terbesar dalam pelepasan gas metana di kawasan Asia Tenggara, dan berperan signifikan terhadap pemanasan global. Pemerintah Indonesia perlu menindaklanjuti hal ini dengan mengontrol faktor-faktor penyebab tingginya emisi untuk mengurangi dampaknya terhadap lingkungan.")
                                                     )
                                                   ),
                                                   column(12,card(plotlyOutput("emissionPlot"),radioButtons("ispiechart", "Choose Chart Type:",
                                                                                                            choices = c("Pie Chart" = TRUE, 
                                                                                                                        "Bar Chart" = FALSE),
                                                                                                         selected = FALSE),
                                                                  style="height:500px")
                                                   )
                                                   ),
                sidebar = tagList(
                             sliderInput("year_range", "Year Range:",
                                             min = min(dataClean$Year, na.rm = TRUE),
                                             max = max(dataClean$Year, na.rm = TRUE),
                                             value = c(min(dataClean$Year, na.rm = TRUE), 
                                                       max(dataClean$Year, na.rm = TRUE)),
                                             step = 1,
                                            sep = ""
                                         ),
                             radioButtons("divide_by_area", "Data Division:",
                                                                     choices = c("Divide by Area" = TRUE, 
                                                                                 "Raw Data" = FALSE),
                                                                     selected = TRUE),
                             uiOutput("legendUI")),
               includeScript("www/js/script.js"),
               
               tabPanel(id,
                        div(
                          style = "
                                    background-color: white;
                                    border-radius: 15px;
                                    padding: 25px;
                                    color: #1f2937;
                                    box-shadow: 0 2px 10px rgba(0,0,0,0.1);
                                    margin-bottom: 20px;
                                    font-family: 'Segoe UI', sans-serif;
                                  ",
                          h3("Informasi mengenai Pemanasan Global dan Methana (CH4)",
                             style = "font-weight:600; margin-bottom: 20px;"),
                          
                          # Carousel wrapper
                          tags$div(
                            style = "
                                      display: flex;
                                      overflow-x: auto;
                                      gap: 20px;
                                      padding-bottom: 10px;
                                      scrollbar-width: thin;
                                    ",
                            
                            # lapply card list
                            lapply(
                              list(
                                list(
                                  style="overflow-y:scroll",
                                  img = "https://kalbar.link/assets/img/brand/favicon.png",
                                  title = "Pemanasan Global & Kesehatan",
                                  desc = "Pemanasan global menjadi isu yang semakin mendesak untuk ditangani karena dampaknya terasa di berbagai belahan dunia. Perubahan iklim yang drastis akibat pemanasan global telah menyebabkan berbagai konsekuensi serius di berbagai sektor kehidupan, termasuk lingkungan, sosial, kesehatan dan ekonomi. Salah satu penyebab pemanasan global yang paling terasa adalah menghangatnya suhu akibat aktivitas manusia yang terus memompa gas rumah kaca dalam jumlah yang besar ke atmosfer. Gas rumah kaca, seperti karbon dioksida (CO2), metana (CH4), dan nitrogen oksida (N2O), memiliki kemampuan untuk menyerap dan mempertahankan panas di atmosfer. Dampak yang mulai terasa adalah perubahan pola cuaca yang tidak terduga.",
                                  link = "https://dinkes.kalbarprov.go.id/artikel/pemanasan-global-memicu-masalah-kesehatan/"
                                ),
                                list(
                                  img = "https://pgnlng.co.id/wp-content/uploads/2023/09/logo-2-1.png",
                                  title = "Metana (CH4)",
                                  desc = "Metana (CH4) adalah gas tak berwarna dan tak berbau yang terdiri dari satu atom karbon dan empat atom hidrogen. Ini merupakan salah satu gas rumah kaca utama yang berkontribusi pada efek pemanasan global.",
                                  link = "https://pgnlng.co.id/berita/wawasan/gas-metana/"
                                ),
                                list(
                                  img = "https://upload.wikimedia.org/wikipedia/commons/a/af/Nature_Communications_Logo.svg",
                                  title = "Mengapa Statistik CH4 penting?",
                                  desc = "Pengetahuan yang akurat dan mendalam tentang anggaran CH 4 global , termasuk pola sumber-penyerap dan tren spasiotemporal, variasi, dan pendorong, diperlukan untuk mengelola emisi CH 4 dalam menghadapi tantangan iklim dan polusi udara.",
                                  link = "https://www.nature.com/articles/s41467-025-56218-w"
                                ),
                                list(
                                  img = "https://upload.wikimedia.org/wikipedia/en/thumb/4/49/Seal_of_ASEAN.svg/1200px-Seal_of_ASEAN.svg.png",
                                  title = "Cara mengatasi CH4 dengan kebijakan-kebijakan tertentu",
                                  desc = "Negara-negara ASEAN menanggulangi emisi gas metana melalui berbagai upaya, termasuk proyek kerjasama, pengelolaan limbah, dan perubahan praktik pertanian. Proyek Kerjasama ASEAN-Korea untuk Mitigasi Metana (AKCMM) adalah salah satu contoh upaya bersama untuk mempercepat tindakan terhadap emisi metana. 
                                           Berikut adalah beberapa cara yang dilakukan negara-negara ASEAN untuk menanggulangi gas metana:
                                           1. Proyek Kerjasama dan Dukungan Internasional:
                                           Proyek AKCMM : Kamboja menjadi tuan rumah peluncuran proyek ini, yang bertujuan untuk mengurangi emisi metana di kawasan ASEAN, menurut akstcc.org.
                                           Transfer Teknologi dan Keuangan : Dukungan dari negara maju, seperti Korea Selatan melalui AKCMM, dapat membantu negara-negara ASEAN dalam mengadopsi teknologi dan praktik terbaik untuk mitigasi metana. 
                                           2. Pengelolaan Limbah:
                                           Pengolahan Sampah Organik : Mengelola sampah organik menjadi kompos dapat mengurangi emisi metana dari tempat pembuangan akhir (TPA), menurut Transisi Energi.
                                           Pengurangan Pemborosan Makanan : Merencanakan menu makanan, memilih makanan dengan emisi rendah, menyimpan makanan dengan benar, dan mengelola sisa makanan dapat mengurangi jumlah sampah yang masuk ke TPA, dilansir Transisi Energi. 
                                           3. Pertanian Berkelanjutan:
                                           Inovasi Pertanian Padi : Mengembangkan praktik pertanian padi yang lebih efisien dan mengurangi emisi metana dari lahan sawah, menurut Universitas Muhammadiyah Kotabumi. 
                                           Pengelolaan Ternak : Mengadopsi praktik pengelolaan ternak yang mengurangi emisi metana dari sistem pencernaan hewan, mengacu pada Satuplatform. 
                                           4. Pemantauan dan Pelaporan Emisi:
                                           Pengumpulan Data ESG : Mengumpulkan dan menganalisis data Environmental, Social, and Governance (ESG) secara akurat dan efisien untuk melacak emisi karbon, termasuk metana, menurut Satuplatform.
                                           Penyusunan Laporan Emisi : Membuat laporan emisi metana yang memenuhi standar internasional dan nasional untuk transparansi dan akuntabilitas. 
                                           5. Peningkatan Kesadaran:
                                           Edukasi Publik : Meningkatkan kesadaran masyarakat tentang dampak gas metana terhadap perubahan iklim dan pentingnya mitigasi. 
                                           Kolaborasi : Bekerja sama dengan berbagai pemangku kepentingan, termasuk sektor swasta, organisasi masyarakat sipil, dan akademisi, untuk mencapai tujuan mitigasi metana. 
                                           Dengan berbagai upaya ini, negara-negara ASEAN berupaya untuk mengurangi emisi gas metana dan berkontribusi pada upaya global untuk mengatasi perubahan iklim.",
                                  links = list(
                                    list(label = "ASEAN-Korea Methane Project", url = "https://www.aseanrokfund.com/our-works/project-asean-korea-cooperation-on-methane-mitigation"),
                                    list(label = "Jejak Karbon Makanan", url = "https://transisienergi.id/jejak-karbon-dari-yang-kita-makan-dan-sisakan/"),
                                    list(label = "Metana dari Padi Sawah", url = "https://fpp.umko.ac.id/2023/11/10/peneliti-brin-jelaskan-penyebab-budi-daya-padi-sawah-sebagai-sumber-emisi-metana/"),
                                    list(label = "Solusi Emisi Pertanian", url = "https://blog.satuplatform.com/solusi-berkelanjutan-emisi-metana-dalam-pertanian/")
                                  )
                                ),
                                list(
                                  img = "https://gigafact.org/wp-content/uploads/2025/01/Skeptical20Science_04-03-2021_logo-300x300.png",
                                  title = "Kontribusi CH4 pada Pemanasan Global",
                                  desc = "Metana merupakan gas rumah kaca yang lebih kuat dari CO2, CO2 lebih banyak 200 kali di atmosfer. Misalnya - tingkat CO2 adalah 380 ppm (parts per million), sedangkan tingkat metana adalah 1.75ppm. Oleh karena itu jumlah pemanasan metana memberikan kontribusi yang terhitung, sebesar 28% dari kontribusi pemanasan oleh CO2.",
                                  link = "https://skepticalscience.com/translation.php?a=76&l=24"
                                )
                              ) ,
                              
                              function(card) {
                                tags$div(
                                  
                                  style = "
                                          cursor : pointer;
                                          flex: 0 0 300px;
                                          background-color: #fff;
                                          color: #111827;
                                          border-radius: 12px;
                                          padding: 20px;
                                          box-shadow: 0 1px 6px rgba(0,0,0,0.08);
                                          display: flex;
                                          flex-direction: column;
                                          justify-content: start;
                                          height: 400px;
                                          overflow: hidden;
                                          transition: transform 0.5s ease-in-out;
                                        ",
                                  onmouseover = "this.style.transform='scale(1.03)'",
                                  onmouseout = "this.style.transform='scale(1)'",
                                  
                                  # Gambar
                                  if (!is.null(card$img)) tags$img(src = card$img, 
                                                                   style = "
                                                                            height: 70px;
                                                                            width: auto;
                                                                            object-fit: contain;
                                                                            display: block;
                                                                            margin-bottom: 10px;
                                                                            max-width: 100%;
                                                                          "

                                                                   ),
                                  
                                  # Judul
                                  tags$h5(card$title, style = "font-size: 16px; font-weight:600; margin-bottom: 10px;"),
                                  
                                  # Isi scrollable 
                                  tags$div(
                                    style = "overflow-y: auto; flex-grow: 1; font-size: 14px; line-height: 1.5; padding-right: 5px;",
                                    tags$p(card$desc),
                                    
                                    if (!is.null(card$links)) {
                                      tags$ul(
                                        style = "padding-left: 16px; margin-top: 10px;",
                                        lapply(card$links, function(link) {
                                          tags$li(
                                            tags$a(href = link$url, target = "_blank",
                                                   style = "color: #2563eb; font-size: 14px; text-decoration: none;",
                                                   link$label)
                                          )
                                        })
                                      )
                                    } else if (!is.null(card$link)) {
                                      tags$a(href = card$link, target = "_blank",
                                             style = "color: #2563eb; font-weight:500; font-size: 14px; display:block; margin-top:10px;",
                                             "Kunjungi Artikel")
                                    }
                                  )
                                )
                              }
                            )
                          ),
                          
                          sidebar = uiOutput("legendUI")
                        )
               )
                                         
  )
}
