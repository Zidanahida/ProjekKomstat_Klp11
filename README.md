# 🌏 Dashboard Emisi Gas Metana di Negara ASEAN

Dashboard ini menyajikan visualisasi terkait **emisi gas metana (CH₄)**  yang dilepaskan di atmosfer oleh negara-negara di Asia Tenggara selama periode **2000–2022**, menggunakan data dari sumber resmi seperti FAOSTAT, World Bank, dan GeoJSON Maps serta interpretasi grafik guna memberikan pemahaman mendalam bagi user.

## 📌 Fitur Utama

- **Visualisasi Emisi Metana** dalam bentuk grafik dan peta interaktif.
- **Data Luas Wilayah** dari World Bank untuk perbandingan antar negara.
- **Sumber Data Lengkap** beserta link akses ke publikasi resminya.
- **Data dapat diunduh** dan filter data yang ingin diunduh.
- **Thumbnail Informasi Terkait** pemanasan global dan gas metana.

## 🚀 Cara Menggunakan

1. Jalankan file `testRun.R` pada aplikasi shiny pengguna atau dapat langsung mengakses link berikut. shiny.io....
2. Pengguna dapat mengeksplor fitur-fitur dari masing-masing tab yang ada :
   - `Beranda`: Visualisasi dasar dan informasi mengenai emisi metana di Asia Tenggara
   - `Menu`: Visualisasi lanjutan  
   --- `Emisi Gas Metana Berdasarkan Kategori Sumber`: Grafik batang sebagai pembanding pelepasan gas metana dari berbagai faktor.  
   --- `Time Series etana Berdasarkan Kategori Sumbern dan Negara`: Grafik time series pelepasan gas metana dari setiap negara.
   - `Sumber`: Penjelasan sumber data dan metadata
   - `Unduh Data`: Menu pengunduhan data
   - `Tentang Kami`: Informasi pengembang
   - `UserGuide`: Informasi cara penggunaan dan video penggunaan dashboard

dashboard/  
├── 📄 testRun.R                # Entry point aplikasi Shiny  
├── 📄 global.R                 # Konfigurasi variabel global dan library  
├── 📄 server.R                 # Server logic dan pengolahan data
├── 📄 ui.R                     # User interface utama  
├── 📁 data/                    # Sumber data yang digunakan
│   ├── 📄 AsiaTenggara.json    # Data json Asia Tenggara  
│   ├── 📄 Data Area.xls        # Data luas wilayah negara 
│   ├── 📄 Data FAO.xls         # Data emisi gas metana dari FAO  
│   └── 📄 sea_countries.geojson.csv # Data GeoJSON   
├── 📁 R/                       # Modul UI
│   ├── 📄 sumber.R             # UI sumber data  
│   ├── 📄 home.R               # UI halaman beranda  
│   ├── 📄 aboutUs.R            # UI halaman tentang kami  
│   ├── 📄 HOME2.R              # UI beranda alternatif  
│   └── 📄 menu.R               # UI menu navigasi  
├── 📁 rsconnect/               # Konfigurasi deployment  
│   └── 📁 shinyapps.io/  
│       └── 📁 myprojectshinyapps/  
│           └── 📄 FINAL2.dcf   # File deployment config  
├── 📁 www/                     # Asset web  
│   ├── 📁 css/                 # Stylesheet  
│   │   └── 📄 style.css        
│   ├── 📁 img/                 # Gambar dan foto  
│   │   ├── 📄 Ari.jpg          # Foto profil Ari  
│   │   ├── 📄 Zidan.jpg        # Foto profil Zidan  
│   │   ├── 📄 amel.jpg         # Foto profil Amel  
|   |   └── 📄 team.jpg         # Foto kelompok
│   └── 📁 js/                  # JavaScript files  
│       └── 📄 script.js        # Script JavaScript
└── 📄 README.md                # Dokumentasi proyek


## 🔗 Sumber Data

- [FAOSTAT Greenhouse Gas Emissions](https://www.fao.org/faostat/en/#data/GT)
- [World Bank Surface Area Data](https://data.worldbank.org/indicator/AG.SRF.TOTL.K2)
- [GeoJSON ASEAN Maps](https://geojson-maps.kyd.au/?utm_source=self&utm_medium=redirect)

## 📚 Library yang Digunakan

- **R** (readxl, writexl, dplyr, tidyr, leaflet, plotly, sf, vembedr, htmltools, DT)
- **Markdown** untuk dokumentasi
- **CSS** dan tema `bslib` untuk UI

## 📦 Install Package R yang Dibutuhkan

```r
install.packages(c("shiny", "dplyr", "ggplot2", "leaflet", "plotly", "sf", "readxl", "tidyr", "bslib", "TD", "vembedr"))
