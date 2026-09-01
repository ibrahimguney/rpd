# 01_data_download.R
# RPD - OECD PISA 2022 öğrenci verisini edinme

raw_dir <- file.path("data", "raw")
dir.create(raw_dir, recursive = TRUE, showWarnings = FALSE)

# OECD PISA 2022 Public Use Files içindeki öğrenci anketi veri dosyası.
# Resmi dosya adı: STU_QQQ_SPSS.zip
#
# OECD indirme adresleri zaman içinde değişebildiği için doğrudan URL'yi
# sabitlemek yerine aşağıdaki dosya kontrolü kullanılır. Dosyayı OECD PISA
# 2022 Database sayfasından indirip data/raw klasörüne yerleştirin.

zip_file <- file.path(raw_dir, "STU_QQQ_SPSS.zip")

if (!file.exists(zip_file)) {
  message("PISA 2022 öğrenci veri dosyası henüz bulunamadı.")
  message("OECD PISA 2022 Database -> Student questionnaire data file")
  message("İndirilecek dosya: STU_QQQ_SPSS.zip")
  message("Hedef: ", normalizePath(raw_dir, winslash = "/", mustWork = FALSE))
} else {
  message("Veri arşivi bulundu: ", zip_file)
  unzip_dir <- file.path(raw_dir, "pisa2022_student")
  dir.create(unzip_dir, recursive = TRUE, showWarnings = FALSE)
  unzip(zip_file, exdir = unzip_dir)
  message("Arşiv açıldı: ", unzip_dir)
}
