# Expense Tracker

Expense Tracker adalah aplikasi web sederhana untuk mencatat dan memantau pemasukan serta pengeluaran. Pengguna dapat menambahkan transaksi, mengubah detail atau jenis transaksi, menghapus catatan, mencari berdasarkan keterangan, dan melihat ringkasan saldo.

## Teknologi dan cara kerja

- **HTML5** membentuk struktur halaman, formulir transaksi, ringkasan, pencarian, dan daftar riwayat.
- **CSS3** mengatur tampilan responsif. Penamaan kelas mengikuti pola **BEM** dengan namespace `tracker`.
- **JavaScript vanilla** menangani interaksi halaman tanpa framework atau proses build.
- Data transaksi disimpan pada **`localStorage`** browser dengan key `transactions`, menggunakan JSON. Saat halaman dibuka, data dibaca kembali dari browser yang sama.
- Tidak ada backend, server aplikasi, atau database terpisah. Data hanya tersedia pada browser/perangkat tempat transaksi dibuat; data dapat hilang jika penyimpanan browser dibersihkan.
- Font **Outfit** dimuat dari Google Fonts. Jika tidak ada koneksi internet, browser menggunakan font cadangan sans-serif.

Setiap transaksi berisi ID, keterangan, nominal, tanggal, dan tipe (`income` atau `expense`). Ringkasan pemasukan dan pengeluaran dihitung dari seluruh transaksi yang tersimpan, lalu saldo dihitung sebagai pemasukan dikurangi pengeluaran. Pencarian mencocokkan kata kunci pada keterangan dan memperbarui daftar tanpa mengubah data yang tersimpan.

## Fitur

- Menambahkan pemasukan atau pengeluaran dengan keterangan, nominal, dan tanggal.
- Mengedit transaksi yang sudah dicatat.
- Mengubah jenis transaksi antara pemasukan dan pengeluaran.
- Menghapus transaksi.
- Melihat total pemasukan, total pengeluaran, dan saldo.
- Mencari transaksi berdasarkan keterangan.
- Menyimpan data secara lokal agar tetap tersedia saat halaman dibuka kembali di browser yang sama.

## Menjalankan aplikasi

Tidak perlu memasang dependency. Buka `index.html` langsung di browser, atau gunakan ekstensi seperti **Live Server** di VS Code untuk menjalankannya melalui server lokal.

## Struktur proyek

```text
expense-tracker-web/
  index.html   # Struktur dan elemen halaman
  style.css    # Tampilan dan layout responsif
  main.js      # Logika transaksi, pencarian, ringkasan, dan penyimpanan
  README.md    # Dokumentasi proyek
```
