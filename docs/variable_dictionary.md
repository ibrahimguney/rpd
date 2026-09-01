# Değişken Sözlüğü

## Araştırma başlığı

**Ergenlerde Okula Aidiyet Duygusunun Psikososyal ve Sosyoekonomik Belirleyicilerinin İstatistiksel Modellenmesi: PISA 2022 Türkiye Verileri Üzerine Bir Uygulama**

> Not: Aşağıdaki yapı kavramsal başlangıç sözlüğüdür. PISA 2022 kod kitabı incelendikten sonra kesin değişken adları/kodları ve ölçek açıklamaları bu dosyaya işlenecektir.

| Rol | Kavramsal değişken | Ölçüm türü | Beklenen ilişki |
|---|---|---|---|
| Y | Okula aidiyet duygusu | Sürekli / indeks | — |
| X1 | Zorbalığa maruz kalma | Sürekli / indeks | Negatif |
| X2 | Öğretmen desteği | Sürekli / indeks | Pozitif |
| X3 | Sosyoekonomik ve kültürel düzey (ESCS) | Sürekli / indeks | İncelenecek |
| X4 | Cinsiyet | Kategorik | İncelenecek |
| X5 | Devamsızlık | Sayısal / kategorik | Negatif |
| X6 | Okulda güvenlik algısı | Sürekli / indeks | Pozitif |
| X7 | Akran ilişkileri / desteği | Sürekli / indeks | Pozitif |
| X8 | Akademik başarı | Sürekli | İncelenecek |

## İlk model

```text
Okula Aidiyet = β0 + β1(Zorbalık) + β2(Öğretmen Desteği)
               + β3(ESCS) + β4(Cinsiyet) + β5(Devamsızlık) + ε
```

## Yapılacak doğrulamalar

1. PISA 2022 öğrenci anketindeki kesin değişken kodlarını belirleme.
2. Türkiye örneklemini filtrelemek için ülke kodunu doğrulama.
3. İndekslerin yönlerini ve yüksek puanın anlamını doğrulama.
4. Eksik değer kodlarını belirleme.
5. Örneklem ve nihai ağırlık değişkenlerini belirleme.
6. PISA'nın karmaşık örnekleme tasarımının analizlerde nasıl ele alınacağını belgeleme.
