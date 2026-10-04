# MyDataApp

MyDataApp adalah aplikasi Android sederhana untuk login dan memasukkan data mahasiswa. Setelah login, pengguna dapat mengisi NIM, nama, program studi, kelas, alamat, dan email. Data yang berhasil ditambahkan ditampilkan sebagai daftar pada halaman dashboard.

## Teknologi dan cara kerja

- **Java** digunakan untuk logika aplikasi Android.
- **XML layouts dan resources Android** digunakan untuk mendefinisikan tampilan layar, komponen formulir, daftar, teks, dan tema.
- **AndroidX AppCompat** menyediakan basis activity yang kompatibel dengan Android.
- **Material Components** tersedia sebagai dependensi UI bersama `ConstraintLayout` dan AndroidX Activity.
- **`SharedPreferences`** digunakan untuk menyimpan username yang dipakai untuk menampilkan sapaan di dashboard.
- Data mahasiswa disimpan dalam `ArrayList` selama `DashboardActivity` berjalan dan ditampilkan melalui `StudentAdapter` pada `ListView`. Data mahasiswa **belum disimpan secara permanen** ke database atau file; data tersebut akan hilang ketika activity/aplikasi dibuat ulang.
- Tidak ada backend atau API jaringan.

Login pada versi ini menggunakan kredensial contoh yang ditetapkan langsung di kode:

| Username | Password |
| --- | --- |
| `admin` | `admin123` |

Kredensial hard-coded ini hanya untuk demonstrasi/tugas, bukan mekanisme autentikasi untuk aplikasi produksi.

## Fitur

- Memvalidasi isian username dan password pada layar login.
- Mengosongkan kolom login melalui tombol batal.
- Menampilkan nama pengguna di dashboard.
- Memvalidasi seluruh kolom data mahasiswa sebelum menambahkan data.
- Menampilkan data mahasiswa dalam daftar.
- Kembali ke layar login menggunakan tombol logout.

## Menjalankan aplikasi

Persyaratan:

- Android Studio dengan dukungan Gradle project.
- Android SDK yang mendukung `compileSdk 36`.
- JDK 11 atau kompatibel dengan konfigurasi Gradle yang digunakan.

Buka folder proyek ini di Android Studio, tunggu sinkronisasi Gradle, lalu jalankan konfigurasi aplikasi pada emulator atau perangkat Android. Alternatifnya, dari PowerShell pada folder proyek:

```powershell
.\gradlew.bat :app:assembleDebug
```

APK debug yang berhasil dibuat tersedia di `app/build/outputs/apk/debug/app-debug.apk`.

## Struktur proyek

```text
uts-mobile-app/
  app/
    src/main/
      java/com/example/mydataapp/
        MainActivity.java       # Login
        DashboardActivity.java  # Form dan daftar data mahasiswa
        StudentData.java        # Model data mahasiswa
        StudentAdapter.java     # Penghubung data ke ListView
      res/                      # Layout, tema, dan resource Android
      AndroidManifest.xml       # Deklarasi aplikasi dan activity
    build.gradle.kts            # Konfigurasi modul dan dependensi
  gradle/
    libs.versions.toml          # Versi plugin dan library
  build.gradle.kts              # Konfigurasi Gradle tingkat proyek
```
