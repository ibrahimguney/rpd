# RPD — Rehberlik ve Psikolojik Danışmanlıkta İstatistiksel Modelleme

Bu depo, Rehberlik ve Psikolojik Danışmanlık (RPD) alanında açık internet verileri kullanılarak istatistiksel modelleme uygulamaları geliştirmek amacıyla oluşturulmuştur.

## Ana uygulama

**Ergenlerde Okula Aidiyet Duygusunun Psikososyal ve Sosyoekonomik Belirleyicilerinin İstatistiksel Modellenmesi: PISA 2022 Türkiye Verileri Üzerine Bir Uygulama**

## Temel araştırma sorusu

Öğrencilerin okula aidiyet duygusu; zorbalığa maruz kalma, öğretmen desteği, sosyoekonomik düzey, devamsızlık, cinsiyet ve diğer psikososyal değişkenler tarafından ne ölçüde açıklanmaktadır?

## Planlanan analizler

- Veri indirme ve içe aktarma
- Veri temizleme ve değişken seçimi
- Tanımlayıcı istatistikler
- Veri görselleştirme
- Korelasyon analizi
- Çoklu doğrusal regresyon
- Gerekirse lojistik regresyon
- Model varsayımlarının incelenmesi
- Model karşılaştırma ve doğrulama

## Klasör yapısı

```text
RPD/
├── README.md
├── data/
│   ├── raw/
│   └── processed/
├── scripts/
│   ├── 01_data_download.R
│   ├── 02_data_cleaning.R
│   ├── 03_descriptive_analysis.R
│   └── 04_statistical_modeling.R
├── outputs/
│   ├── tables/
│   └── figures/
├── docs/
│   └── variable_dictionary.md
└── rpd.Rproj
```

## Veri kaynağı

İlk uygulamada OECD PISA 2022 öğrenci verileri kullanılacaktır. Ham veri dosyaları büyük olabileceğinden `data/raw/` klasöründeki ham veri dosyaları GitHub'a yüklenmeyecek; veri indirme işlemi R betikleriyle yeniden üretilebilir olacaktır.

## Yerel çalışma dizini

Windows üzerinde proje klasörü:

```text
C:\Users\ibrahim.guney\OneDrive - IZU\Masaüstü\01_Akademik_Calismalar\RPD
```
