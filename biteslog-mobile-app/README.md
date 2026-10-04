# BitesLog

BitesLog adalah aplikasi jurnal kunjungan kafe. Pengguna dapat menemukan kafe, mencatat pengalaman kunjungan, menyimpan kafe yang ingin dikunjungi, dan membuat daftar kafe pribadi.

## Teknologi yang digunakan

- **Flutter dan Dart** untuk membangun aplikasi mobile dengan satu codebase.
- **Material Design** untuk komponen dan tema antarmuka.
- **SQLite (`sqflite`)** sebagai database lokal di perangkat. Data akun, kafe, kunjungan, foto kunjungan, daftar kafe, dan watchlist disimpan di database ini.
- **`shared_preferences`** untuk menyimpan sesi pengguna yang sedang login.
- **`image_picker`** untuk memilih foto dari perangkat.
- **`geolocator` dan `geocoding`** untuk mengambil lokasi perangkat dan membantu menentukan alamat/lokasi kafe.
- **`flutter_map` dan `latlong2`** untuk menampilkan peta. Tile peta diambil dari OpenStreetMap, sehingga fitur peta memerlukan koneksi internet.
- **`intl`** untuk format tanggal dan lokal bahasa Indonesia.
- **`url_launcher`** untuk membuka tautan dari aplikasi.

## Cara kerja sistem

Saat ini BitesLog menggunakan pendekatan **lokal/offline-first**: proses login, pengelolaan profil, pencarian data, serta penyimpanan kunjungan dan daftar dilakukan di aplikasi menggunakan SQLite. Data kafe contoh juga disiapkan sebagai data awal di database lokal.

`ApiService` di aplikasi saat ini hanya menjadi lapisan pemanggil yang meneruskan operasi ke `LocalRepository`; belum ada komunikasi ke REST API atau backend server. Dengan demikian, data tersimpan pada perangkat dan tidak otomatis tersinkronisasi antarperangkat. Peta tetap memerlukan internet untuk memuat tile OpenStreetMap.

## Fitur utama

- Registrasi, login, dan pengelolaan profil lokal.
- Menjelajahi dan mencari kafe, termasuk filter kategori, area, rating, harga, dan status kunjungan.
- Melihat detail kafe dan menambahkan data kafe.
- Mencatat, mengubah, dan melihat riwayat kunjungan beserta rating, ulasan, minuman favorit, serta foto.
- Membuat dan mengelola daftar kafe pribadi.
- Menyimpan kafe ke watchlist.
- Memilih lokasi kafe melalui peta atau lokasi perangkat.

## Menjalankan aplikasi

Pastikan Flutter SDK yang kompatibel dengan versi Dart pada `app/pubspec.yaml` sudah terpasang. Dari folder proyek, jalankan:

```bash
cd app
flutter pub get
flutter run
```

Untuk menggunakan fitur lokasi, berikan izin lokasi kepada aplikasi. Koneksi internet diperlukan untuk memuat peta OpenStreetMap.

## Struktur proyek

```text
app/
  lib/
    core/       # Tema, utilitas, dan widget bersama
    features/   # Halaman dan fitur aplikasi
    models/     # Model data
    services/   # Database lokal, autentikasi, repository, dan ApiService
  test/         # Pengujian aplikasi
```
