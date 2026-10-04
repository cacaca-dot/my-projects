-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2025 at 06:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cobaresto`
--

-- --------------------------------------------------------

--
-- Table structure for table `akun`
--

CREATE TABLE `akun` (
  `id_akun` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('pelayan','koki','kasir','pemilik') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `akun`
--

INSERT INTO `akun` (`id_akun`, `username`, `password`, `role`) VALUES
(1, 'pemilik', 'pemilik', 'pemilik'),
(2, 'pelayan1', 'pelayan1', 'pelayan'),
(3, 'koki1', 'koki1', 'koki'),
(4, 'kasir1', 'kasir1', 'kasir');

-- --------------------------------------------------------

--
-- Table structure for table `kasir`
--

CREATE TABLE `kasir` (
  `id_kasir` int(11) NOT NULL,
  `id_akun` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kasir`
--

INSERT INTO `kasir` (`id_kasir`, `id_akun`, `nama`) VALUES
(1, 4, 'Dewi Lestari');

-- --------------------------------------------------------

--
-- Table structure for table `keluhan`
--

CREATE TABLE `keluhan` (
  `id_keluhan` int(11) NOT NULL,
  `id_pesanan` int(11) DEFAULT NULL,
  `id_pemilik` int(11) DEFAULT NULL,
  `isi_keluhan` text DEFAULT NULL,
  `solusi` text DEFAULT NULL,
  `tanggal_keluhan` datetime DEFAULT NULL,
  `status` enum('baru','diproses','selesai') DEFAULT 'baru'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keluhan`
--

INSERT INTO `keluhan` (`id_keluhan`, `id_pesanan`, `id_pemilik`, `isi_keluhan`, `solusi`, `tanggal_keluhan`, `status`) VALUES
(1, 5, 1, 'Kurang sigma', NULL, '2025-07-10 22:33:43', 'baru'),
(2, 5, 1, 'afaf', NULL, '2025-07-10 22:35:36', 'baru');

-- --------------------------------------------------------

--
-- Table structure for table `koki`
--

CREATE TABLE `koki` (
  `id_koki` int(11) NOT NULL,
  `id_akun` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `koki`
--

INSERT INTO `koki` (`id_koki`, `id_akun`, `nama`) VALUES
(1, 3, 'Joko Prasetyo');

-- --------------------------------------------------------

--
-- Table structure for table `meja`
--

CREATE TABLE `meja` (
  `no_meja` int(11) NOT NULL,
  `status` enum('kosong','terisi','reservasi') DEFAULT 'kosong'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `meja`
--

INSERT INTO `meja` (`no_meja`, `status`) VALUES
(1, 'terisi'),
(2, 'terisi'),
(3, 'terisi'),
(4, 'kosong'),
(5, 'kosong');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE `menu` (
  `id_menu` int(11) NOT NULL,
  `nama_menu` varchar(100) DEFAULT NULL,
  `harga` decimal(10,2) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id_menu`, `nama_menu`, `harga`, `stok`) VALUES
(1, 'Nasi Goreng Special', 25000.00, 48),
(2, 'Mie Goreng Jawa', 20000.00, 35),
(3, 'Ayam Bakar', 30000.00, 16),
(4, 'Sate Ayam', 25000.00, 31),
(5, 'Es Teh Manis', 5000.00, 95),
(6, 'Es Jeruk', 7000.00, 71);

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `gmail` varchar(100) DEFAULT NULL,
  `no_meja` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id_pelanggan`, `nama`, `gmail`, `no_meja`) VALUES
(5, 'Gegax', '123email@gmail.com', 1),
(6, 'Gegax', '123email@gmail.com', 2),
(30, 'Akuto', '123email@gmail.com', 1),
(31, 'MRA', '123email@gmail.com', 2),
(32, 'Akuto', '123email@gmail.com', 3),
(33, 'MRA', '123email@gmail.com', 1);

-- --------------------------------------------------------

--
-- Table structure for table `pelayan`
--

CREATE TABLE `pelayan` (
  `id_pelayan` int(11) NOT NULL,
  `id_akun` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelayan`
--

INSERT INTO `pelayan` (`id_pelayan`, `id_akun`, `nama`) VALUES
(1, 2, 'Siti Rahayu');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_pesanan` int(11) DEFAULT NULL,
  `id_kasir` int(11) DEFAULT NULL,
  `metode_pembayaran` varchar(50) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `bukti_pembayaran` varchar(255) DEFAULT NULL,
  `status` enum('belum dibayar','dibayar') DEFAULT 'belum dibayar',
  `waktu_pembayaran` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_pesanan`, `id_kasir`, `metode_pembayaran`, `total`, `bukti_pembayaran`, `status`, `waktu_pembayaran`) VALUES
(5, 5, 1, 'Tunai', 20000.00, NULL, 'dibayar', '2025-07-10 21:36:42'),
(6, 6, 1, 'Tunai', 20000.00, NULL, 'dibayar', '2025-07-10 21:36:46'),
(7, 1752169662, 1, 'QRIS', 37000.00, NULL, 'dibayar', '2025-07-11 21:29:15'),
(8, 1752234320, NULL, NULL, 55000.00, NULL, 'belum dibayar', NULL),
(9, 1752235592, NULL, NULL, 37000.00, NULL, 'belum dibayar', NULL),
(10, 1752246858, NULL, NULL, 120000.00, NULL, 'belum dibayar', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `pemilik`
--

CREATE TABLE `pemilik` (
  `id_pemilik` int(11) NOT NULL,
  `id_akun` int(11) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `gmail` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemilik`
--

INSERT INTO `pemilik` (`id_pemilik`, `id_akun`, `nama`, `gmail`) VALUES
(1, 1, 'Budi Santoso', 'budi@cobaresto.com');

-- --------------------------------------------------------

--
-- Table structure for table `pesanan`
--

CREATE TABLE `pesanan` (
  `id_pesanan` int(11) NOT NULL,
  `id_pelanggan` int(11) DEFAULT NULL,
  `id_menu` int(11) NOT NULL,
  `jumlah` int(11) DEFAULT NULL,
  `totalharga` decimal(10,2) DEFAULT NULL,
  `id_pelayan` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pesanan`
--

INSERT INTO `pesanan` (`id_pesanan`, `id_pelanggan`, `id_menu`, `jumlah`, `totalharga`, `id_pelayan`) VALUES
(5, 5, 2, 1, 20000.00, 1),
(6, 6, 2, 1, 20000.00, 1),
(1752169662, 30, 3, 1, 30000.00, NULL),
(1752169662, 30, 6, 1, 7000.00, NULL),
(1752234320, 31, 3, 1, 30000.00, NULL),
(1752234320, 31, 4, 1, 25000.00, NULL),
(1752235592, 32, 3, 1, 30000.00, NULL),
(1752235592, 32, 6, 1, 7000.00, NULL),
(1752246858, 33, 3, 2, 60000.00, 1),
(1752246858, 33, 4, 2, 50000.00, 1),
(1752246858, 33, 5, 2, 10000.00, 1);

-- --------------------------------------------------------

--
-- Table structure for table `produksi`
--

CREATE TABLE `produksi` (
  `id_produksi` int(11) NOT NULL,
  `id_pesanan` int(11) DEFAULT NULL,
  `id_koki` int(11) DEFAULT NULL,
  `waktu_mulai` datetime DEFAULT NULL,
  `waktu_selesai` datetime DEFAULT NULL,
  `status` enum('pending','dimasak','selesai') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produksi`
--

INSERT INTO `produksi` (`id_produksi`, `id_pesanan`, `id_koki`, `waktu_mulai`, `waktu_selesai`, `status`) VALUES
(5, 5, 1, '2025-07-10 19:06:31', '2025-07-10 19:55:14', 'selesai'),
(6, 6, 1, '2025-07-10 19:56:46', '2025-07-10 19:56:49', 'selesai'),
(37, 1752169662, 1, '2025-07-11 18:59:08', '2025-07-11 19:06:08', 'selesai'),
(38, 1752169662, 1, '2025-07-11 18:59:17', '2025-07-11 19:06:10', 'selesai'),
(39, 1752234320, 1, '2025-07-11 19:06:13', '2025-07-11 19:19:01', 'selesai'),
(40, 1752234320, 1, '2025-07-11 19:06:20', '2025-07-11 19:19:02', 'selesai'),
(41, 1752235592, 1, '2025-07-11 19:19:05', '2025-07-11 19:20:29', 'selesai'),
(42, 1752235592, 1, '2025-07-11 19:19:06', '2025-07-11 19:20:30', 'selesai'),
(43, 1752246858, NULL, '2025-07-11 22:14:18', NULL, 'pending'),
(44, 1752246858, NULL, '2025-07-11 22:14:19', NULL, 'pending'),
(45, 1752246858, NULL, '2025-07-11 22:14:19', NULL, 'pending');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `akun`
--
ALTER TABLE `akun`
  ADD PRIMARY KEY (`id_akun`);

--
-- Indexes for table `kasir`
--
ALTER TABLE `kasir`
  ADD PRIMARY KEY (`id_kasir`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `keluhan`
--
ALTER TABLE `keluhan`
  ADD PRIMARY KEY (`id_keluhan`),
  ADD KEY `id_pemilik` (`id_pemilik`),
  ADD KEY `keluhan_ibfk_1` (`id_pesanan`);

--
-- Indexes for table `koki`
--
ALTER TABLE `koki`
  ADD PRIMARY KEY (`id_koki`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `meja`
--
ALTER TABLE `meja`
  ADD PRIMARY KEY (`no_meja`);

--
-- Indexes for table `menu`
--
ALTER TABLE `menu`
  ADD PRIMARY KEY (`id_menu`);

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id_pelanggan`),
  ADD KEY `no_meja` (`no_meja`);

--
-- Indexes for table `pelayan`
--
ALTER TABLE `pelayan`
  ADD PRIMARY KEY (`id_pelayan`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_kasir` (`id_kasir`),
  ADD KEY `pembayaran_ibfk_1` (`id_pesanan`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`id_pemilik`),
  ADD KEY `id_akun` (`id_akun`);

--
-- Indexes for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD PRIMARY KEY (`id_pesanan`,`id_menu`),
  ADD KEY `id_pelanggan` (`id_pelanggan`),
  ADD KEY `id_menu` (`id_menu`),
  ADD KEY `id_pelayan` (`id_pelayan`);

--
-- Indexes for table `produksi`
--
ALTER TABLE `produksi`
  ADD PRIMARY KEY (`id_produksi`),
  ADD KEY `id_koki` (`id_koki`),
  ADD KEY `produksi_ibfk_1` (`id_pesanan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `akun`
--
ALTER TABLE `akun`
  MODIFY `id_akun` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `kasir`
--
ALTER TABLE `kasir`
  MODIFY `id_kasir` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `keluhan`
--
ALTER TABLE `keluhan`
  MODIFY `id_keluhan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `koki`
--
ALTER TABLE `koki`
  MODIFY `id_koki` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu`
--
ALTER TABLE `menu`
  MODIFY `id_menu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `pelayan`
--
ALTER TABLE `pelayan`
  MODIFY `id_pelayan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pemilik`
--
ALTER TABLE `pemilik`
  MODIFY `id_pemilik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `produksi`
--
ALTER TABLE `produksi`
  MODIFY `id_produksi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kasir`
--
ALTER TABLE `kasir`
  ADD CONSTRAINT `kasir_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`);

--
-- Constraints for table `keluhan`
--
ALTER TABLE `keluhan`
  ADD CONSTRAINT `keluhan_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `keluhan_ibfk_2` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik` (`id_pemilik`);

--
-- Constraints for table `koki`
--
ALTER TABLE `koki`
  ADD CONSTRAINT `koki_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`);

--
-- Constraints for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD CONSTRAINT `pelanggan_ibfk_1` FOREIGN KEY (`no_meja`) REFERENCES `meja` (`no_meja`);

--
-- Constraints for table `pelayan`
--
ALTER TABLE `pelayan`
  ADD CONSTRAINT `pelayan_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`id_kasir`) REFERENCES `kasir` (`id_kasir`);

--
-- Constraints for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD CONSTRAINT `pemilik_ibfk_1` FOREIGN KEY (`id_akun`) REFERENCES `akun` (`id_akun`);

--
-- Constraints for table `pesanan`
--
ALTER TABLE `pesanan`
  ADD CONSTRAINT `pesanan_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  ADD CONSTRAINT `pesanan_ibfk_2` FOREIGN KEY (`id_menu`) REFERENCES `menu` (`id_menu`),
  ADD CONSTRAINT `pesanan_ibfk_3` FOREIGN KEY (`id_pelayan`) REFERENCES `pelayan` (`id_pelayan`);

--
-- Constraints for table `produksi`
--
ALTER TABLE `produksi`
  ADD CONSTRAINT `produksi_ibfk_1` FOREIGN KEY (`id_pesanan`) REFERENCES `pesanan` (`id_pesanan`) ON DELETE CASCADE,
  ADD CONSTRAINT `produksi_ibfk_2` FOREIGN KEY (`id_koki`) REFERENCES `koki` (`id_koki`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
