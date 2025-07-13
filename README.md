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

## 📁️ Struktur Folder
📁 dashboard/
├── 📄 app.R
├── 📄 global.R
├── 📄 server.R
├── 📄 ui.R
├── 📁 data/
│ ├── 📄 AsiaTenggara.json
│ ├── 📄 Data Area.xls
│ ├── 📄 Data FAO.xls
│ └── 📄 sea_countries.geojson.csv
├── 📁 R/
│ ├── 📄 sumber.R
│ ├── 📄 home.R
│ ├── 📄 aboutUs.R
│ ├── 📄 HOME2.R
│ └── 📄 menu.R
├── 📁 rsconnect/ 
  └── 📁 shinyapps.io
    └── 📁 myprojectshinyapps
      └── 📄 FINAL2.dcf
├── 📁 www/
  ├── 📁 css/
    └── 📄 style.css
  ├── 📁 img/
    ├── 📄 Ari.jpg
    ├── 📄 Zidan.jpg
    └── 📄 amel.jpg
  ├── 📁 js/
    ├── 📄 index.html
    └── 📄 script.js
├── 📄 README.md


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
