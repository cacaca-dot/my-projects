-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 15, 2025 at 05:01 PM
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
-- Database: `kosan`
--

-- --------------------------------------------------------

--
-- Table structure for table `kamar`
--

CREATE TABLE `kamar` (
  `id_kamar` int(11) NOT NULL,
  `nomor_kamar` varchar(10) NOT NULL,
  `tipe` enum('Standar','Deluxe','VIP') NOT NULL,
  `harga` decimal(12,2) DEFAULT NULL,
  `status` enum('kosong','terisi','pending') DEFAULT 'kosong'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kamar`
--

INSERT INTO `kamar` (`id_kamar`, `nomor_kamar`, `tipe`, `harga`, `status`) VALUES
(1, 'K011', 'Standar', 1000000.00, 'terisi'),
(2, 'K012', 'Standar', 1000000.00, 'terisi'),
(3, 'K013', 'Deluxe', 1500000.00, 'terisi'),
(4, 'K014', 'Standar', 1000000.00, 'terisi'),
(5, 'K015', 'Standar', 1000000.00, 'terisi'),
(6, 'K016', 'Standar', 1000000.00, 'terisi'),
(7, 'K017', 'VIP', 2000000.00, 'terisi'),
(8, 'K018', 'Standar', 1000000.00, 'terisi'),
(9, 'K019', 'Standar', 1000000.00, 'terisi'),
(10, 'K020', 'Standar', 1000000.00, 'terisi'),
(11, 'K021', 'Standar', 1000000.00, 'terisi'),
(12, 'K022', 'Standar', 1000000.00, 'terisi'),
(13, 'K023', 'Standar', 1000000.00, 'terisi'),
(14, 'K024', 'Standar', 1000000.00, 'terisi'),
(15, 'K025', 'Standar', 1000000.00, 'terisi'),
(16, 'K026', 'Standar', 1000000.00, 'terisi'),
(17, 'K027', 'Standar', 1000000.00, 'pending'),
(19, 'K028', 'Deluxe', 1500000.00, 'terisi'),
(20, 'K029', 'Standar', 1000000.00, 'kosong'),
(21, 'K30', 'Deluxe', 1500000.00, 'kosong'),
(22, 'K030', 'VIP', 2000000.00, 'kosong');

-- --------------------------------------------------------

--
-- Table structure for table `kontraksewa`
--

CREATE TABLE `kontraksewa` (
  `id_kontrak` int(11) NOT NULL,
  `id_penghuni` int(11) NOT NULL,
  `id_kamar` int(11) NOT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `id_pemilik` int(11) DEFAULT NULL,
  `status` enum('pending','aktif','nonaktif') DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kontraksewa`
--

INSERT INTO `kontraksewa` (`id_kontrak`, `id_penghuni`, `id_kamar`, `tanggal_mulai`, `tanggal_selesai`, `id_pemilik`, `status`) VALUES
(4, 4, 2, '2025-06-30', '2025-07-04', 1, 'aktif'),
(11, 11, 5, '2025-06-30', '2025-07-18', 1, 'aktif'),
(14, 12, 6, '2025-07-03', '2025-08-02', 1, 'aktif'),
(16, 14, 8, '2025-07-04', '2025-08-03', 1, 'aktif'),
(18, 16, 7, '2025-07-04', '2025-08-03', 1, 'aktif'),
(19, 17, 10, '2025-07-04', '2025-09-03', 1, 'aktif'),
(20, 18, 9, '2025-07-04', '2025-08-03', 1, 'aktif'),
(21, 19, 11, '2025-07-04', '2025-09-03', 1, 'aktif'),
(22, 20, 12, '2025-07-04', '2025-12-03', 1, 'aktif'),
(23, 21, 13, '2025-07-05', '2025-08-04', 1, 'aktif'),
(24, 22, 14, '2025-07-07', '2025-08-06', NULL, 'aktif'),
(26, 24, 15, '2025-07-15', '2025-11-14', NULL, 'aktif'),
(28, 26, 19, '2025-07-15', '2025-09-14', NULL, 'aktif'),
(40, 38, 1, '2025-07-15', '2025-08-14', NULL, 'aktif'),
(46, 44, 16, '2025-07-15', '2025-08-14', 1, 'aktif'),
(47, 45, 4, '2025-07-15', '2025-08-14', 1, 'aktif');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL,
  `id_kontrak` int(11) NOT NULL,
  `bulan` varchar(7) DEFAULT NULL,
  `tanggal_bayar` date DEFAULT NULL,
  `jumlah` decimal(12,2) DEFAULT NULL,
  `metode_pembayaran` varchar(255) DEFAULT NULL,
  `status` enum('belum','lunas','terlambat') DEFAULT 'belum'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran`
--

INSERT INTO `pembayaran` (`id_pembayaran`, `id_kontrak`, `bulan`, `tanggal_bayar`, `jumlah`, `metode_pembayaran`, `status`) VALUES
(7, 4, '2025-06', '2025-06-30', 1000000.00, 'uploads/686253c38907f_ERD_Tiket_KAI.png', 'lunas'),
(18, 11, '2025-06', '2025-06-30', 1000000.00, '686298f6c54e5_va.PNG', 'lunas'),
(21, 14, '2025-07', '2025-07-03', 1000000.00, '6866a87c79ec0_04l5I8TqdzF9WDMJ.png', 'lunas'),
(23, 16, '2025-07', '2025-07-04', 1000000.00, '68676c335a689_ccna-introduction-to-networks.png', 'lunas'),
(25, 18, '2025-07', '2025-07-04', 2000000.00, '686789bf8978d_ERD_Tiket_KAI.png', 'lunas'),
(26, 19, '2025-07', '2025-07-04', 1000000.00, '68678b4a7d135_ERD_Tiket_KAI.png', 'lunas'),
(27, 20, '2025-07', '2025-07-04', 1000000.00, '68678c1ee27fa_ERD_Tiket_KAI.png', 'lunas'),
(28, 21, '2025-07', '2025-07-04', 1000000.00, '68678cf767da1_sigma-sign-vector-24417187.jpg', 'lunas'),
(29, 21, '2025-09', '2025-07-04', 1000000.00, '68678d643c2a0_sigma-sign-vector-24417187.jpg', 'lunas'),
(30, 22, '2025-07', '2025-07-04', 1000000.00, '6867dc4118b89_images.jpeg', 'lunas'),
(31, 22, '2025-09', '2025-07-04', 1000000.00, '6867dcdc4aea5_images.jpeg', 'lunas'),
(32, 23, '2025-07', '2025-07-05', 1000000.00, '6869256fccae0_1.PNG', 'lunas'),
(33, 24, '2025-07', '2025-07-07', 1000000.00, '686bb722b1c41_6862962aabdf8_naive-bayes-class.png', 'lunas'),
(35, 19, '2025-09', '2025-07-09', 1000000.00, '686e3ea122cbe_cobadk1.drawio.png', 'lunas'),
(36, 22, '2025-10', '2025-07-09', 1000000.00, '686e5cb94a909_cobadk1.drawio.png', 'lunas'),
(37, 22, '2025-11', '2025-07-09', 1000000.00, '686e6b11bb72e_DFD_Level2_Pemesanan.png', 'lunas'),
(38, 22, '2025-12', '2025-07-15', 1000000.00, '6875f1eb5c8bb_adbd.PNG', 'lunas'),
(39, 26, '2025-07', '2025-07-15', 1000000.00, '6875f413c4d1a_DFD_Level2_Pemesanan.png', 'lunas'),
(40, 11, '2025-08', '2025-07-15', 1000000.00, '68762b440666c_images.jpeg', 'lunas'),
(41, 26, '2025-09', '2025-07-15', 1000000.00, '6876397fbe5aa_ERD_Tiket_KAI.png', 'lunas'),
(42, 26, '2025-10', '2025-07-15', 1000000.00, '687639af82ddf_DFD_Level2_Pemesanan.png', 'lunas'),
(46, 28, '2025-07', '2025-07-15', 1500000.00, '68764104bd3f8_220px-Azathoth.jpg', 'lunas'),
(47, 28, '2025-08', '2025-07-15', 1500000.00, '6876412c020b5_sigma-sign-vector-24417187.jpg', 'lunas'),
(59, 40, '2025-07', '2025-07-15', 1000000.00, 'bukti_68764aa23d234_WhatsApp_Image_2025-07-15_at_18_56_39_5c36a6b3.jpg', 'lunas'),
(65, 46, '2025-07', '2025-07-15', 1000000.00, 'bukti_687658e57c1b1_DFD_Level2_Pemesanan.png', 'lunas'),
(66, 47, '2025-07', '2025-07-15', 1000000.00, 'bukti_6876591595c3a_DFD_Level2_Pemesanan.png', 'lunas');

-- --------------------------------------------------------

--
-- Table structure for table `pemilik`
--

CREATE TABLE `pemilik` (
  `id_pemilik` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `gmail` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('pemilik') DEFAULT 'pemilik'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemilik`
--

INSERT INTO `pemilik` (`id_pemilik`, `nama`, `no_hp`, `gmail`, `username`, `password`, `role`) VALUES
(1, 'Yanto', '0912581051', 'owner-1@example.com', 'sigma', '12345', 'pemilik');

-- --------------------------------------------------------

--
-- Table structure for table `penghuni`
--

CREATE TABLE `penghuni` (
  `id_penghuni` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `nik` varchar(20) DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `gmail` varchar(100) DEFAULT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('penghuni') DEFAULT 'penghuni'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `penghuni`
--

INSERT INTO `penghuni` (`id_penghuni`, `nama`, `nik`, `no_hp`, `gmail`, `username`, `password`, `role`) VALUES
(4, 'eshhawhe', '41253112412', '0512421', 'resident-4@example.com', 'Grifit', '12345', 'penghuni'),
(6, 'Raga', '1414141412', '0512421', 'resident-6@example.com', 'riz', '12345', 'penghuni'),
(7, 'awsgag', '41253112412', '0512421', 'resident-7@example.com', 'ligma', '12345', 'penghuni'),
(9, 'alibaba', '1414141412', '0512421', 'resident-9@example.com', 'yant', '12345', 'penghuni'),
(11, 'GAD', '41253112412', '0512421', 'resident-11@example.com', 'GAD', '12345', 'penghuni'),
(12, 'Rizki', '151251', '12415141', 'resident-12@example.com', 'Taigerga', '12345', 'penghuni'),
(14, 'Gbafax', '12345', '24142', 'resident-14@example.com', 'Gfa', '12345', 'penghuni'),
(16, 'r1241', '12412512515', '124112125', 'resident-16@example.com', 'mra', '12345', 'penghuni'),
(17, 'Ryu', '124214', '1241541', 'resident-17@example.com', 'Riz27', '12345', 'penghuni'),
(18, 'qr12r', '1412441', '123512', 'resident-18@example.com', 'Grtza', '12345', 'penghuni'),
(19, 'Rizki251', '1235415', '1231414', 'resident-19@example.com', 'Taigergax', '12345', 'penghuni'),
(20, 'Nauval', '5124215123', '124121241', 'resident-20@example.com', 'Nauval', '12345', 'penghuni'),
(21, 'Wa ode', '3253471252', '15126214161', 'resident-21@example.com', 'Chaca', '12345', 'penghuni'),
(22, 'Akuto', '12515141', '4125124', 'resident-22@example.com', 'Nauga', '12345', 'penghuni'),
(23, 'asgawgawg', '124214124', '4125214123', 'resident-23@example.com', 'Goga', '12345', 'penghuni'),
(24, 'Muhamma', '1000009', '99990730722', 'resident-24@example.com', 'Guts', '12345', 'penghuni'),
(26, 'MRA1', '1251221314', '1532414124', 'resident-26@example.com', 'GAY', '12345', 'penghuni'),
(27, 'Decade', '13412413', '1241242141512', 'resident-27@example.com', 'Fax', '12345', 'penghuni'),
(28, 'GAGA', '1234141', '141414', 'resident-28@example.com', 'XGA', '12345', 'penghuni'),
(29, 'tqfqw', '1231412', '1541151', 'resident-29@example.com', 'HAFA', '12345', 'penghuni'),
(30, 'gawgawg', '141241414', '1412414142', 'resident-30@example.com', 'GDAa', '12345', 'penghuni'),
(31, 'fwqfaawf', '12412421414', '12412512412', 'resident-31@example.com', 'HFGAG', '12345', 'penghuni'),
(32, 'GAG', '1414412421', '4125412521', 'resident-32@example.com', 'GAGA', '12345', 'penghuni'),
(33, 'FGAWgw', '12412414', '412414124', 'resident-33@example.com', 'FAFAFAG', '12345', 'penghuni'),
(34, 'hsegaha', '1412421', '1414124', 'resident-34@example.com', 'GAX', '12345', 'penghuni'),
(35, 'GAGA', '12412541', '145124121', 'resident-35@example.com', 'GHAX', '$2y$10$Cbe68MiEvsQps.cUV5RzeOOmDXhVEDEwqvMFc7d0X2tEA3llJH5Ou', 'penghuni'),
(36, 'GAGAG', '13131331341', '1241241241441', 'resident-36@example.com', 'GAGAT', '$2y$10$Qg2APR1II.l2E4YdK1GN.eDHaPlDIRT1QRNQAEhWg58KT80Tn7rD.', 'penghuni'),
(37, 'FAGA', '1241241414111111', '141441241241', 'resident-37@example.com', 'FAGAA', '$2y$10$sWSgC0ydLdksPTzhn5FS0.uwYJUs523EU2o9leFJfiawW5h9UpNGq', 'penghuni'),
(38, 'Goat', '1241414141412412', '2141242141241', 'resident-38@example.com', 'GoatX', '$2y$10$JFTB78a1olzFXndqOl9PL.5TlTKLUpiTG/r3XEd/jB2wrX6OSQ4HS', 'penghuni'),
(39, 'XVAGA', '1111111111111111', '4124214124141', 'resident-39@example.com', 'XVAGA', '$2y$10$mmbvae9Fq0bFjAcw28RSwe8gyC15Q/xOm3aeFGJzmTlEAhrwOgcVm', 'penghuni'),
(41, 'GAFAF', '4124141241241111', '14141244124141', 'resident-41@example.com', 'GAFAF', '$2y$10$0e0qiwfLYFJvMDOOC5BaPOySYGHZrhHwFsTvVClDq0FuWu4f8zfCu', 'penghuni'),
(44, 'GTAX', '1111111111111111', '1111111111111', 'resident-44@example.com', 'GTAXR', 'MRizki27', 'penghuni'),
(45, 'BABI', '1341241241411111', '41412414141241', 'resident-45@example.com', 'BABIX', 'MRizki27', 'penghuni');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `kamar`
--
ALTER TABLE `kamar`
  ADD PRIMARY KEY (`id_kamar`);

--
-- Indexes for table `kontraksewa`
--
ALTER TABLE `kontraksewa`
  ADD PRIMARY KEY (`id_kontrak`),
  ADD KEY `id_penghuni` (`id_penghuni`),
  ADD KEY `id_kamar` (`id_kamar`),
  ADD KEY `fk_kontraksewa_pemilik` (`id_pemilik`);

--
-- Indexes for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `id_kontrak` (`id_kontrak`);

--
-- Indexes for table `pemilik`
--
ALTER TABLE `pemilik`
  ADD PRIMARY KEY (`id_pemilik`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `penghuni`
--
ALTER TABLE `penghuni`
  ADD PRIMARY KEY (`id_penghuni`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kamar`
--
ALTER TABLE `kamar`
  MODIFY `id_kamar` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `kontraksewa`
--
ALTER TABLE `kontraksewa`
  MODIFY `id_kontrak` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `pembayaran`
--
ALTER TABLE `pembayaran`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `pemilik`
--
ALTER TABLE `pemilik`
  MODIFY `id_pemilik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `penghuni`
--
ALTER TABLE `penghuni`
  MODIFY `id_penghuni` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kontraksewa`
--
ALTER TABLE `kontraksewa`
  ADD CONSTRAINT `fk_kontraksewa_pemilik` FOREIGN KEY (`id_pemilik`) REFERENCES `pemilik` (`id_pemilik`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `kontraksewa_ibfk_1` FOREIGN KEY (`id_penghuni`) REFERENCES `penghuni` (`id_penghuni`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `kontraksewa_ibfk_2` FOREIGN KEY (`id_kamar`) REFERENCES `kamar` (`id_kamar`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_kontrak`) REFERENCES `kontraksewa` (`id_kontrak`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
