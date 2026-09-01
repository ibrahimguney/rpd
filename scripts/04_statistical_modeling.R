# 04_statistical_modeling.R
# RPD - İstatistiksel modelleme

# Başlangıç modeli:
# Okula Aidiyet ~ Zorbalık + Öğretmen Desteği + ESCS + Cinsiyet + Devamsızlık
#
# Analiz aşamaları:
# 1. Temel çoklu doğrusal regresyon
# 2. Katsayıların yorumlanması ve güven aralıkları
# 3. Artık analizi ve model varsayımları
# 4. Çoklu doğrusal bağlantı kontrolü
# 5. Alternatif modellerin karşılaştırılması
# 6. PISA örnekleme tasarımı/ağırlıkları dikkate alınarak uygun modelin kurulması

message("Modelleme betiği hazır. Kesin PISA değişken kodları doğrulandıktan sonra model kurulacaktır.")
