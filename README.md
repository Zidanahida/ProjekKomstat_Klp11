# 🌏 Dashboard Emisi Gas Metana di Negara ASEAN

Dashboard ini menyajikan visualisasi terkait **emisi gas metana (CH₄)**  yang dilepaskan di atmosfer oleh negara-negara di Asia Tenggara selama periode **2000–2022**, menggunakan data dari sumber resmi seperti FAOSTAT, World Bank, dan GeoJSON Maps serta interpretasi grafik guna memberikan pemahaman mendalam bagi user.

## 📌 Fitur Utama

- **Visualisasi Emisi Metana** dalam bentuk grafik dan peta interaktif.
- **Data Luas Wilayah** dari World Bank untuk perbandingan antar negara.
- **Sumber Data Lengkap** beserta link akses ke publikasi resminya.
- **Data dapat diunduh** dan filter data yang ingin diunduh.
- **Thumbnail Informasi Terkait** pemanasan global dan gas metana.

## 🚀 Cara Menggunakan
Pengguna dapat langsung mengakses web berikut : ...
atau melakukan instalasi secara lokal pada aplikasi shiny pengguna.

Tata cara instalasi lokal :
1. Unduh seluruh file yang ada pada Repository ini dalam format `ZIP`.
2. Ekstrak file `ZIP` yang telah diunduh.
3. Buka file `testRun.R` dan install seluruh packages yang diperlukan.
4. Jalankan `shiny::runApp()`
5. Pengguna dapat mengeksplor fitur-fitur dari masing-masing tab yang ada :
   - `Beranda`: Visualisasi dasar dan informasi mengenai emisi metana di Asia Tenggara
   - `Menu`: Visualisasi lanjutan  
   --- `Emisi Gas Metana Berdasarkan Kategori Sumber`: Grafik batang sebagai pembanding pelepasan gas metana dari berbagai faktor.  
   --- `Time Series etana Berdasarkan Kategori Sumbern dan Negara`: Grafik time series pelepasan gas metana dari setiap negara.
   - `Sumber`: Penjelasan sumber data dan metadata
   - `Unduh Data`: Menu pengunduhan data
   - `Tentang Kami`: Informasi pengembang
   - `UserGuide`: Informasi cara penggunaan dan video penggunaan dashboard


## 📁️ Struktur Folder
CH4DashBoard/  
├── 📄 testRun.R  
├── 📄 global.R  
├── 📄 server.R  
├── 📄 ui.R  
├── 📁 data/  
│   ├── 📄 AsiaTenggara.json   
│   ├── 📄 Data Area.xls  
│   ├── 📄 Data FAO.xls   
│   └── 📄 sea_countries.geojson.csv  
├── 📁 R/  
│   ├── 📄 sumber.R  
│   ├── 📄 home.R  
│   ├── 📄 aboutUs.R  
│   ├── 📄 HOME2.R  
│   └── 📄 menu.R  
├── 📁 rsconnect/  
│   └── 📁 shinyapps.io/  
│       └── 📁 myprojectshinyapps/  
│           └── 📄 FINAL2.dcf   
├── 📁 www/  
│   ├── 📁 css/  
│   │   └── 📄 style.css        
│   ├── 📁 img/  
│   │   ├── 📄 Ari.jpg  
│   │   ├── 📄 Zidan.jpg  
│   │   ├── 📄 amel.jpg   
│   │   └── 📄 team.jpg  
│   └── 📁 js/  
│       └─── 📄 script.js  
└── 📄 README.md  


## 🔗 Sumber Data

- [FAOSTAT Greenhouse Gas Emissions](https://www.fao.org/faostat/en/#data/GT)
- [World Bank Surface Area Data](https://data.worldbank.org/indicator/AG.SRF.TOTL.K2)
- [GeoJSON ASEAN Maps](https://geojson-maps.kyd.au/?utm_source=self&utm_medium=redirect)

## 📚 Library yang Digunakan

- **R** (readxl, writexl, dplyr, tidyr, leaflet, plotly, sf, vembedr, htmltools, DT)
- **Markdown** untuk dokumentasi
- **CSS** dan tema `bslib` untuk UI

## 📦 Install Package R yang Dibutuhkan
Jika menajalankan 

```r
install.packages(c("shiny", "dplyr", "ggplot2", "leaflet", "plotly", "sf", "readxl", "tidyr", "bslib", "TD", "vembedr"))
