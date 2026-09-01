# Değişken Sözlüğü

## Araştırma başlığı

**Ergenlerde Okula Aidiyet Duygusunun Psikososyal ve Sosyoekonomik Belirleyicilerinin İstatistiksel Modellenmesi: PISA 2022 Türkiye Verileri Üzerine Bir Uygulama**

## Doğrulanmış temel değişkenler

| Rol | PISA değişkeni | Kaynak soru | Açıklama | Tür / yön |
|---|---|---|---|---|
| Y | `BELONG` | `ST034` | Okula aidiyet duygusu indeksi | Sürekli; yüksek değer = daha güçlü aidiyet |
| X1 | `BULLIED` | `ST038` | Zorbalığa maruz kalma indeksi | Sürekli; yüksek değer = daha fazla zorbalığa maruz kalma |
| X2 | `TEACHSUP` | `ST270` | Matematik derslerinde öğretmen desteği indeksi | Sürekli; yüksek değer = daha fazla öğretmen desteği |
| X3 | `ESCS` | türetilmiş indeks | Ekonomik, sosyal ve kültürel statü | Sürekli |
| X4 | `ST004D01T` | öğrenci arka planı | Öğrencinin cinsiyeti | Kategorik |
| Kontrol | `AGE` | türetilmiş | Öğrencinin yaşı | Sürekli |
| Kontrol | `GRADE` | türetilmiş | Ülkenin modal sınıf düzeyine göre sınıf | Sayısal/ordinal |
| Kimlik | `CNT` | — | Ülke/ekonomi üç harfli kodu | Türkiye filtresi için `TUR` |
| Kimlik | `CNTSCHID` | — | Uluslararası okul kimliği | Küme / okul düzeyi |
| Kimlik | `CNTSTUID` | — | Uluslararası öğrenci kimliği | Kimlik |
| Ağırlık | `W_FSTUWT` | — | Nihai öğrenci örneklem ağırlığı | Nüfus tahminleri için |
| Tekrar ağırlıkları | `W_FSTURWT1`–`W_FSTURWT80` | — | 80 öğrenci tekrar ağırlığı | Örnekleme varyansı için |

## İndekslerin içerikleri

### BELONG — Okula aidiyet

`BELONG`, `ST034` sorusundaki altı maddeden oluşturulur. Maddeler öğrencinin okulda dışlanmış hissetmesi, kolay arkadaş edinmesi, okula ait hissetmesi, kendini uygunsuz/yabancı hissetmesi, diğer öğrenciler tarafından sevilmesi ve yalnızlık hissetmesi gibi boyutları kapsar.

### BULLIED — Zorbalığa maruz kalma

`BULLIED`, `ST038` sorusundaki dokuz maddeden oluşturulur. Dışlanma, alay edilme, tehdit edilme, eşyaların alınması/zarar görmesi, fiziksel itilme/vurulma, kötü söylenti yayılması, okulda fiziksel kavga, kendini güvensiz hissettiği için okula gitmeme ve tehdit nedeniyle para verme gibi deneyimleri kapsar.

### TEACHSUP — Öğretmen desteği

`TEACHSUP`, `ST270` sorusundaki dört maddeden oluşturulur. Matematik öğretmeninin öğrencilerin öğrenmesine ilgi göstermesi, gerektiğinde ek yardım vermesi, öğrenmelerine yardımcı olması ve öğrenciler anlayana kadar öğretmeye devam etmesi boyutlarını kapsar.

## İlk model

```text
BELONG = β0 + β1(BULLIED) + β2(TEACHSUP)
         + β3(ESCS) + β4(ST004D01T) + β5(AGE) + β6(GRADE) + ε
```

Beklenen temel ilişkiler:

- `BULLIED` → `BELONG`: negatif
- `TEACHSUP` → `BELONG`: pozitif
- `ESCS` → `BELONG`: ampirik olarak test edilecek

## Örnekleme tasarımı

PISA iki aşamalı, tabakalı bir örnekleme tasarımı kullanır. Basit ders uygulamalarında önce `W_FSTUWT` ile ağırlıklı analiz yapılabilir. İleri uygulamalarda örnekleme varyansının doğru kestirimi için `W_FSTURWT1`–`W_FSTURWT80` tekrar ağırlıkları dikkate alınmalıdır.

## Veri kaynağı

OECD PISA 2022 Public Use Files — Student Questionnaire Data File.

SPSS sıkıştırılmış öğrenci veri dosyası: `STU_QQQ_SPSS.zip`.

## Sonraki doğrulamalar

1. Devamsızlık için en uygun PISA 2022 madde/değişken kodunu kesinleştirmek.
2. Gerekirse `FEELSAFE`, `RELATST` ve diğer RPD açısından güçlü indeksleri genişletilmiş modele eklemek.
3. Türkiye örnekleminde değişkenlerin eksik değer oranlarını incelemek.
4. Modelde karmaşık örnekleme tasarımını `survey` veya uygun PISA analiz araçlarıyla uygulamak.
