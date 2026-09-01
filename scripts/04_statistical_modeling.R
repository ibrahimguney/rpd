# 04_statistical_modeling.R
# RPD - PISA 2022 Türkiye istatistiksel modelleme
# Amaç: Okula aidiyetin demografik, sosyoekonomik ve psikososyal yordayıcılarını
# PISA nihai öğrenci ağırlığı ve 80 tekrar ağırlığı ile incelemek.

if (!requireNamespace("survey", quietly = TRUE)) {
  stop("'survey' paketi gerekli. install.packages('survey') komutuyla kurun.")
}

processed_file <- file.path("data", "processed", "pisa2022_turkey_rpd.rds")
if (!file.exists(processed_file)) {
  stop("İşlenmiş veri bulunamadı. Önce 02_data_cleaning.R betiğini çalıştırın.")
}

rpd_tr <- readRDS(processed_file)
rep_weights <- paste0("W_FSTURWT", 1:80)

model_vars_m4 <- c(
  "BELONG", "BULLIED", "TEACHSUP", "ESCS",
  "FEELSAFE", "RELATST", "SKIPPING", "SCHRISK",
  "ST004D01T", "AGE", "GRADE", "W_FSTUWT"
)
required_vars <- c(model_vars_m4, rep_weights)
missing_vars <- setdiff(required_vars, names(rpd_tr))
if (length(missing_vars) > 0) {
  stop(
    "İşlenmiş veri setinde model için gerekli değişkenler eksik: ",
    paste(missing_vars, collapse = ", "),
    ". 02_data_cleaning.R betiğini güncelleyip RDS dosyasını yeniden oluşturun."
  )
}

# Tüm hiyerarşik modeller aynı complete-case örnekleminde tahmin edilir.
pisa_hier <- rpd_tr[
  complete.cases(rpd_tr[, model_vars_m4]),
  required_vars
]

pisa_hier$GENDER <- factor(
  pisa_hier$ST004D01T,
  levels = c(1, 2),
  labels = c("Kiz", "Erkek")
)

message("Hiyerarşik model örneklem büyüklüğü: ", nrow(pisa_hier))

# PISA 2022: nihai öğrenci ağırlığı + 80 Fay-BRR tekrar ağırlığı.
pisa_design_hier <- survey::svrepdesign(
  weights = ~W_FSTUWT,
  repweights = pisa_hier[, rep_weights],
  data = pisa_hier,
  type = "Fay",
  rho = 0.5,
  combined.weights = TRUE
)

# M1: demografik değişkenler
M1 <- survey::svyglm(
  BELONG ~ GENDER + AGE + GRADE,
  design = pisa_design_hier
)

# M2: sosyoekonomik düzey
M2 <- survey::svyglm(
  BELONG ~ GENDER + AGE + GRADE + ESCS,
  design = pisa_design_hier
)

# M3: zorbalık ve öğretmen desteği
M3 <- survey::svyglm(
  BELONG ~ GENDER + AGE + GRADE + ESCS + BULLIED + TEACHSUP,
  design = pisa_design_hier
)

# M4: genişletilmiş psikososyal / okul iklimi modeli
M4 <- survey::svyglm(
  BELONG ~ GENDER + AGE + GRADE + ESCS + BULLIED + TEACHSUP +
    FEELSAFE + RELATST + SKIPPING + SCHRISK,
  design = pisa_design_hier
)

# Model sonuçlarını tabloya dönüştürme
get_results <- function(model, model_name) {
  s <- summary(model)$coefficients
  ci <- confint(model)
  data.frame(
    Model = model_name,
    Variable = rownames(s),
    Beta = s[, "Estimate"],
    SE = s[, "Std. Error"],
    p = s[, "Pr(>|t|)"],
    CI_low = ci[, 1],
    CI_high = ci[, 2],
    row.names = NULL
  )
}

results_all <- rbind(
  get_results(M1, "M1"),
  get_results(M2, "M2"),
  get_results(M3, "M3"),
  get_results(M4, "M4")
)

output_tables <- file.path("outputs", "tables")
dir.create(output_tables, recursive = TRUE, showWarnings = FALSE)
write.csv(results_all, file.path(output_tables, "hierarchical_models_M1_M4.csv"), row.names = FALSE)

# Artık varyansı göstergesi (R-kare değildir)
dispersion_table <- data.frame(
  Model = c("M1", "M2", "M3", "M4"),
  Dispersion = c(
    summary(M1)$dispersion,
    summary(M2)$dispersion,
    summary(M3)$dispersion,
    summary(M4)$dispersion
  )
)
write.csv(dispersion_table, file.path(output_tables, "model_dispersion.csv"), row.names = FALSE)

# İç içe model/blok karşılaştırmaları: survey tasarımına uygun Rao-Scott+F LRT.
test_M1_M2 <- anova(M1, M2)
test_M2_M3 <- anova(M2, M3)
test_M3_M4 <- anova(M3, M4)

print(summary(M1))
print(summary(M2))
print(summary(M3))
print(summary(M4))
print(test_M1_M2)
print(test_M2_M3)
print(test_M3_M4)
print(confint(M4))

message("PISA ağırlıklı M1-M4 hiyerarşik modelleri tamamlandı.")
