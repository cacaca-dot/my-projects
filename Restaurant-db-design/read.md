# Desain Database CobaResto

Dokumen ini menjelaskan struktur database yang terdapat pada file `cobaresto (5).sql`. Database ini dirancang untuk sistem manajemen restoran sederhana yang mencakup proses pemesanan, produksi makanan, pembayaran, pengelolaan meja, serta keluhan pelanggan.

## 1. Tujuan Sistem

Database ini digunakan untuk mendukung kegiatan operasional restoran, yaitu:
- mengelola akun pegawai (pelayan, koki, kasir, pemilik),
- mencatat pelanggan dan nomor meja,
- membuat pesanan menu,
- memproses produksi masakan oleh koki,
- mencatat pembayaran pelanggan,
- menangani keluhan dari pelanggan ke pemilik.

## 2. Nama Database

- `cobaresto`

## 3. Tabel Utama

### a. `akun`
Tabel ini berfungsi sebagai pusat autentikasi pengguna sistem.

Kolom utama:
- `id_akun` : primary key
- `username` : username akun
- `password` : password akun
- `role` : peran akun (`pelayan`, `koki`, `kasir`, `pemilik`)

Fungsi:
- login untuk masing-masing role,
- membedakan hak akses setiap pegawai.

### b. `pelayan`
Tabel ini menyimpan data pelayan yang terhubung ke akun.

Kolom utama:
- `id_pelayan`
- `id_akun` : foreign key ke `akun.id_akun`
- `nama` : nama pelayan

Fungsi:
- menghubungkan pegawai pelayan dengan akun login,
- memudahkan pencatatan pesanan yang ditangani oleh pelayan tertentu.

### c. `koki`
Tabel ini menyimpan data koki yang bertugas memproduksi makanan.

Kolom utama:
- `id_koki`
- `id_akun` : foreign key ke `akun.id_akun`
- `nama` : nama koki

Fungsi:
- menandai koki yang mengerjakan pesanan,
- digunakan dalam tabel `produksi`.

### d. `kasir`
Tabel ini menyimpan data kasir yang menerima pembayaran.

Kolom utama:
- `id_kasir`
- `id_akun` : foreign key ke `akun.id_akun`
- `nama` : nama kasir

Fungsi:
- mencatat pembayaran yang ditangani kasir,
- menghubungkan transaksi pembayaran dengan pegawai kasir.

### e. `pemilik`
Tabel ini menyimpan data pemilik restoran.

Kolom utama:
- `id_pemilik`
- `id_akun` : foreign key ke `akun.id_akun`
- `nama` : nama pemilik
- `gmail` : email pemilik

Fungsi:
- mengakses data operasional restoran,
- menindaklanjuti keluhan pelanggan.

### f. `meja`
Tabel ini menyimpan status meja di restoran.

Kolom utama:
- `no_meja` : nomor meja
- `status` : status meja (`kosong`, `terisi`, `reservasi`)

Fungsi:
- memantau ketersediaan meja,
- menghubungkan meja dengan pelanggan.

### g. `pelanggan`
Tabel ini menyimpan data pelanggan yang datang ke restoran.

Kolom utama:
- `id_pelanggan`
- `nama`
- `gmail`
- `no_meja` : foreign key ke `meja.no_meja`

Fungsi:
- mencatat pelanggan yang sedang makan di meja tertentu,
- menjadi referensi bagi pesanan pelanggan.

### h. `menu`
Tabel ini berisi daftar menu yang tersedia di restoran.

Kolom utama:
- `id_menu`
- `nama_menu`
- `harga`
- `stok`

Fungsi:
- menyimpan detail menu,
- memantau stok bahan makanan,
- dipakai saat pelanggan memesan menu.

### i. `pesanan`
Tabel ini menyimpan data pesanan pelanggan.

Kolom utama:
- `id_pesanan`
- `id_pelanggan` : foreign key ke `pelanggan.id_pelanggan`
- `id_menu` : foreign key ke `menu.id_menu`
- `jumlah` : jumlah item yang dipesan
- `totalharga` : total harga untuk item tersebut
- `id_pelayan` : foreign key ke `pelayan.id_pelayan`

Catatan penting:
- `pesanan` memakai komposit primary key (`id_pesanan`, `id_menu`), artinya satu transaksi pesanan bisa terdiri dari beberapa menu yang dipilih.

Fungsi:
- mencatat setiap item yang dipesan pelanggan,
- menjadi acuan dalam proses produksi dan pembayaran.

### j. `produksi`
Tabel ini menyimpan status pengerjaan pesanan oleh koki.

Kolom utama:
- `id_produksi`
- `id_pesanan` : foreign key ke `pesanan.id_pesanan`
- `id_koki` : foreign key ke `koki.id_koki`
- `waktu_mulai`
- `waktu_selesai`
- `status` : `pending`, `dimasak`, `selesai`

Fungsi:
- memantau proses memasak,
- melihat apakah pesanan sudah selesai atau masih dikerjakan.

### k. `pembayaran`
Tabel ini menyimpan transaksi pembayaran dari pesanan pelanggan.

Kolom utama:
- `id_pembayaran`
- `id_pesanan` : foreign key ke `pesanan.id_pesanan`
- `id_kasir` : foreign key ke `kasir.id_kasir`
- `metode_pembayaran` : metode bayar, seperti Tunai atau QRIS
- `total` : jumlah yang dibayar
- `bukti_pembayaran` : file bukti pembayaran (jika ada)
- `status` : `belum dibayar` atau `dibayar`
- `waktu_pembayaran`

Fungsi:
- mencatat transaksi pembayaran,
- memudahkan kasir dalam memantau status pembayaran.

### l. `keluhan`
Tabel ini menyimpan keluhan pelanggan terhadap pesanan atau layanan.

Kolom utama:
- `id_keluhan`
- `id_pesanan` : foreign key ke `pesanan.id_pesanan`
- `id_pemilik` : foreign key ke `pemilik.id_pemilik`
- `isi_keluhan`
- `solusi`
- `tanggal_keluhan`
- `status` : `baru`, `diproses`, `selesai`

Fungsi:
- menampung feedback pelanggan,
- memantau tindak lanjut dari pemilik terhadap keluhan.

## 4. Relasi Antar Tabel

Hubungan utama dalam database adalah:

```text
akun ───< pelayan
akun ───< koki
akun ───< kasir
akun ───< pemilik

meja ───< pelanggan
pelanggan ───< pesanan
menu ───< pesanan
pelayan ───< pesanan

pesanan ───< produksi
pesanan ───< pembayaran
pesanan ───< keluhan
koki ───< produksi
kasir ───< pembayaran
pemilik ───< keluhan
```

## 5. Kunci dan Constraint

Beberapa constraint yang diterapkan:
- `akun.id_akun` sebagai primary key.
- `pesanan` menggunakan primary key gabungan (`id_pesanan`, `id_menu`).
- `pelanggan.no_meja` merujuk ke `meja.no_meja`.
- `pesanan.id_menu` merujuk ke `menu.id_menu`.
- `pesanan.id_pelanggan` merujuk ke `pelanggan.id_pelanggan`.
- `pesanan.id_pelayan` merujuk ke `pelayan.id_pelayan`.
- `produksi.id_pesanan` merujuk ke `pesanan.id_pesanan` dengan `ON DELETE CASCADE`.
- `produksi.id_koki` merujuk ke `koki.id_koki`.
- `pembayaran.id_pesanan` merujuk ke `pesanan.id_pesanan` dengan `ON DELETE CASCADE`.
- `pembayaran.id_kasir` merujuk ke `kasir.id_kasir`.
- `keluhan.id_pesanan` merujuk ke `pesanan.id_pesanan` dengan `ON DELETE CASCADE`.

## 6. Aturan Bisnis yang Terkandung

1. Setiap akun hanya memiliki satu role tertentu.
2. Meja dapat berstatus kosong, terisi, atau reservasi.
3. Satu pelanggan dapat memiliki banyak pesanan.
4. Satu pesanan dapat terdiri dari beberapa menu.
5. Setiap pesanan akan diproses oleh koki melalui tabel `produksi`.
6. Pembayaran harus terkait dengan pesanan tertentu dan kasir tertentu.
7. Keluhan pelanggan dicatat dan ditindaklanjuti oleh pemilik restoran.

## 7. Alur Kerja Umum

Secara umum alur sistem restoran adalah:

1. Pelanggan datang dan memilih meja.
2. Pelayan mencatat pesanan pelanggan.
3. Pesanan disimpan di tabel `pesanan`.
4. Koki memulai proses produksi di tabel `produksi`.
5. Setelah makanan siap, kasir menerima pembayaran.
6. Status pembayaran dicatat pada tabel `pembayaran`.
7. Jika ada keluhan, pelanggan dapat mengirimkan keluhan dan pemilik menangani solusi.

## 8. Kesimpulan

Database `cobaresto` dirancang untuk mendukung sistem restoran yang sederhana namun terstruktur. Terdapat pemisahan peran yang jelas antara pelayan, koki, kasir, dan pemilik. Selain itu, data pelanggan, menu, pesanan, produksi, pembayaran, dan keluhan sudah terhubung secara teratur melalui relasi foreign key.

Dengan struktur tersebut, sistem dapat mengelola operasional restoran secara efektif, mulai dari menerima pesanan sampai menangani keluhan pelanggan.
