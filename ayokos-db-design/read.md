# Desain Database Kosan

Dokumen ini menjelaskan struktur dan fungsi database yang terdapat pada file `kosan.sql` untuk sistem informasi manajemen kosan.

## 1. Tujuan Sistem

Database ini dibuat untuk mengelola:
- data kamar yang tersedia dan terisi,
- data pemilik kos,
- data penghuni kos,
- kontrak sewa antar pemilik dan penghuni,
- pembayaran bulanan penghuni.

Dengan desain ini, sistem dapat mencatat status kamar, aktivitas sewa, serta riwayat pembayaran secara terstruktur.

## 2. Nama Database

- `kosan`

## 3. Tabel Utama

### a. `kamar`
Tabel ini menyimpan informasi kamar yang disewakan.

Kolom utama:
- `id_kamar` : primary key, ID unik kamar
- `nomor_kamar` : nomor kamar (contoh: `K011`)
- `tipe` : jenis kamar (`Standar`, `Deluxe`, `VIP`)
- `harga` : harga sewa per bulan
- `status` : status kamar (`kosong`, `terisi`, `pending`)

Fungsi:
- menampilkan daftar kamar,
- memantau ketersediaan kamar,
- menghitung harga berdasarkan tipe kamar.

### b. `pemilik`
Tabel ini menyimpan data akun pemilik kos.

Kolom utama:
- `id_pemilik` : primary key
- `nama` : nama pemilik
- `no_hp` : nomor telepon
- `gmail` : email
- `username` : username login, bersifat unik
- `password` : password akun
- `role` : peran user, default `pemilik`

Fungsi:
- login sebagai admin/pemilik,
- melihat dan mengelola data penghunian,
- memvalidasi kontrak dan pembayaran.

### c. `penghuni`
Tabel ini menyimpan data penghuni kos.

Kolom utama:
- `id_penghuni` : primary key
- `nama` : nama penghuni
- `nik` : nomor identitas
- `no_hp` : nomor telepon
- `gmail` : email
- `username` : username login, bersifat unik
- `password` : password akun
- `role` : peran user, default `penghuni`

Fungsi:
- pendaftaran akun penghuni,
- login pengguna,
- pengelolaan data diri penghuni.

### d. `kontraksewa`
Tabel ini mencatat perjanjian sewa antara penghuni dan pemilik atas sebuah kamar.

Kolom utama:
- `id_kontrak` : primary key
- `id_penghuni` : foreign key ke `penghuni.id_penghuni`
- `id_kamar` : foreign key ke `kamar.id_kamar`
- `tanggal_mulai` : mulai kontrak
- `tanggal_selesai` : akhir kontrak
- `id_pemilik` : foreign key ke `pemilik.id_pemilik`
- `status` : status kontrak (`pending`, `aktif`, `nonaktif`)

Fungsi:
- mencatat siapa yang menyewa kamar tertentu,
- menghubungkan penghuni dengan kamar dan pemilik,
- menandai masa aktif atau tidak aktif kontrak.

### e. `pembayaran`
Tabel ini menyimpan riwayat pembayaran bulanan penghuni.

Kolom utama:
- `id_pembayaran` : primary key
- `id_kontrak` : foreign key ke `kontraksewa.id_kontrak`
- `bulan` : periode pembayaran (format `YYYY-MM`)
- `tanggal_bayar` : tanggal pembayaran dilakukan
- `jumlah` : nominal pembayaran
- `metode_pembayaran` : bukti atau cara pembayaran
- `status` : status pembayaran (`belum`, `lunas`, `terlambat`)

Fungsi:
- mencatat setiap transaksi pembayaran,
- menampilkan histori pembayaran per bulan,
- membantu mengecek apakah sewa sudah lunas atau terlambat.

## 4. Relasi Antar Tabel

Hubungan utama dalam database adalah:

- `pemilik` 1 to many `kontraksewa`
- `penghuni` 1 to many `kontraksewa`
- `kamar` 1 to many `kontraksewa`
- `kontraksewa` 1 to many `pembayaran`

Diagram relasi sederhana:

```text
pemilik ───< kontraksewa >─── penghuni
   \                           /
    \_________________ kamar __/

kontraksewa ───< pembayaran
```

## 5. Kunci dan Constraint

Beberapa constraint yang diterapkan:

- `id_kamar`, `id_pemilik`, `id_penghuni`, `id_kontrak`, `id_pembayaran` digunakan sebagai primary key.
- `username` pada tabel `pemilik` dan `penghuni` bersifat unik.
- `id_penghuni` pada `kontraksewa` merujuk ke `penghuni.id_penghuni`.
- `id_kamar` pada `kontraksewa` merujuk ke `kamar.id_kamar`.
- `id_pemilik` pada `kontraksewa` merujuk ke `pemilik.id_pemilik`.
- `id_kontrak` pada `pembayaran` merujuk ke `kontraksewa.id_kontrak`.

Beberapa aturan penghapusan data:
- jika data penghuni dihapus, kontrak terkait ikut terhapus (`ON DELETE CASCADE`),
- jika data kamar dihapus, kontrak terkait ikut terhapus,
- jika data pemilik dihapus, `id_pemilik` pada kontrak diubah menjadi NULL (`ON DELETE SET NULL`),
- jika kontrak dihapus, riwayat pembayaran juga ikut terhapus.

## 6. Aturan Bisnis yang Terkandung

1. Setiap kamar memiliki status yang dapat berubah sesuai kondisi sewa.
2. Setiap penghuni dapat memiliki banyak kontrak, tetapi setiap kontrak terkait dengan satu kamar tertentu.
3. Setiap pembayaran harus terhubung ke kontrak yang aktif atau pernah dibuat.
4. Periode pembayaran menggunakan format bulan seperti `2025-07`.
5. Sistem mengelola tiga status utama:
   - kamar: `kosong`, `terisi`, `pending`
   - kontrak: `pending`, `aktif`, `nonaktif`
   - pembayaran: `belum`, `lunas`, `terlambat`

## 7. Alur Kerja Umum

Secara umum alur sistem adalah:

1. Pemilik menambahkan data kamar.
2. Penghuni mendaftar dan login ke sistem.
3. Penghuni mengajukan kontrak sewa pada kamar tertentu.
4. Pemilik menyetujui atau menolak kontrak.
5. Setelah kontrak aktif, penghuni membayar biaya kos setiap bulan.
6. Data pembayaran disimpan pada tabel `pembayaran`.
7. Status kamar dan kontrak dapat diperbarui sesuai kondisi aktual.

## 8. Kesimpulan

Database `kosan` dirancang untuk mendukung sistem manajemen kos sederhana namun terstruktur. Struktur tabelnya mencakup seluruh kebutuhan dasar operasional kos, mulai dari penyimpanan data kamar, penghuni, pemilik, kontrak sewa, hingga pembayaran bulanan.

Dengan adanya relasi antar tabel dan constraint yang jelas, database ini mampu menjaga integritas data dan memudahkan pengelolaan operasional kos secara konsisten.
