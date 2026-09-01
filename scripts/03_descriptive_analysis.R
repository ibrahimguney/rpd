# 03_descriptive_analysis.R
# RPD - Tanımlayıcı istatistikler ve görselleştirme

# Planlanan çıktılar:
# - Örneklem büyüklüğü ve temel demografik dağılımlar
# - Ortalama, standart sapma, minimum, maksimum
# - Eksik veri özeti
# - Korelasyon matrisi
# - Temel grafikler

output_tables <- file.path("outputs", "tables")
output_figures <- file.path("outputs", "figures")

dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)

message("Tanımlayıcı analiz çıktı klasörleri hazır.")
