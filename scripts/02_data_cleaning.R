# 02_data_cleaning.R
# RPD - PISA 2022 veri temizleme ve Türkiye örneklemi

required_packages <- c("haven", "dplyr")
missing_packages <- required_packages[!vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)]
if (length(missing_packages) > 0) {
  stop("Önce şu paketleri kurun: ", paste(missing_packages, collapse = ", "))
}

library(haven)
library(dplyr)

raw_dir <- file.path("data", "raw", "pisa2022_student")
processed_dir <- file.path("data", "processed")
dir.create(processed_dir, recursive = TRUE, showWarnings = FALSE)

# Arşiv açıldıktan sonra .sav dosyasını otomatik bul.
sav_files <- list.files(raw_dir, pattern = "\\.sav$", full.names = TRUE, recursive = TRUE)
if (length(sav_files) == 0) {
  stop("SPSS .sav dosyası bulunamadı. Önce scripts/01_data_download.R adımını tamamlayın.")
}
if (length(sav_files) > 1) {
  message("Birden fazla .sav bulundu; ilk dosya kullanılacak: ", sav_files[1])
}

pisa <- read_sav(sav_files[1])

# Türkiye örneklemi
pisa_tr <- pisa %>%
  filter(as.character(CNT) == "TUR")

# Temel RPD modeli için doğrulanmış değişkenler
core_vars <- c(
  "CNT", "CNTSCHID", "CNTSTUID",
  "BELONG", "BULLIED", "TEACHSUP", "ESCS",
  "ST004D01T", "AGE", "GRADE", "W_FSTUWT"
)

# Tekrar ağırlıkları (varsa)
replicate_weights <- paste0("W_FSTURWT", 1:80)
selected_vars <- intersect(c(core_vars, replicate_weights), names(pisa_tr))

missing_core <- setdiff(core_vars, names(pisa_tr))
if (length(missing_core) > 0) {
  warning("Veri dosyasında bulunamayan temel değişkenler: ", paste(missing_core, collapse = ", "))
}

rpd_tr <- pisa_tr %>%
  select(all_of(selected_vars))

# haven labelled değişkenlerini analiz öncesinde koruyarak RDS olarak kaydet.
saveRDS(rpd_tr, file.path(processed_dir, "pisa2022_turkey_rpd.rds"))

message("Türkiye örneklemi: ", nrow(rpd_tr), " öğrenci")
message("Seçilen değişken sayısı: ", ncol(rpd_tr))
message("Kaydedildi: data/processed/pisa2022_turkey_rpd.rds")

# Temel değişkenlerde eksik gözlem oranları
analysis_vars <- intersect(c("BELONG", "BULLIED", "TEACHSUP", "ESCS", "ST004D01T", "AGE", "GRADE"), names(rpd_tr))
missing_summary <- sapply(rpd_tr[analysis_vars], function(x) mean(is.na(x)))
print(round(missing_summary, 3))
