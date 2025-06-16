-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2025 at 05:39 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_simkatic`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_kategori` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id`, `nama_kategori`, `created_at`, `updated_at`) VALUES
(1, 'Lipstik', '2025-06-15 19:23:46', '2025-06-15 19:23:46');

-- --------------------------------------------------------

--
-- Table structure for table `metode_pembayaran`
--

CREATE TABLE `metode_pembayaran` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `metode_pembayaran`
--

INSERT INTO `metode_pembayaran` (`id`, `nama`, `created_at`, `updated_at`) VALUES
(1, 'cash', NULL, NULL),
(2, 'ewallet', NULL, NULL),
(3, 'bank', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2025_01_09_123107_create_users_table', 1),
(2, '2025_01_09_123135_create_personal_access_tokens_table', 1),
(3, '2025_01_09_123224_create_password_reset_tokens_table', 1),
(4, '2025_01_09_123252_create_sessions_table', 1),
(5, '2025_01_10_024810_create_kategori_table', 1),
(6, '2025_01_10_024900_create_produk_table', 1),
(7, '2025_01_11_012250_create_pembelian_table', 1),
(8, '2025_01_11_161445_create_cache_table', 1),
(9, '2025_02_27_180828_create_metode_pembayaran_table', 1),
(10, '2025_02_27_181111_create_transaksi_table', 1),
(11, '2025_02_27_182222_create_transaksi_item_table', 1),
(12, '2025_04_16_034728_add_harga_final_to_produk_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pembelian`
--

CREATE TABLE `pembelian` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `produk_id` bigint(20) UNSIGNED NOT NULL,
  `jumlah` int(11) NOT NULL DEFAULT 1,
  `satuan` enum('Pcs','Box') NOT NULL,
  `isi_perbox` int(11) DEFAULT NULL,
  `harga_beli` int(11) NOT NULL DEFAULT 0,
  `total_harga` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pembelian`
--

INSERT INTO `pembelian` (`id`, `produk_id`, `jumlah`, `satuan`, `isi_perbox`, `harga_beli`, `total_harga`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'Box', 12, 100000, 100000, '2025-06-15 19:24:42', '2025-06-15 19:24:42');

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(3, 'App\\Models\\User', 1, 'auth_token', '712a4d1710c44887cdae63ad75071c604e48eba5c45e52fe478672cff6979b00', '[\"*\"]', '2025-06-15 19:34:52', NULL, '2025-06-15 19:19:44', '2025-06-15 19:34:52');

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_produk` varchar(255) NOT NULL,
  `kategori_id` bigint(20) UNSIGNED NOT NULL,
  `stok` int(11) NOT NULL DEFAULT 0,
  `harga_jual` int(11) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `diskon` int(11) DEFAULT NULL,
  `harga_final` int(11) NOT NULL DEFAULT 0,
  `gambar_produk` varchar(255) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`id`, `nama_produk`, `kategori_id`, `stok`, `harga_jual`, `harga_beli`, `diskon`, `harga_final`, `gambar_produk`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'lipstik wardah', 1, 11, 10000, 100000, NULL, 10000, 'produk/7lq7xALrUu42YiSH3244iSMSOp3guu7cgmaKEO07.jpg', NULL, '2025-06-15 19:24:42', '2025-06-15 19:32:06');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('0XnXqlqLyFmQLH0mvTt2Vlfc1gI8nHi9QYsk8O9U', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM1NZSm1RckFvWDZseklEZjFmREhwQ0FWaE1nbGpLTGZNSjNJNE5XSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040188),
('110OxE0QsmQaC7avlyDByNNCZuxR2tWcdKQDDrmh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic2V0b1NZWmFuUXhqTVg1ajJXNkV6MDVlVlJwNW1JUk5jV0g5S09FTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040032),
('1fjVItWq5ecH3WnSabtnxIa5aEKeXudpSIrgRbeQ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZ25jTXZVbnllRnVFU3cwdHZjQmtjZEQ5ZEF6ZWxLUnJ6d0NkbXQ3bCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040146),
('2wnxcYmCo3fzcj9ONP6KEMcGrkVGHgjz8jSRFihx', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjR1S2pVUldhMmc2Wk13UDhSd1RWeEFOb2tVQzgzOWtwVHVPaE4yYiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750041127),
('3ASQhYl5znr6uLlxg4IHpl5efReGW8edONhVQJrH', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDVVUHBkaFp0ZmtWRDJYYnNvUEtpemNHUzI1aFVrVzlxQzVEVkRMSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041115),
('3GBw46xT1uUppGpaUE0xbHPqmSlosHfhI9BlsHWF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieVR2UEpIazhKQWtSVGlxRmxqRXZUc2ZFUG44UnE2NkwyaFlIbng4byI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041245),
('4j2Fff7Sq9e2qy2HinPgwtXHJ5Z82mgSSI6U8h8z', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMXNwRUx6aXJNUU9wVzFUQ0ptYjNGWjF5NEdCWXhKNWVlVnBRTDBwOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040740),
('5kxwXJki3VXoWJkPkfWXUszOomFCcWTyZfqBMhiS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTm5yemVXQ1hTcWROOXJ1R3h3V1NCUFBxN09HUGNoRjNLNnY5SG1nSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040042),
('6eTh3j5SN8rC1O8bM1317Xvx9lpWoT8E9iT2UFZn', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibkV2RjVrVFJKR3JGM1ZLUWN5bjR1Z2JOcXplRTFPZDlib3FpZ3FuSCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040682),
('6RcahJfU6Vd6irso4H3S9fKyjlIh7reI5gLXPqI6', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibUx0bEFiSFhtYjNUY0s0bWU5S1RKYzY5TzJkZmJwMXdzcUZEOTBaayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040741),
('6VDVSpPh4mlTBi91fik7Y3vk3i4iTp6qxjmG5ome', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVEdEOXZvQWlzelRnMzZwVUJKV0NVbzdnS0hkYnlEVG1GN1JSNkZtSCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040742),
('83pxmFrMQSRE7r12aG1GlhYtXghiQK1uDrLql8CO', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTXNRMGozUk5JdHBVNTVYUzJRaGFUemVSMXQwbEthOTIzSFdUYlhQdyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040737),
('95LfJGtwVZJyS4xZqmY37lS5ARrmtVMBcEWZdHFL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXp2b215TkkxOWhKZXVXTmZibjVQSGJrczRTM0F3dGlQZGdZVFpReSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040385),
('9pFsqRN2b0mGBqKbU7tRq27565cDz09XWxNuXyhB', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiaUJUNjB0MlNGSU44UmhQc2NmeUc1SzJnZTgxYWYxaElyS25POG1LVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040384),
('9wbdqChQe5BplwBPQl5iXWhwSSEjH7xPFoUVo9HT', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDNxMWNWSlhicUI3d2ppUTVJZ3JpVDJueWExU3BFSWhEbVJhb0ptVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040565),
('a2iDUu7nrCBApZBMUY0IOw4y04XclXhtS9WeBPLp', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieVZuUHM5a2tUMzlJV2pvSGk0RUtKWTNRR0lnc1JGbXVPV3NQU2VMeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040187),
('aZyix40DqM4BwYNouPx1wFvuewrNHGjcxAUtUcmz', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGdkZFFpN1FhR0E0U3VadFhta05xQ2RsbEdEUFAyOHFwdnlPbDhCWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040125),
('BAdLHvZT5JGRCUJMl3cDQQDEiRYG3PNemYlZzPtL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY00zQmpZaWdOQlh0dWthRVFiYzZpOUVzVkFYWXhMd0lWQmpGWG5rZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040755),
('BSntMFIlz4VW39TVNhmE4f4wjoUQ8MMPa4fX9xUw', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidDJGVnFoUUVDRTRLSmsxUzIwVkhiZ0kzeFZKQ0VndkdqbHIzdUhXVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj03JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040769),
('CJS4Mh6YpquAslwjFbaCWUhaSJIdMplAnJQ6vVsg', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTU12d3lya254Z05hb0tWV05DN2pWYThKSVdtWlVmTENGdU1SWUE1QyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040735),
('cmkZf2LjDIWE3Ys1sLQBT9bHnhoTvEyRwiZ9PIeS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNnExTFFjYzdrd2lSb2FGcUVJUVUzQ2ZYdm1xSFgxRmRzNTVoTkdZWiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040145),
('d6fyMCY10T3Qy2EnDgwL1C3veMLMQXRYA3WqUQHa', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM0RwQzllRUg1Qms0MmxKWDBNZlBKMW1LVTE4aEluVDBKUmJCUGJzSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040032),
('ddiKDNG6eaQECLESNIhoNid2vbItijjiQsYFjqgz', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV3Z6VVFIOHVPS01EMzQxQmxBT1NadTZtRmtLM0pySXVrdk52UUlJRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040552),
('DYJPZLulJWQorW0af7hrsT4ZaXMbr5nXXMel5svx', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYnNMbTVoaEU4SUg1RVgwc3NTY2lNaE1RYk4xRk43b2VvbHV1b1VwSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040739),
('eYJTJgCSmIJ1KUmGav278s0QIBoEoPHChceU6Pqs', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiVjl3UDh6YUNNMzFHN1l4NjdTNTZLZm0xY1pVUXZHNE5FVGxDdklTMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040773),
('fFOclLJQhf5TmbnyBUHHP5tRMfBu7BZ9kWWX005D', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOG5TS2tyaEhlenpTWU1FWUw1a1E0a3NsRlJmWXBjSGRWWHF0ZXR5aSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040627),
('FFSGr1hz4XTALY18eEV9qJylDE9VtujjSbDOSl0d', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidWhKZjJqaHFQeTJRd3k3QktkWXo1eHYzbWpBOWUzUXNOcng4YkQ5WSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750039927),
('FrBOMt5WWDVHzhIdaa5xDBgBYA6BGtAL5kJyvVOm', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoib1YzaHRWVVpNSWVTOEt3TDhia1FwNkRYN3hxY1RZTWhCSlV3RTRTVSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040790),
('fWatoY0Hab80yMazqtwOFigvIGfiYqNdLLcM0EYV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVXFiSkRreFVmY1NiY01USE9ZNjhRYnhXVTN3cEtubmpxTDRlV3pINiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040711),
('G7N5WckYqGcaBUJWtUzSKY4HbsxYJfwuDtISRDbd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV0pGU2pSMDUyMU1PamZBV215ZUdHbnhDRDZwMEdQQmRvSzdwM3RtSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040042),
('hkfL4ArsLXDGPFSrJ4NADxHjuWHD9LynQIPYETdh', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVROc2FzZFdIUlQ1dGZFcmJsZ0hGUEF5bzJDUWMySTNRYjFnTjREMSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040711),
('HuWFYUAFBYgWaOo3bLIUBbLbluNAvhva87LRRF5w', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQkNhUDlGaGU5M25YYUNUcGlHb2d2M21MUDY0b29tVWZZYjVIQ3lvRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTg6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL3BkZj9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041254),
('i2Avu9RPK3jHfvZlQ2sAdSbkVglPd9yhJi8VXZcj', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiMWd5NHh3dlIzdXo1WlViVkdaZEFuU1g4TTY5VEJiQVpvVkhTUnVuTyI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040135),
('icY5Nr3U6ZQnRxFyDYtvmTNlG0GEaHeNlWDDBVqJ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNWhzd3VmNVp0T0VWWEtqOVg3YjR4cjNMeDZFcDBuUFNvRHFSTGNQUSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750041127),
('J4Styo0VfjypjO8zsFLUsIBjrKqBaJWOJ5llF4VA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMzJ5bEVWM1YxSHNVQ0VGcGJtMXQyNkF1NHlsaWVmNU9sMEw4VlFWWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040037),
('j6dnN7UfSfu6hJ9SzRyiVTDFxwdUZVw7GM3s46FG', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNE5GaVl4WHlyN3NYeTZyRVpkTXpXRWl0aUpER1BPdGFsd3NjUm41ZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040037),
('jax1qvFUHnAo54trPCz3ACfXsRl8m8k8znGEl726', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnpBRno3eFRieDdBaHFldUdqT3hzNmNkM2xOU1ZHblJxVklKV2cxVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj03JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041275),
('jbUi9ExGgsciLKslJtP1ZLcyGLg6litl3GrpEHJZ', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSENUbHlpRnNVY3NOOVJES0NHSDZPVVdFc0NOVHZxU21YNkVITGFHRSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040683),
('jgDh3qX8kr7AHZkSZxbJuzjC6CH987MAnw32d7ev', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUGhvbFk1RVNOczBrVTNZRk9OVWd6cHQxNWVGN2pBSmdlYkFYVGcxSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040773),
('JHboVZwat7yQW8VAMbH2q8Av13LPAPqrUT5z6DQC', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTVVYTWEybUVzb21zdFlhZ2RkRHVrdlVhaGt1N1hsMm95ODVnS2hsRyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039551),
('jQGBBMEh4kSrMyPXAhxRqc9DjSr6VVbsPO50Spal', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicG91UVNENHpOREwwU1M1cEdWRlV6b3pCVmlCMzROcWhMZjlHM1daVCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039806),
('jSOtGgaMxL9z2vsQkJsqsjTRNKpKWPmPDZkedPJH', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicWx0Y3RWeXJhTGRNS2ZsQndVYzllYzdKRVk1RWp0YXc3MDRvWmZBVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040740),
('JSs5EskjjIWRRfk9icrasjewC5VhJL4bcbdsYuLj', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMnVBZ09Ta1NFWFllRjZsakxpbzAyVkZHRXRjU1FOalRpWTFzQTNyeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040155),
('JyShPUp0s5xArua6NmKeP4O01ghpMxSIclcP8wCh', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiblRYcndNSUtHTDBKcWF3Mk90UG50TWhyZ2NoaHBHSWVpMnF0TGNSaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750038921),
('K0C7IH5CUvJFXMIRveSnuRLULlf6W3VOSZGeUQ9O', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNkEyaUVpck9aVVJUUWhFRHFwaXJydWRQU0I4cTlyUVdqRDdRZ1V5SyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040146),
('k7hqDAkiNIQcKC0n3z4V7zDiiio0c7pFy33HOvWE', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiN051Rkw3MkhxVEw5dDdvZ3pUbkRMZFJHQTBMajQ4Q0VFaUg4ZFRsTSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040772),
('kBtrFp54SGSvQ4GIdofPBZOBH8qA22XW78RBKLD5', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZEk4OWFuTDlKYXNGekF0V2ZQVklkdGdRN1RZNWY3RXI2N2pzYzVlTiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4va2FyeWF3YW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041292),
('kip59ahaWHlUJltWUTDjXyDkdUPYrhUlY4nypUC7', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicklCdWN3VGxMN0Y5NU1oSDNNR014dlFQVWFCRlBkQVhxbndGMWtZOCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750041114),
('kX0fVIXz0ZtBss43kmeByu1enSex3pOjKLrxZu9z', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiaDI0R0VzSEJhenFoOU9YbmtYcm1oVVBWZUcyVkVLbUh3VHJoejh4MSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040686),
('ll1gD9ugf4MHpKJ1se1CsdhphHw5fSKQgsbDziie', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicHlQbDdTdDdSOGR1Y2UwSW1za0R4REhEZXBOS3huYml1T1U4YTdTdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040755),
('lnjrllG0jSiUyaLNiYKar0ceuRBS7fejQT6YJu8n', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYXFJTWxWWEFJb0ZncWZHbjMxV1lVZzNGNTFtaFZLMTJkTkRWcERkaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039880),
('mSAxvh1lS4qguN1HesO0JrQlYfCrJmx6yS20sL2R', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSUtSQWdvR2l4TVhoZGhCTkppYUpzMDI4TkxwT3h4VkVBek5VZEtmbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750039927),
('ohThmRKXzlwFPXTUfMkla2PMKNs2woPY5UH4cZIn', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibWdSVWJiSHV5ZTdTSnQ0SmplczllUHA0TExiSHNyTENrZWM2UW0ycyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750039546),
('P4OARF5lhnEcRxRnbY5eBGppFBmomxYpQngRfqh9', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTmQ0THQycXhtVGdYaEpkMDNLc3BCVXBaNkpjYmRwNFZBMmZoZkR6SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041245),
('pg2NuEAxBnpEaIcsXbj8smEwCJ6c7qtNdZN9mf3o', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQjJ0RlhUZXR4MTl2Qmx3QXdmR29LZEF4Zm1aYncwQXZ0Q3ZUeUxZSiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040551),
('psAULL8pNEl766b2gBoSwmjDcWeHBai1OJjmbmNE', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoic1JTZXdQUGFVN0YzdE1oTXdsMnN0SjVCZVdtR1BaYWxlQTBSdVpseSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750039879),
('pyAeozlFwYhW5fceQZ1b4NzNY2iT8y0daWvLNPcU', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoieTQ5TVpDZksycVlKdTdLa29MVWRQZkRwQ3YwaHFDbVR6Vlc3bUJuQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750041114),
('qANj7FebuCzwhzTw2cPSQeBQhwXIDXAkO56fnUXv', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTTEyeVcwY2I2RWNGVXdzZnV3R21pamxYeHQ5aHB0ell5R0tEcDBrUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040127),
('QvNmEAufseYP5RnzuMGjQppmCClVMFggdbPYmGWL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNEF2WjB6dUFOc052WjlZZTExTDNjd2xOMm1tMFBzOHlJSnVEVElJSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040765),
('r3WBb6SPqCTnRdnp9s38Qs9XmW9n7bA7K7iehOg1', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRjhyWlhLaExqY1dOVlRkTVN6UHdlQmU4R2FrNTRESE1FaVpEOXJWZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040683),
('T2qZpEPR5SN1wE181mwZKSdPQkPJQufErLygZbk3', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiOXhBMk8wT2hVdHpJUk1ZbzNuclg4M3ZoQU5pZVg3dkNmMEp6NnVreSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040626),
('T2sQlp7X8LIVutqptOZ5jP50u4o7vBuwpnNIe7B4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiWmhYNzFDaTNVMDMyOGFPZG82MHloY2t1cW1Ed0h2bGdtOUNJaDc1MCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040385),
('T2xG4ZGg3GQeEaCHlV0ZAVZcRCboCtH3mxddSsZY', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiMDZURFNpUWVMNzFaUWtaVzl0N2NidmN5b0hGZ1dvTWw5V0pWUWx4MSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040563),
('TFW17aJog1bvxjSPFuQKykL4ymg3H3EMyHmamXCt', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSjNQYVN5NUI0a3hkMGxVdE9ONER2d05rUzYzMG1qNGVpV2ZpMDIzdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040564),
('tLkn5eEo5DLWfhQO2g7qRtBzJKAhmjfb5bdv1tUu', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidFdzazJSQzkxRm5pNHFOQVBDRVZmR1dqYmhFbUpUTmtUOWdrVkVCWSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040551),
('tvCA2gi3HE6jd8UqMIpQJAXF3uzkndilUZt1HFMD', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidmpFNlQ1bElxbXdlb3g4bnBZaU44MGthbllVR1ZKS2hYTGk4Z01XQSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039551),
('u2XhK7g8pvQVjzBoqvhNLeJuCqUrLwCdU3oiv73C', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiS3NYU2thSG1TRXBzZ25jMVRKaDM0RmRvbzBmbnU3aHFZUkpWdTVRSSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750041287),
('ub9ExSwPWprx9J64UOvDv1qFAxP0C9I5NhivfQ9A', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiVFlBeFp2QWRrS0x2RlhuU0dQaDN5UExzVlpBZEtWUFdBTFRFenJFbCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750041126),
('ujck50bSn58zBVIZuZQdTI9NzOwe6gDz0c6RCHKC', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiYm9qNDYyZXNXRWJaT0VXM21DZHphbzROc0c1TG5CcmJ2TjFBMUVJbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040154),
('UYomoWflbMXF1HzastPnaExKrcoYVUhR4MaMbb3q', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiZGZlNjNZSTB6TFphOVNGdlRDWWZlZG5YczVDNWdrTGRWY0NUdUhIeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040562),
('VCEqbTHhPPqMIHUPXVd8jIExYEdG2TKm3rvBNgPl', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRzlSN1dFN3VhZVgxRThnNW9RRGw1RjgwRnJkQTVlUHVqeEZWYWJRVyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040779),
('W3eYXjvMhEbJVt9eFcNf1R0P5orVQU39Tjt3S3DD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiREFRQXkxNWthaUZveFM2cWtSenJlaWZEU05tcFVZQmR4WHZ6N3hvMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040770),
('wjOf3EBMMwAk8FEucDWll5aj6GcNyinTFm5jHOyJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiSnRsV0NuVXJPdEJYZXpybnB5b1ZVbDdNZWd5a01reENCM09reG5nSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj00JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041280),
('x3a06CthaDKVUkIoVzYbinCq8uA0RRisTN72Popx', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTmVMbEt2VW1MUkpqSENpSTNZYktZanJIdXoxeWhBbW92Z1VQbWV1aiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvdHJhbnNha3NpIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040552),
('X5kod4alIsqbmQMZImRr8ZDfhQizb20d84SCm7W4', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoidG8xOVhVRjRWa0x6SEJoeUx3aFg3S0JudG1iUWh2NVpOcmFMOXIySyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzI6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvcHJvZHVrIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039878),
('Xf7tkqVHUfb7LAFapo6Sw5Dukbrjy6LCiMunuJEM', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibExUN1k0cWRFMVJnVk1EYXM4VjdhV3lTT1pZb3FMMU11S2c3ZmNNQyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040561),
('XS4e2LjFEtYblHuvNuJOYEvA4S21StfA4ZLubOUc', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoibHNEbUViSFJUdmM1dUp2VkVlU0ZzSjJ6YnEwdUJ0MTBOOG5POElEVCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750038928),
('Yb5wmXU4rZvlZneGliQBBNNz3v68NYpTTvvvWw7X', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiU0dJQ0p3QzVXQTh2a3VQbE5JMlBjcVBwdFVGa1NaN3BLRmNEUVNmeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvYWRtaW4vcGVtYmVsaWFuIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039553),
('yiC16z7soUjWiMI8i2Vk66nZr1MUY2lT6Y2ulccJ', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQ0xJZXl2eVdLcnRZa2dHV2JiUGtSR0wzUmRTQWpBbHY2QWtWZHhWaSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040127),
('yjcfcPaVCCTgEDQ95YlmRGp32PefYSdGUgTUgfqA', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiR1dGMmhmTWptTFhtcGF6VGo2Y203RUJ2TFJEc25SSmNwb1BhN3NOciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750040764),
('yMU9EDzX65ONtcY4IARdSFpHiS9qYUrXLIjgLvOI', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoic1VMN0R1RzlKbFRSczFWWGhxWEpvWG8zdkZoVlMxVmZDd2RPREswdCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750040350),
('yVs2TAAKHqX7O7q9pHEQJqa6o54nYVvTPX8p29J4', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNlpLbkprZ0Uzc0Yyc1JIeTJSSGhNQUV1MGVBOHdPbkI1eXp5TVZBYSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750039546),
('Z8xbjHq7MuWLqeu6e26LVfVOualFfwZlgENSuzu3', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiNm1pc2NXYXkyYXdxeDVzWnU0Q1FiOWp3eENqNXkybGV4SHRuSHB6NSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1750039545),
('ZND4BWhAMuCqPz7ALrONjCyC8TokZYeUmo3SBeKA', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiem1ueVRkMW1WMlA5akcxTEtoRDRYeVJkZ0tCV0QzREJTd2wyZVlyUiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkva2F0ZWdvcmkiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750039552),
('zsk3igcFvBtqqu8Fe7mJffxecGUOWhr9lmixsWJD', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36 Edg/137.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiY1lyRUlnUWlWcjQ5YU4xelltRWJzZDQ1bW9QT2RpY0JsT09SRzR6UiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjQ6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9hcGkvZGFzaGJvYXJkL2FuYWx5dGljcz9idWxhbj02JnRhaHVuPTIwMjUiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1750041282);

-- --------------------------------------------------------

--
-- Table structure for table `transaksi`
--

CREATE TABLE `transaksi` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `users_id` bigint(20) UNSIGNED NOT NULL,
  `total_harga` int(11) NOT NULL,
  `final_amount` int(11) NOT NULL,
  `metode_pembayaran_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id`, `users_id`, `total_harga`, `final_amount`, `metode_pembayaran_id`, `created_at`, `updated_at`) VALUES
(1, 1, 10000, 10000, 1, '2025-06-15 19:32:06', '2025-06-15 19:32:06');

-- --------------------------------------------------------

--
-- Table structure for table `transaksi_item`
--

CREATE TABLE `transaksi_item` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `transaksi_id` bigint(20) UNSIGNED NOT NULL,
  `produk_id` bigint(20) UNSIGNED NOT NULL,
  `jumlah` int(11) NOT NULL,
  `subtotal` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaksi_item`
--

INSERT INTO `transaksi_item` (`id`, `transaksi_id`, `produk_id`, `jumlah`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 10000, '2025-06-15 19:32:06', '2025-06-15 19:32:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nama_lengkap` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `profile_picture` varchar(255) NOT NULL DEFAULT 'default.jpg',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('Admin','Karyawan') NOT NULL DEFAULT 'Karyawan',
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `nama_lengkap`, `username`, `email`, `profile_picture`, `email_verified_at`, `password`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin', 'admin@test.mail', 'default.jpg', NULL, '$2y$12$zigSD7M0zg.zauYIH.7D1.L3pHHD8nnBDy6nxoK.uJQ2UFqIdQqKG', 'Admin', NULL, '2025-06-15 18:57:38', '2025-06-15 18:57:38'),
(2, 'Karyawan', 'karyawan', 'karyawan@test.mail', 'default.jpg', NULL, '$2y$12$fCxPRxG.yQEHS.lpZFTXNeZXVDyHMQYtO7CQC/Ith3AucfBZr46Aa', 'Karyawan', NULL, '2025-06-15 18:57:38', '2025-06-15 18:57:38');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `kategori_nama_kategori_unique` (`nama_kategori`);

--
-- Indexes for table `metode_pembayaran`
--
ALTER TABLE `metode_pembayaran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `metode_pembayaran_nama_unique` (`nama`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `pembelian_produk_id_foreign` (`produk_id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `produk_nama_produk_unique` (`nama_produk`),
  ADD KEY `produk_kategori_id_foreign` (`kategori_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_users_id_foreign` (`users_id`),
  ADD KEY `transaksi_metode_pembayaran_id_foreign` (`metode_pembayaran_id`);

--
-- Indexes for table `transaksi_item`
--
ALTER TABLE `transaksi_item`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaksi_item_transaksi_id_foreign` (`transaksi_id`),
  ADD KEY `transaksi_item_produk_id_foreign` (`produk_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `metode_pembayaran`
--
ALTER TABLE `metode_pembayaran`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pembelian`
--
ALTER TABLE `pembelian`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaksi`
--
ALTER TABLE `transaksi`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transaksi_item`
--
ALTER TABLE `transaksi_item`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `pembelian`
--
ALTER TABLE `pembelian`
  ADD CONSTRAINT `pembelian_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_kategori_id_foreign` FOREIGN KEY (`kategori_id`) REFERENCES `kategori` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaksi`
--
ALTER TABLE `transaksi`
  ADD CONSTRAINT `transaksi_metode_pembayaran_id_foreign` FOREIGN KEY (`metode_pembayaran_id`) REFERENCES `metode_pembayaran` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaksi_users_id_foreign` FOREIGN KEY (`users_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transaksi_item`
--
ALTER TABLE `transaksi_item`
  ADD CONSTRAINT `transaksi_item_produk_id_foreign` FOREIGN KEY (`produk_id`) REFERENCES `produk` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transaksi_item_transaksi_id_foreign` FOREIGN KEY (`transaksi_id`) REFERENCES `transaksi` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
