# 02_data_cleaning.R
# RPD - PISA 2022 veri temizleme ve Türkiye örneklemi

# Amaçlar:
# 1. Ham öğrenci verisini içe aktarmak
# 2. Türkiye örneklemini seçmek
# 3. Analizde kullanılacak değişkenleri seçmek
# 4. Eksik değerleri incelemek
# 5. Analize hazır veri setini data/processed altında kaydetmek

processed_dir <- file.path("data", "processed")
if (!dir.exists(processed_dir)) dir.create(processed_dir, recursive = TRUE)

message("İşlenmiş veri klasörü hazır: ", processed_dir)
