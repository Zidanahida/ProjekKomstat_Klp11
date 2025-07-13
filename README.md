# 🌏 Dashboard Emisi Gas Metana di Negara ASEAN

Dashboard ini menyajikan informasi visual terkait **emisi gas metana (CH₄)** dan **luas wilayah negara-negara ASEAN** selama periode **2000–2022**, menggunakan data dari sumber resmi seperti FAOSTAT, World Bank, dan GeoJSON Maps.

## 📌 Fitur Utama

- **Visualisasi Emisi Metana** dalam bentuk grafik dan peta interaktif.
- **Data Luas Wilayah** dari World Bank untuk perbandingan antar negara.
- **Sumber Data Lengkap** beserta link akses ke publikasi resminya.
- **Thumbnail Informasi Terkait** pemanasan global dan CH₄.

## 🚀 Cara Menggunakan

1. Jalankan file `app.R` atau buka `dashboard.Rproj` (jika ada).
2. Navigasi antar tab seperti:
   - `Beranda`: Pendahuluan dan ringkasan topik
   - `Visualisasi`: Peta dan grafik interaktif
   - `Sumber Data`: Penjelasan sumber + link
   - `Panduan`: Informasi tambahan dan referensi

dashboard/  
├── 📄 app.R                    # Entry point aplikasi Shiny  
├── 📄 global.R                 # Konfigurasi global dan library  
├── 📄 server.R                 # Server logic utama  
├── 📄 ui.R                     # User interface utama  
├── 📁 data/                    # Data dan file pendukung  
│   ├── 📄 AsiaTenggara.json    # Data geografis Asia Tenggara  
│   ├── 📄 Data Area.xls        # Data area/wilayah  
│   ├── 📄 Data FAO.xls         # Data emisi dari FAO  
│   └── 📄 sea_countries.geojson.csv # Data GeoJSON negara Asia Tenggara  
├── 📁 R/                       # Modul dan fungsi R  
│   ├── 📄 sumber.R             # Modul sumber data  
│   ├── 📄 home.R               # Modul halaman beranda  
│   ├── 📄 aboutUs.R            # Modul halaman tentang kami  
│   ├── 📄 HOME2.R              # Modul beranda alternatif  
│   └── 📄 menu.R               # Modul menu navigasi  
├── 📁 rsconnect/               # Konfigurasi deployment  
│   └── 📁 shinyapps.io/  
│       └── 📁 myprojectshinyapps/  
│           └── 📄 FINAL2.dcf   # File deployment config  
├── 📁 www/                     # Asset web statis  
│   ├── 📁 css/                 # Stylesheet  
│   │   └── 📄 style.css        # Style kustom  
│   ├── 📁 img/                 # Gambar dan foto  
│   │   ├── 📄 Ari.jpg          # Foto profil Ari  
│   │   ├── 📄 Zidan.jpg        # Foto profil Zidan  
│   │   └── 📄 amel.jpg         # Foto profil Amel  
│   └── 📁 js/                  # JavaScript files  
│       ├── 📄 index.html       # Template HTML  
│       └── 📄 script.js        # Script JavaScript kustom  
└── 📄 README.md                # Dokumentasi proyek


## 🔗 Sumber Data

- [FAOSTAT Greenhouse Gas Emissions](https://www.fao.org/faostat/en/#data/GT)
- [World Bank Surface Area Data](https://data.worldbank.org/indicator/AG.SRF.TOTL.K2)
- [GeoJSON ASEAN Maps](https://geojson-maps.kyd.au/?utm_source=self&utm_medium=redirect)

## 📚 Teknologi yang Digunakan

- **R** (Shiny, dplyr, ggplot2, leaflet, plotly, sf, readxl, tidyr, bslib)
- **Markdown** untuk dokumentasi
- **CSS** dan tema `bslib` untuk UI

## 📦 Install Package R yang Dibutuhkan

```r
install.packages(c("shiny", "dplyr", "ggplot2", "leaflet", "plotly", "sf", "readxl", "tidyr", "bslib"))
