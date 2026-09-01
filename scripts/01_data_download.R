# 01_data_download.R
# RPD - PISA 2022 veri edinme adımı

# Bu betik, PISA 2022 verisinin resmi kaynaktan edinilmesi için hazırlanacaktır.
# Veri URL'si ve dosya biçimi OECD kaynağından doğrulandıktan sonra
# indirme işlemi burada yeniden üretilebilir hale getirilecektir.

raw_dir <- file.path("data", "raw")
if (!dir.exists(raw_dir)) dir.create(raw_dir, recursive = TRUE)

message("Ham veri klasörü hazır: ", raw_dir)
message("Sonraki adım: PISA 2022 resmi veri kaynağı ve dosya adını doğrulamak.")
