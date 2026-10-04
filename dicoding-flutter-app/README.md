# Google Offices

Aplikasi Flutter sederhana untuk menjelajahi daftar kantor Google di berbagai kota. Pengguna dapat mencari kantor berdasarkan nama atau alamat, membuka halaman detail, dan melihat informasi seperti alamat, region, nomor telepon, koordinat, serta ID kantor.

## Teknologi dan sistem

- **Flutter dan Dart** digunakan untuk membangun aplikasi lintas platform.
- **Material Design** digunakan untuk komponen UI, tema warna, app bar, kartu, dan ikon.
- Data kantor dimodelkan dengan class `GoogleOffice` dan saat ini disimpan sebagai daftar statis di dalam aplikasi. Aplikasi tidak menggunakan database, backend, atau REST API.
- Pencarian difilter secara lokal berdasarkan nama dan alamat kantor.
- Navigasi ke halaman detail menggunakan `Navigator.push` dan `PageRouteBuilder` dengan transisi slide. ID kantor dikirim ke halaman detail, lalu digunakan untuk mencari data kantor yang sesuai.
- Foto kantor dimuat melalui URL menggunakan `Image.network`, sehingga koneksi internet diperlukan untuk menampilkannya.

## Fitur

- Menampilkan daftar kantor Google.
- Mencari kantor berdasarkan nama atau alamat.
- Menyesuaikan tampilan daftar: grid pada layar lebar dan list pada layar yang lebih sempit.
- Membuka detail kantor dengan informasi kontak dan lokasi.

## Menjalankan aplikasi

Pastikan Flutter SDK yang kompatibel dengan versi Dart pada `pubspec.yaml` sudah terpasang. Dari folder proyek, jalankan:

```bash
flutter pub get
flutter run
```

Untuk menjalankan pengujian:

```bash
flutter test
```

## Struktur proyek

```text
lib/
  app.dart                 # Tema dan konfigurasi MaterialApp
  main.dart                # Titik masuk aplikasi
  model/
    google_office.dart     # Model dan data kantor
  view/
    home_page.dart         # Daftar, pencarian, dan navigasi
    detail_page.dart       # Informasi detail kantor
test/
  widget_test.dart         # Pengujian widget
```
