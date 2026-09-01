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

# Arşiv açıldıktan sonra .sav/.SAV dosyasını otomatik bul.
sav_files <- list.files(
  raw_dir,
  pattern = "\\.sav$",
  full.names = TRUE,
  recursive = TRUE,
  ignore.case = TRUE
)
if (length(sav_files) == 0) {
  stop("SPSS .sav/.SAV dosyası bulunamadı. Önce scripts/01_data_download.R adımını tamamlayın.")
}
if (length(sav_files) > 1) {
  message("Birden fazla .sav/.SAV bulundu; ilk dosya kullanılacak: ", sav_files[1])
}

message("Kullanılan SPSS dosyası: ", sav_files[1])
pisa <- read_sav(sav_files[1])

# Türkiye örneklemi
pisa_tr <- pisa %>%
  filter(as.character(CNT) == "TUR")

# Çalışmanın doğrulanmış temel, psikososyal ve örnekleme değişkenleri
core_vars <- c(
  "CNT", "CNTSCHID", "CNTSTUID",
  "BELONG", "BULLIED", "TEACHSUP", "ESCS",
  "FEELSAFE", "RELATST", "SKIPPING", "SCHRISK",
  "ST004D01T", "AGE", "GRADE", "W_FSTUWT"
)

# PISA öğrenci düzeyi 80 tekrar ağırlığı
replicate_weights <- paste0("W_FSTURWT", 1:80)

# Gerekli değişkenlerin tamamının mevcut olup olmadığını kontrol et.
required_vars <- c(core_vars, replicate_weights)
missing_required <- setdiff(required_vars, names(pisa_tr))
if (length(missing_required) > 0) {
  stop(
    "PISA veri dosyasında çalışma için gerekli değişkenler eksik: ",
    paste(missing_required, collapse = ", ")
  )
}

# Yalnızca araştırmada kullanılacak değişkenleri tut.
rpd_tr <- pisa_tr %>%
  select(all_of(required_vars))

# Ham PISA labelled yapısını koruyarak RDS olarak kaydet.
saveRDS(rpd_tr, file.path(processed_dir, "pisa2022_turkey_rpd.rds"))

message("Türkiye örneklemi: ", nrow(rpd_tr), " öğrenci")
message("Seçilen değişken sayısı: ", ncol(rpd_tr))
message("Tekrar ağırlığı sayısı: ", length(replicate_weights))
message("Kaydedildi: data/processed/pisa2022_turkey_rpd.rds")

# Model değişkenlerinde eksik gözlem özeti
analysis_vars <- c(
  "BELONG", "BULLIED", "TEACHSUP", "ESCS",
  "FEELSAFE", "RELATST", "SKIPPING", "SCHRISK",
  "ST004D01T", "AGE", "GRADE", "W_FSTUWT"
)

missing_summary <- data.frame(
  Variable = analysis_vars,
  Valid = sapply(rpd_tr[analysis_vars], function(x) sum(!is.na(x))),
  Missing = sapply(rpd_tr[analysis_vars], function(x) sum(is.na(x))),
  Missing_pct = round(sapply(rpd_tr[analysis_vars], function(x) mean(is.na(x)) * 100), 2),
  row.names = NULL
)

print(missing_summary)

# Tekrar ağırlıklarında eksiklik kontrolü
rep_missing <- sapply(rpd_tr[replicate_weights], function(x) sum(is.na(x)))
if (any(rep_missing > 0)) {
  warning("Bazı tekrar ağırlıklarında eksik gözlem bulunmaktadır.")
} else {
  message("80 tekrar ağırlığının tamamında eksik değer sayısı 0.")
}
