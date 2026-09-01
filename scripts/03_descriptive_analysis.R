# 03_descriptive_analysis.R
# RPD - PISA 2022 Türkiye tanımlayıcı analizleri

library(dplyr)

processed_file <- file.path("data", "processed", "pisa2022_turkey_rpd.rds")
if (!file.exists(processed_file)) {
  stop("İşlenmiş veri bulunamadı. Önce 02_data_cleaning.R betiğini çalıştırın.")
}

rpd_tr <- readRDS(processed_file)

output_tables <- file.path("outputs", "tables")
output_figures <- file.path("outputs", "figures")
dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
dir.create(output_figures, recursive = TRUE, showWarnings = FALSE)

# Temel değişkenler
core_vars <- c("BELONG", "BULLIED", "TEACHSUP", "ESCS", "AGE", "GRADE")
psychosocial_vars <- c("FEELSAFE", "RELATST", "SKIPPING", "SCHRISK")

# Yeni psikososyal değişkenler işlenmiş dosyada yoksa ham Türkiye nesnesinden
# yeniden veri üretmek gerekebilir. Bu kontrol sessizce yanlış analiz yapılmasını önler.
required_vars <- c(core_vars, psychosocial_vars, "ST004D01T", "W_FSTUWT")
missing_vars <- setdiff(required_vars, names(rpd_tr))
if (length(missing_vars) > 0) {
  stop(
    "İşlenmiş veri setinde eksik değişkenler var: ",
    paste(missing_vars, collapse = ", "),
    ". 02_data_cleaning.R betiğinde bu değişkenleri seçime ekleyip RDS dosyasını yeniden oluşturun."
  )
}

# Eksik veri özeti
missing_summary <- data.frame(
  Variable = required_vars,
  Valid = sapply(rpd_tr[required_vars], function(x) sum(!is.na(x))),
  Missing = sapply(rpd_tr[required_vars], function(x) sum(is.na(x))),
  Missing_pct = round(sapply(rpd_tr[required_vars], function(x) mean(is.na(x)) * 100), 2),
  row.names = NULL
)
write.csv(missing_summary, file.path(output_tables, "missingness_summary.csv"), row.names = FALSE)

# Sürekli değişkenler için tanımlayıcı istatistikler
desc_vars <- c(core_vars, "FEELSAFE", "RELATST", "SCHRISK")
descriptive_summary <- data.frame(
  Variable = desc_vars,
  N = sapply(rpd_tr[desc_vars], function(x) sum(!is.na(x))),
  Mean = sapply(rpd_tr[desc_vars], function(x) mean(x, na.rm = TRUE)),
  SD = sapply(rpd_tr[desc_vars], function(x) sd(x, na.rm = TRUE)),
  Min = sapply(rpd_tr[desc_vars], function(x) min(x, na.rm = TRUE)),
  Max = sapply(rpd_tr[desc_vars], function(x) max(x, na.rm = TRUE)),
  row.names = NULL
)
write.csv(descriptive_summary, file.path(output_tables, "descriptive_statistics.csv"), row.names = FALSE)

# Korelasyon matrisi
cor_vars <- c("BELONG", "BULLIED", "TEACHSUP", "ESCS", "FEELSAFE", "RELATST", "SCHRISK")
cor_matrix <- cor(rpd_tr[, cor_vars], use = "pairwise.complete.obs")
write.csv(round(cor_matrix, 3), file.path(output_tables, "correlation_matrix.csv"))

# SKIPPING ikili değişkeninin dağılımı
skipping_table <- as.data.frame(table(rpd_tr$SKIPPING, useNA = "ifany"))
names(skipping_table) <- c("SKIPPING", "Frequency")
write.csv(skipping_table, file.path(output_tables, "skipping_distribution.csv"), row.names = FALSE)

# SKIPPING gruplarına göre aidiyet
belong_by_skipping <- aggregate(
  BELONG ~ SKIPPING,
  data = rpd_tr,
  FUN = function(x) c(N = sum(!is.na(x)), Mean = mean(x, na.rm = TRUE), SD = sd(x, na.rm = TRUE))
)
write.csv(belong_by_skipping, file.path(output_tables, "belong_by_skipping.csv"), row.names = FALSE)

message("PISA 2022 Türkiye tanımlayıcı analizleri tamamlandı.")
