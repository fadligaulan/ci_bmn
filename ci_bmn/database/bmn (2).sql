-- phpMyAdmin SQL Dump
-- version 4.9.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Mar 2020 pada 15.50
-- Versi server: 10.4.11-MariaDB
-- Versi PHP: 7.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bmn`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang`
--

CREATE TABLE `barang` (
  `kode_barang` varchar(200) NOT NULL,
  `nama_barang` varchar(200) NOT NULL,
  `jenis_barang` varchar(200) NOT NULL,
  `no_gudang` varchar(200) NOT NULL,
  `foto_barang` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang`
--

INSERT INTO `barang` (`kode_barang`, `nama_barang`, `jenis_barang`, `no_gudang`, `foto_barang`) VALUES
('BH-12x45', 'Reagen', 'Reagen', '56', 'foto_43.png'),
('BH-12x45123', 'Buku Tulis', 'ATK', '45', 'foto_44.png');

-- --------------------------------------------------------

--
-- Struktur dari tabel `barang_masuk`
--

CREATE TABLE `barang_masuk` (
  `id_barang_masuk` int(12) NOT NULL,
  `no_bukti` int(11) NOT NULL,
  `kode_barang` varchar(250) NOT NULL,
  `id_supplier` int(12) NOT NULL,
  `jumlah_barang_masuk` int(12) NOT NULL,
  `tgl_masuk` date NOT NULL,
  `satuan` varchar(20) NOT NULL,
  `keterangan` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `barang_masuk`
--

INSERT INTO `barang_masuk` (`id_barang_masuk`, `no_bukti`, `kode_barang`, `id_supplier`, `jumlah_barang_masuk`, `tgl_masuk`, `satuan`, `keterangan`) VALUES
(1, 456, 'BH-12x45123', 2, 600, '2020-03-26', 'PCS', 'Pembelian'),
(2, 45633, 'BH-12x45123', 3, 400, '0000-00-00', 'PCS', 'Pembelian');

--
-- Trigger `barang_masuk`
--
DELIMITER $$
CREATE TRIGGER `penjumlahan` AFTER INSERT ON `barang_masuk` FOR EACH ROW UPDATE stock_barang set stock_barang=stock_barang + new.jumlah_barang_masuk
where kode_barang=new.kode_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `penjumlahan2` AFTER UPDATE ON `barang_masuk` FOR EACH ROW UPDATE stock_barang a
   SET a.stock_barang = 
    (SELECT SUM(jumlah_barang_masuk) 
       FROM barang_masuk
      WHERE kode_barang = a.kode_barang)
 WHERE a.kode_barang = NEW.kode_barang
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_history` AFTER UPDATE ON `barang_masuk` FOR EACH ROW UPDATE history_stock set stock_record=new.jumlah_barang_masuk
where kode_barang=new.kode_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `bidang`
--

CREATE TABLE `bidang` (
  `id_bidang` int(11) NOT NULL,
  `nama_bidang` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struktur dari tabel `customers`
--

CREATE TABLE `customers` (
  `id` int(11) NOT NULL,
  `id_bidang` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `id_pegawai` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `keperluan` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `date` date NOT NULL,
  `bulan` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `tahun` year(4) NOT NULL,
  `status` enum('1','0') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active | 0=Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `history_stock`
--

CREATE TABLE `history_stock` (
  `id` int(12) NOT NULL,
  `kode_barang` varchar(200) NOT NULL,
  `stock_record` int(20) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `history_stock`
--

INSERT INTO `history_stock` (`id`, `kode_barang`, `stock_record`, `date_time`) VALUES
(1, 'BH-12x45123', 400, '2020-03-26 03:04:13'),
(2, 'BH-12x45123', 400, '2020-03-26 03:43:26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jabatan`
--

CREATE TABLE `jabatan` (
  `id_jabatan` int(11) NOT NULL,
  `jabatan` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `jabatan`
--

INSERT INTO `jabatan` (`id_jabatan`, `jabatan`) VALUES
(1, 'Ka BBPOM di Pekanbaru'),
(2, 'Kabid Pengujian'),
(3, 'Kabid Pemeriksaan'),
(4, 'Kabid Penindakan'),
(5, 'Kabag Tata usaha'),
(6, 'Kasi Sertifikasi'),
(7, 'Ka Loka POM di Kab INHIL'),
(8, 'Ka Loka POM di Kota Dumai'),
(9, 'PFM. Ahli Madya'),
(10, 'PFM Muda'),
(11, 'Fungsional Umum '),
(12, 'Kasub.Bag Program dan Evaluasi'),
(13, 'Kasi  Mikrobiologi'),
(14, 'Kasi Peng Kimia'),
(15, 'PFM Penyelia'),
(16, 'Perencana Muda'),
(17, 'Analis SDM Aparatur'),
(18, 'Kasi Inspeksi'),
(19, 'Kasub.Bag Umum'),
(20, 'Peng Adm Umum'),
(21, 'Pengadministrasi Keuangan'),
(22, 'Analis Laboratorium'),
(23, 'Analis Kepeg Penyelia'),
(24, 'PFM Pertama'),
(25, 'PFM Pelaksana ljtan'),
(26, 'Arsiparis Pelaksana laknjtan'),
(27, 'Perencana Pertama'),
(28, 'PFM Pelaksana'),
(29, 'Asisten Penyidik Obat & Mak'),
(30, 'Pengelola  BMN'),
(31, 'Verifikator Keuangan'),
(32, 'Analis Kepeg Ahli'),
(33, 'Pranata Komputer Terampil'),
(34, 'Bendahara'),
(35, 'Pengelola BMN'),
(36, 'Arsiparis Terampil'),
(37, 'Pranata Komputer Terampil/Pelaksana'),
(38, 'Caraka'),
(39, 'Keamanan'),
(40, 'PPNPN');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kadaluarsa`
--

CREATE TABLE `kadaluarsa` (
  `id_kadaluarsa` int(12) NOT NULL,
  `id_barang_masuk` int(12) NOT NULL,
  `kode_barang` varchar(200) NOT NULL,
  `tgl_kadaluarsa` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kadaluarsa`
--

INSERT INTO `kadaluarsa` (`id_kadaluarsa`, `id_barang_masuk`, `kode_barang`, `tgl_kadaluarsa`) VALUES
(6, 1, 'BH-12x45123', '2020-04-03'),
(8, 2, 'BH-12x45123', '0000-00-00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `status` enum('1','0') COLLATE utf8_unicode_ci NOT NULL DEFAULT '1' COMMENT '1=Active | 0=Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `kode_barang` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `quantity` int(5) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Trigger `order_items`
--
DELIMITER $$
CREATE TRIGGER `sisa stock` AFTER INSERT ON `order_items` FOR EACH ROW UPDATE stock_barang a
   SET a.stock_barang = 
    ((SELECT SUM(jumlah_barang_masuk) 
       FROM barang_masuk
      WHERE kode_barang = a.kode_barang) - (SELECT SUM(quantity) 
       FROM order_items
      WHERE kode_barang = a.kode_barang))
 WHERE a.kode_barang = NEW.kode_barang
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pangkat`
--

CREATE TABLE `pangkat` (
  `id_pangkat` int(2) NOT NULL,
  `pangkat` varchar(30) DEFAULT NULL,
  `golongan` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pangkat`
--

INSERT INTO `pangkat` (`id_pangkat`, `pangkat`, `golongan`) VALUES
(1, 'Pembina Utama', 'IV/e'),
(2, 'Pembina Utama Madya', 'IV/d'),
(3, 'Pembina Utama Muda', 'IV/c'),
(4, 'Pembina Tk.I', 'IV/b'),
(5, 'Pembina', 'IV/a'),
(6, 'Penata Tk.I', 'III/d'),
(7, 'Penata', 'III/c'),
(8, 'Penata Muda Tk.I', 'III/b'),
(9, 'Penata Muda', 'III/a'),
(10, 'Pengatur Tk.I', 'II/d'),
(11, 'Pengatur', 'II/c'),
(12, 'Pengatur Muda Tk.I', 'II/b'),
(13, 'Pengatur Muda', 'II/a'),
(14, 'Juru Tk.I', 'I/d'),
(15, 'Juru', 'I/c'),
(16, 'Juru Muda Tk.I', 'I/b'),
(17, 'Juru Muda', 'I/a'),
(18, '-', '-');

-- --------------------------------------------------------

--
-- Struktur dari tabel `pegawai`
--

CREATE TABLE `pegawai` (
  `id_pegawai` int(11) NOT NULL,
  `id_pangkat` int(11) DEFAULT NULL,
  `id_jabatan` int(11) DEFAULT NULL,
  `nip` varchar(512) DEFAULT NULL,
  `nama_pegawai` varchar(512) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data untuk tabel `pegawai`
--

INSERT INTO `pegawai` (`id_pegawai`, `id_pangkat`, `id_jabatan`, `nip`, `nama_pegawai`) VALUES
(1, 4, 1, '19730630 200003 1 001', 'Mohamad Kashuri,S.Si,Apt,M.Farm'),
(2, 4, 2, '19660418 199303 2 001', 'Dra. Syarnida, Apt, MM'),
(3, 4, 3, '19671128 199703 2 001', 'Dra.Syelviyane Pelle,Apt.MPPM'),
(4, 5, 4, '19760502 200212 2 001', 'Veramika Ginting,Ssi,Apt,MH'),
(5, 5, 5, '19710326 199603 2 001', 'Martarina, Ssi,MM'),
(6, 5, 6, '19650208 199803 2 001', 'Dra Hj. .Evi Mardini, Apt'),
(7, 5, 7, '19780926 200501 1 001', 'Ayi Mahpud Sidik,Ssi,Apt, MH'),
(8, 5, 8, '19810712 200604 2 004', 'Emy Amalia,S.Farm,Apt,Msc'),
(9, 5, 9, '19640121 199203 2 001', 'Dra.Erlinda'),
(10, 5, 9, '19750426 200003 2 002', 'Fendty Apriliani, SSi,Apt'),
(11, 5, 10, '19810816 200501 2 002', 'Fitria Harya Tika,S.Farm,Apt.M.Farm'),
(12, 5, 11, '19770421 200312 2 001', 'Yustinawati,Ssi,Apt'),
(13, 5, 11, '19810309 200604 2 007', 'Martina Esteria, S.Si, Apt,Msi'),
(14, 5, 12, '19820414 200604 2 004', 'Mery Indrayani,S.Farm,Apt,M.Si'),
(15, 5, 9, '19810105 200501 2 001', 'Hayati, S.Farm. Apt'),
(16, 5, 9, '19830607 2006042 003', 'Rian yuni Sartika,S.Farm,Apt,M.Farm'),
(17, 6, 13, '19790331 200312 2 001', 'Murniati Purba. Ssi.M.Si'),
(18, 6, 14, '19810223 200712 2 001', 'Neni Triana,S.Farm, Apt'),
(19, 6, 15, '19641118 198502 2 001', 'Hj. Nunang Ganis Yatlinar '),
(20, 6, 15, '19650109 198602 2 005', 'Rini Suryani'),
(21, 6, 15, '19670915 198903 2 001', 'Asnimar'),
(22, 6, 15, '19670324 199103 2 001', 'Mikzanani'),
(23, 6, 15, '19690430 199103 2 002', 'Afrida Yusni'),
(24, 6, 15, '19690218 199103 2 001', 'Yusnani'),
(25, 6, 10, '19790323 200501 2 003', 'Martina YS Hutasoit SSi, Apt'),
(26, 6, 10, '19830409 200812 2 001 ', 'Lisna Savitri B.S.Farm,Apt'),
(27, 6, 10, '198408092008122 001 ', 'Elvira Yolanda,S.Far.Apt,Msc'),
(28, 6, 10, '19830105 200604 2 005', 'Yossi Fitrianti,S.Farm,Apt,M.Farm'),
(29, 6, 16, '19630719 198602 2 001', 'Hj. Nurbayani, SE'),
(30, 6, 10, '19650315 199103 2 001', 'Seti Sumartini. SH'),
(31, 6, 17, '19620717 198303 2 001', 'Hj. Yulida, SE'),
(32, 6, 15, '19641202 198802 2 001', 'Desniarti'),
(33, 6, 10, '19820624 200604 2 006', 'Monika Kerry Armi, Ssi'),
(34, 6, 10, '198710192010122004', 'Sonya Annisa, S. Farm,Apt'),
(35, 6, 10, '198305052010122005', 'Nefi setiawati,S.Farm,Apt'),
(36, 6, 11, '19741108 19990 3 2005', 'Novita Sumbawati,S.Kom'),
(37, 6, 10, '19840701 201012 2002', 'Fitri Yulianti, S.Farm Apt'),
(38, 7, 18, '19830311 200912 2 003', 'Ully Mandasari S.Farm.Apt'),
(39, 7, 19, '19850729 201212 2002', 'Ratna Nuraini, S.Farm, Apt'),
(40, 7, 10, '19740718 199303 2 001', 'Yulianni Setiawati, S.Farm'),
(41, 7, 10, '19721210 199303 2 001', 'Molly Deswita ,SH'),
(42, 7, 10, '198304202010122002', 'Dina Ariyani S.Farm Apt'),
(43, 7, 20, '19700610 199303 2 001', 'Hj. Helmizona,SH'),
(44, 7, 15, '19640508 199303 2 001', 'Syahriani'),
(45, 7, 10, '19850405 201212 1 001', 'Hendra Alya S.Farm, Apt'),
(46, 7, 21, '19670612 199503 2 001', 'Rosnita Amd'),
(47, 7, 22, '19680310 199203 2 001', 'Rafita Fitri,S.Sos'),
(48, 7, 10, '19701022 199402 2 001', 'Ade Suryani, S.Farm'),
(49, 7, 10, '19841005 200604 2 003', 'Riyanti  P Simanjuntak,S.Farm Apt'),
(50, 7, 10, '19850219 200712 2 001', 'Detri Driani,SH'),
(51, 7, 23, '19690124 199103 2 001', 'Elviera'),
(52, 7, 10, ' 19890401 201212 1001', 'Pernanda Sapryanoki, S.Farm Apt'),
(53, 7, 10, '19861005 201212  2 001', 'Rita Aristia, S.Farm, Apt'),
(54, 7, 15, '19680817 199203 2 001', 'Suhelmi'),
(55, 8, 24, '19890102 201502 2 002', 'Mutiara Hilma,S.Farm Apt'),
(56, 8, 24, '19901123 201502 1 004', 'Syukran Hamdeni S.Farm Apt'),
(57, 8, 25, '19691104 199203 2 002', 'Yenita'),
(58, 8, 25, '19691128 199203 2 001', 'Maranata Parulian'),
(59, 8, 25, '19680617 199103 1 001', 'Alfiyan'),
(60, 8, 25, '19691123 199603 2 001', 'Donna'),
(61, 8, 25, '19670724 199703 1 002', 'Darwin'),
(62, 8, 26, '19690526 199103 2 001', 'Nur Isnani'),
(63, 8, 27, '19751104199803 2 001', 'Ade Aryeni, S.Farm, Apt'),
(64, 8, 28, '19711120 199303 2 001', 'Milayul Fitri'),
(65, 8, 24, '19731205 199703 2 001', 'Desriyanti,SH'),
(66, 8, 24, '19940605 201801 1 002', 'Shandy Nhegro Tampobolon,Sfarm Apt'),
(67, 8, 29, '19811223 200501 2 010', 'Marlina Natalia,Amaf'),
(68, 8, 20, '19650822 199703 1 001', 'Masnur'),
(69, 8, 20, '19651102 199003 1 001', 'Mirzani'),
(70, 8, 24, '198611292010122002', 'Sri Harnani, STP'),
(71, 8, 30, '19841128 200604 2 002', 'Mery Silvia, A.Md'),
(72, 8, 24, '19930727 201903 2 012', 'Yessy Yunita. Saragih .S.Farm Apt'),
(73, 8, 24, '19920617 201903 2 003', 'Tiodinar Theresia Tampubolon,S.Farm, Apt'),
(74, 8, 24, '19940228 201903 2 008', 'Uci Ramadhani, S.Farm Apt'),
(75, 8, 24, '19940309 201903 2 002', 'Fitria Ramadhani,S.Farm Apt'),
(76, 8, 24, '19890219 201903 2 005', 'Elfridawati Siallagan, S.Farm Apt'),
(77, 8, 24, '19930313 201903 2 008', 'Ertha Sastha Silitonga, S,Farm Apt'),
(78, 8, 24, '19940401 201903 2 009', 'Melva Martua Hutahuruk, S.Farm Apt'),
(79, 8, 24, '19950122 201903 2 007', 'Shinta Alicia Sihombing,S.Farm Apt'),
(80, 8, 24, '19931013 201903 2 005', 'Indah Dwi Mandala, S.Farm Apt'),
(81, 8, 24, '19931004 201903 2 002', 'Shally Liyal Khairah, S.Farm Apt'),
(82, 8, 24, '19940103 201903 2 012', 'Rizka Pratriwi, S.Farm Apt'),
(83, 8, 25, '19700714 199803 2 001', 'Yusnani'),
(84, 9, 25, '19860724 200712 1 001', 'Windu Saputra,A.Md'),
(85, 9, 25, '19860215 200712 2 001', 'Lince Marlina. A.Md'),
(86, 9, 24, '19890427 201502 2 005', 'Misnun Aderlina Nababan S.TP'),
(87, 9, 24, '19910711 201502 2 002', 'Julie Meka Tama Sinabutar,S,Si'),
(88, 9, 31, '198404012008121 001 ', 'Safrizal A.Md'),
(89, 9, 25, '19890218 201012 2 005', 'Adelia Febiyana, A.Mf'),
(90, 9, 24, '19940727 201903 2 013', 'Nadya Dwi Anugrah,S.T'),
(91, 9, 24, '19951125 201903 1 003', 'Resqi Syahri, S.Si'),
(92, 9, 24, '19840512 201903 1 001', 'Darul Nafis, S.Si'),
(93, 9, 24, '19970214 201903 1 002', 'Ali Akbar, S.Sos'),
(94, 9, 32, '19941109 201903 1 004', 'Anugrah Prananda, SE'),
(95, 9, 24, '19941227 201903 2 005', 'Kennita herdyon, SH'),
(96, 9, 24, '19960826 201903 1 002', 'Yudha Agus Pranata Barutu, S.TP'),
(97, 9, 24, '19941103 201903 2 001', 'Tri Santi, S.H'),
(98, 9, 24, '19921112 201903 2 009', 'Rozalia, S.Si'),
(99, 9, 24, '19940114 201903 1 005', 'Arif Kurniawan, S.Si'),
(100, 9, 24, '19930607 201903 2 007', 'Dewi Fahrunisa Manurung, S.T.P'),
(101, 9, 24, '19940411 201903 2 007', 'Dyah PameliaRuwaida, S.T'),
(102, 9, 24, '19960105 201903 1 001', 'Riad Ismar, SH'),
(103, 9, 31, '19950503 201903 2 005', 'Dwi Rafika Rani, S.E'),
(104, 9, 24, '19960916 201903 2 005', 'Fransiska Vony Wicheisa Manihuruk,S.K.M'),
(105, 9, 24, '19940624 201903 1 002', 'Rama Fadli, S.T'),
(106, 9, 24, '19960206 201903 2 003', 'Suci Pusfa Sari,  S.T.P'),
(107, 9, 24, '19960423 201903 2 003', 'Elsha Nadya Putri,S.K.M'),
(108, 9, 24, '19890824 201903 1 003', 'Muhammad Ridianto, SH'),
(109, 9, 24, '19931016 201903 2 003', 'Lidia Asrida, S.H'),
(110, 9, 24, '19970626 201903 2 004', 'Vinny Jovalyna, S.Si'),
(111, 9, 31, '19960426 201903 2 001', 'Debora Janet Sibarani,S.E'),
(112, 9, 24, '19950123 201903 2 004', 'Grisella Monica Gultom, S.T.P'),
(113, 10, 35, '198606022008122 002 ', 'Sri Wahyuni, A.Md'),
(114, 11, 33, '19920426 201502 1 002', 'Oki Hamdani, A.Md'),
(115, 11, 34, '19861225 201502 2 002', 'Rohana Natalia, A.Md'),
(116, 11, 35, '19951127 201903 2 004', 'Putri Harmidola Elga, A.Md'),
(117, 11, 36, '19940719 201903 2 004', 'Lisa Trinanda, A.Md'),
(118, 11, 33, '19950714 201903 1 006', 'Bambang Herianto, A.Md'),
(119, 11, 37, '19951005 201903 2 005', 'Pratiwi, A.Md'),
(120, 12, 20, '19730626201212 1 005', 'Asril'),
(121, 13, 38, '19700526 199103 1 001', 'Andisman'),
(122, 14, 39, '19721116201212 1  003', 'Salimin'),
(126, 18, 40, '-', 'Dori Ardianda S.Sos');

-- --------------------------------------------------------

--
-- Struktur dari tabel `stock_barang`
--

CREATE TABLE `stock_barang` (
  `id_stock_barang` int(12) NOT NULL,
  `kode_barang` varchar(200) DEFAULT NULL,
  `stock_barang` int(200) NOT NULL,
  `date_time` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `stock_barang`
--

INSERT INTO `stock_barang` (`id_stock_barang`, `kode_barang`, `stock_barang`, `date_time`) VALUES
(1, 'BH-12x45', 0, '0000-00-00 00:00:00'),
(2, 'BH-12x45123', 1000, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Struktur dari tabel `supplier`
--

CREATE TABLE `supplier` (
  `id_supplier` int(12) NOT NULL,
  `nama_supplier` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `supplier`
--

INSERT INTO `supplier` (`id_supplier`, `nama_supplier`) VALUES
(1, 'PT1123'),
(2, 'PT Lima nusa'),
(3, 'PT tujuh satu'),
(4, 'PT tiga roda'),
(5, 'PT sala tiga');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `barang`
--
ALTER TABLE `barang`
  ADD PRIMARY KEY (`kode_barang`);

--
-- Indeks untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  ADD PRIMARY KEY (`id_barang_masuk`);

--
-- Indeks untuk tabel `bidang`
--
ALTER TABLE `bidang`
  ADD PRIMARY KEY (`id_bidang`);

--
-- Indeks untuk tabel `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `history_stock`
--
ALTER TABLE `history_stock`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id_jabatan`);

--
-- Indeks untuk tabel `kadaluarsa`
--
ALTER TABLE `kadaluarsa`
  ADD PRIMARY KEY (`id_kadaluarsa`);

--
-- Indeks untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `customer_id` (`customer_id`);

--
-- Indeks untuk tabel `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`);

--
-- Indeks untuk tabel `pangkat`
--
ALTER TABLE `pangkat`
  ADD PRIMARY KEY (`id_pangkat`);

--
-- Indeks untuk tabel `pegawai`
--
ALTER TABLE `pegawai`
  ADD PRIMARY KEY (`id_pegawai`);

--
-- Indeks untuk tabel `stock_barang`
--
ALTER TABLE `stock_barang`
  ADD PRIMARY KEY (`id_stock_barang`);

--
-- Indeks untuk tabel `supplier`
--
ALTER TABLE `supplier`
  ADD PRIMARY KEY (`id_supplier`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `barang_masuk`
--
ALTER TABLE `barang_masuk`
  MODIFY `id_barang_masuk` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `bidang`
--
ALTER TABLE `bidang`
  MODIFY `id_bidang` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `customers`
--
ALTER TABLE `customers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `history_stock`
--
ALTER TABLE `history_stock`
  MODIFY `id` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `id_jabatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT untuk tabel `kadaluarsa`
--
ALTER TABLE `kadaluarsa`
  MODIFY `id_kadaluarsa` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT untuk tabel `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pangkat`
--
ALTER TABLE `pangkat`
  MODIFY `id_pangkat` int(2) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT untuk tabel `pegawai`
--
ALTER TABLE `pegawai`
  MODIFY `id_pegawai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT untuk tabel `stock_barang`
--
ALTER TABLE `stock_barang`
  MODIFY `id_stock_barang` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT untuk tabel `supplier`
--
ALTER TABLE `supplier`
  MODIFY `id_supplier` int(12) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
