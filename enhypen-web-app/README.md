# ENHYPEN & DARK MOON

Website statis yang mengenalkan dunia **DARK MOON: The Blood Altar** dan ENHYPEN. Halaman berisi informasi Akademi Decelis, karakter utama, karakter favorit Shion, Dardan sebagai villain, serta informasi singkat tentang ENHYPEN.

## Teknologi dan cara kerja

- **HTML5** menyusun konten halaman dengan elemen semantik seperti `header`, `nav`, `main`, `article`, `aside`, dan `footer`.
- **CSS3** mengatur tampilan, layout, navigasi, dan responsivitas halaman.
- Tidak ada JavaScript, framework, backend, database, atau proses build. Konten ditampilkan langsung sebagai halaman statis.
- Gambar disimpan lokal di folder `img/`, sedangkan font **Bebas Neue** dan **Quicksand** dimuat dari Google Fonts. Karena itu, font eksternal memerlukan koneksi internet; gambar lokal tetap dapat ditampilkan tanpa internet.

## Bagian halaman

- **Navigasi**: tautan ke bagian Akademi Decelis, karakter, Shion, dan Dardan, serta tautan profil Dicoding.
- **Konten utama**: pengenalan Akademi Decelis dan karakter dalam DARK MOON.
- **Panel samping**: gambar dan tabel informasi ENHYPEN.
- **Footer**: kredit halaman.

Layout menggunakan dua kolom pada layar lebar. Pada layar dengan lebar 768 piksel atau kurang, navigasi dan konten disusun vertikal agar lebih nyaman dibaca.

## Menjalankan website

Tidak perlu memasang dependency atau menjalankan server. Buka `index.html` langsung di browser, atau gunakan ekstensi seperti **Live Server** di VS Code untuk melihat halaman melalui server lokal.

## Struktur proyek

```text
enhypen-web-app/
  index.html       # Struktur dan konten halaman
  css/
    app.css        # Styling dan aturan responsif
  img/             # Logo dan gambar konten
  README.md        # Dokumentasi proyek
```
