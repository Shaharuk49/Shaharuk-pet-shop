-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 26, 2024 at 08:55 AM
-- Server version: 8.0.30
-- PHP Version: 8.2.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_commerce_project`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'home',
  `isdefault` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `user_id`, `name`, `phone`, `locality`, `address`, `city`, `state`, `country`, `landmark`, `zip`, `type`, `isdefault`, `created_at`, `updated_at`) VALUES
(1, 1, 'Ayesha Rahman', '01712345678', 'Road-5, Banani', 'House-23, Building-A', 'Dhaka', 'Dhaka', 'Bangladesh', 'Near Banani Police Station', '1212', 'home', 1, '2024-11-25 15:29:07', '2024-11-25 15:29:07'),
(2, 2, 'Ayesha Akter', '01822345678', 'Road 5, Dhanmondi', 'House 12, Sunny Tower', 'Dhaka', 'Dhaka', 'Bangladesh', 'Near Dhanmondi Lake', '1216', 'home', 1, '2024-11-26 02:19:19', '2024-11-26 02:19:19'),
(3, 3, 'Tanvir Ahmed', '01633456789', 'Agrabad Commercial Area', 'Flat B2, Orchid Residency', 'Chattogram', 'Chattogram', 'Bangladesh', 'Beside Agrabad Bus Stand', '4000', 'home', 1, '2024-11-26 02:23:35', '2024-11-26 02:23:35'),
(4, 4, 'Nusrat Jahan NIla', '01544567890', 'Nirala Residential Area', 'House 7, Green Villa', 'Khulna', 'Khulna', 'Bangladesh', 'Near Nirala Park', '7400', 'home', 1, '2024-11-26 02:25:49', '2024-11-26 02:33:27');

-- --------------------------------------------------------

--
-- Table structure for table `brands`
--

CREATE TABLE `brands` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `brands`
--

INSERT INTO `brands` (`id`, `name`, `slug`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Aarong', 'aarong', '1732564642.png', '2024-11-25 13:57:23', '2024-11-25 13:59:46'),
(2, 'Apex Shoes', 'apex-shoes', '1732564711.png', '2024-11-25 13:58:31', '2024-11-25 13:58:31'),
(3, 'Walton Electronics', 'walton-electronics', '1732564773.jpg', '2024-11-25 13:59:33', '2024-11-25 13:59:33'),
(4, 'Infinity', 'infinity', '1732564816.png', '2024-11-25 14:00:17', '2024-11-25 14:00:17'),
(5, 'Apple Store', 'apple-store', '1732564959.jpg', '2024-11-25 14:02:39', '2024-11-25 14:02:39'),
(6, 'Bengal Meat', 'bengal-meat', '1732565003.jpg', '2024-11-25 14:03:23', '2024-11-25 14:03:23'),
(7, 'Square', 'square', '1732565052.png', '2024-11-25 14:04:12', '2024-11-25 14:04:12'),
(8, 'Unilever', 'unilever', '1732565101.png', '2024-11-25 14:05:01', '2024-11-25 14:05:01'),
(9, 'Bata', 'bata', '1732565134.png', '2024-11-25 14:05:34', '2024-11-25 14:05:34'),
(10, 'Samsung', 'samsung', '1732565251.png', '2024-11-25 14:07:31', '2024-11-25 14:07:31'),
(11, 'Emil Choice', 'emil-choice', '1732565349.jpg', '2024-11-25 14:09:10', '2024-11-25 14:09:10');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `image`, `parent_id`, `created_at`, `updated_at`) VALUES
(1, 'Men’s Fashion', 'mens-fashion', '1732565564.jpg', NULL, '2024-11-25 14:12:44', '2024-11-25 14:12:44'),
(2, 'Women’s Fashion', 'womens-fashion', '1732565609.jpg', NULL, '2024-11-25 14:13:29', '2024-11-25 14:13:29'),
(3, 'Kids\' Clothing', 'kids-clothing', '1732565652.jpg', NULL, '2024-11-25 14:14:12', '2024-11-25 14:14:12'),
(4, 'Shoes & Footwear', 'shoes-footwear', '1732565696.jpg', NULL, '2024-11-25 14:14:56', '2024-11-25 14:14:56'),
(5, 'Accessories', 'accessories', '1732565753.jpg', NULL, '2024-11-25 14:15:53', '2024-11-25 14:15:53'),
(6, 'Gadgets & Electronics', 'gadgets-electronics', '1732565828.jpg', NULL, '2024-11-25 14:17:08', '2024-11-25 14:17:08'),
(7, 'Home Appliances', 'home-appliances', '1732565867.jpg', NULL, '2024-11-25 14:17:47', '2024-11-25 14:17:47'),
(8, 'Beauty & Skincare', 'beauty-skincare', '1732565902.jpg', NULL, '2024-11-25 14:18:22', '2024-11-25 14:18:22'),
(9, 'Health & Wellness', 'health-wellness', '1732565934.jpg', NULL, '2024-11-25 14:18:54', '2024-11-25 14:18:54'),
(10, 'Books & Stationery', 'books-stationery', '1732565967.jpg', NULL, '2024-11-25 14:19:27', '2024-11-25 14:19:27'),
(11, 'Toys & Games', 'toys-games', '1732565993.jpg', NULL, '2024-11-25 14:19:53', '2024-11-25 14:19:53'),
(12, 'Groceries & Snacks', 'groceries-snacks', '1732566047.jpg', NULL, '2024-11-25 14:20:47', '2024-11-25 14:20:47'),
(13, 'Furniture & Home Decor', 'furniture-home-decor', '1732566071.jpg', NULL, '2024-11-25 14:21:11', '2024-11-25 14:21:11');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `comment` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`, `comment`, `created_at`, `updated_at`) VALUES
(1, 'Kamal Hossain', 'kamal.hossain@live.com', '01955678901', 'User\r\n\r\nName: Md. Rahim Uddin\r\nEmail Address: rahimuddin@gmail.com\r\nMobile: 01711234567\r\nPassword: Rahim@123\r\nConfirm Password: Rahim@123\r\n\r\nName: Ayesha Akter\r\nEmail Address: ayesha.akter@hotmail.com\r\nMobile: 01822345678\r\nPassword: Ayesha@2024\r\nConfirm Password: Ayesha@2024\r\n\r\nName: Tanvir Ahmed\r\nEmail Address: tanvir.bd@yahoo.com\r\nMobile: 01633456789\r\nPassword: Tanvir#987\r\nConfirm Password: Tanvir#987\r\n\r\nName: Nusrat Jahan\r\nEmail Address: nusrat.jahan@gmail.com\r\nMobile: 01544567890\r\nPassword: Nusrat_567\r\nConfirm Password: Nusrat_567\r\n\r\nName: Kamal Hossain\r\nEmail Address: kamal.hossain@live.com\r\nMobile: 01955678901\r\nPassword: Kamal@786\r\nConfirm Password: Kamal@786\r\n\r\n\r\nAdmin', '2024-11-25 13:39:36', '2024-11-25 13:39:36'),
(2, 'Md. Rahim Uddin', 'rahimuddin@gmail.com', '01711234567', 'User\r\n\r\nName: Md. Rahim Uddin\r\nEmail Address: rahimuddin@gmail.com\r\nMobile: 01711234567\r\nPassword: Rahim@123\r\nConfirm Password: Rahim@123\r\n\r\nName: Ayesha Akter\r\nEmail Address: ayesha.akter@hotmail.com\r\nMobile: 01822345678\r\nPassword: Ayesha@2024\r\nConfirm Password: Ayesha@2024\r\n\r\nName: Tanvir Ahmed\r\nEmail Address: tanvir.bd@yahoo.com\r\nMobile: 01633456789\r\nPassword: Tanvir#987\r\nConfirm Password: Tanvir#987\r\n\r\nName: Nusrat Jahan\r\nEmail Address: nusrat.jahan@gmail.com\r\nMobile: 01544567890\r\nPassword: Nusrat_567\r\nConfirm Password: Nusrat_567\r\n\r\nName: Kamal Hossain\r\nEmail Address: kamal.hossain@live.com\r\nMobile: 01955678901\r\nPassword: Kamal@786\r\nConfirm Password: Kamal@786\r\n\r\n\r\nAdmin', '2024-11-25 13:40:55', '2024-11-25 13:40:55'),
(3, 'Ayesha Akter', 'ayesha.akter@hotmail.com', '01822345678', 'User\r\n\r\nName: Md. Rahim Uddin\r\nEmail Address: rahimuddin@gmail.com\r\nMobile: 01711234567\r\nPassword: Rahim@123\r\nConfirm Password: Rahim@123\r\n\r\nName: Ayesha Akter\r\nEmail Address: ayesha.akter@hotmail.com\r\nMobile: 01822345678\r\nPassword: Ayesha@2024\r\nConfirm Password: Ayesha@2024\r\n\r\nName: Tanvir Ahmed\r\nEmail Address: tanvir.bd@yahoo.com\r\nMobile: 01633456789\r\nPassword: Tanvir#987\r\nConfirm Password: Tanvir#987\r\n\r\nName: Nusrat Jahan\r\nEmail Address: nusrat.jahan@gmail.com\r\nMobile: 01544567890\r\nPassword: Nusrat_567\r\nConfirm Password: Nusrat_567\r\n\r\nName: Kamal Hossain\r\nEmail Address: kamal.hossain@live.com\r\nMobile: 01955678901\r\nPassword: Kamal@786\r\nConfirm Password: Kamal@786\r\n\r\n\r\nAdmin', '2024-11-25 13:41:41', '2024-11-25 13:41:41'),
(4, 'Tanvir Ahmed', 'tanvir.bd@yahoo.com', '01633456789', 'User\r\n\r\nName: Md. Rahim Uddin\r\nEmail Address: rahimuddin@gmail.com\r\nMobile: 01711234567\r\nPassword: Rahim@123\r\nConfirm Password: Rahim@123\r\n\r\nName: Ayesha Akter\r\nEmail Address: ayesha.akter@hotmail.com\r\nMobile: 01822345678\r\nPassword: Ayesha@2024\r\nConfirm Password: Ayesha@2024\r\n\r\nName: Tanvir Ahmed\r\nEmail Address: tanvir.bd@yahoo.com\r\nMobile: 01633456789\r\nPassword: Tanvir#987\r\nConfirm Password: Tanvir#987\r\n\r\nName: Nusrat Jahan\r\nEmail Address: nusrat.jahan@gmail.com\r\nMobile: 01544567890\r\nPassword: Nusrat_567\r\nConfirm Password: Nusrat_567\r\n\r\nName: Kamal Hossain\r\nEmail Address: kamal.hossain@live.com\r\nMobile: 01955678901\r\nPassword: Kamal@786\r\nConfirm Password: Kamal@786\r\n\r\n\r\nAdmin', '2024-11-25 13:42:34', '2024-11-25 13:42:34'),
(5, 'Nusrat Jahan', 'nusrat.jahan@gmail.com', '01544567890', 'User\r\n\r\nName: Md. Rahim Uddin\r\nEmail Address: rahimuddin@gmail.com\r\nMobile: 01711234567\r\nPassword: Rahim@123\r\nConfirm Password: Rahim@123\r\n\r\nName: Ayesha Akter\r\nEmail Address: ayesha.akter@hotmail.com\r\nMobile: 01822345678\r\nPassword: Ayesha@2024\r\nConfirm Password: Ayesha@2024\r\n\r\nName: Tanvir Ahmed\r\nEmail Address: tanvir.bd@yahoo.com\r\nMobile: 01633456789\r\nPassword: Tanvir#987\r\nConfirm Password: Tanvir#987\r\n\r\nName: Nusrat Jahan\r\nEmail Address: nusrat.jahan@gmail.com\r\nMobile: 01544567890\r\nPassword: Nusrat_567\r\nConfirm Password: Nusrat_567\r\n\r\nName: Kamal Hossain\r\nEmail Address: kamal.hossain@live.com\r\nMobile: 01955678901\r\nPassword: Kamal@786\r\nConfirm Password: Kamal@786\r\n\r\n\r\nAdmin', '2024-11-25 13:43:17', '2024-11-25 13:43:17');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint UNSIGNED NOT NULL,
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` enum('fixed','percent') COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` decimal(8,2) NOT NULL,
  `cart_value` decimal(8,2) NOT NULL,
  `expiry_date` date NOT NULL DEFAULT (cast(now() as date)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `code`, `type`, `value`, `cart_value`, `expiry_date`, `created_at`, `updated_at`) VALUES
(2, 'SAVE100', 'fixed', '100.00', '1000.00', '2024-12-26', '2024-11-26 02:09:06', '2024-11-26 02:09:06'),
(3, 'FESTIVE20', 'percent', '20.00', '500.00', '2024-12-27', '2024-11-26 02:09:47', '2024-11-26 02:09:47'),
(4, 'FREESHIP', 'fixed', '100.00', '1500.00', '2024-12-27', '2024-11-26 02:10:18', '2024-11-26 02:10:18'),
(5, 'NEWYEAR50', 'fixed', '500.00', '1000.00', '2024-12-27', '2024-11-26 02:10:47', '2024-11-26 02:10:47'),
(6, 'MEGA25', 'percent', '20.00', '10000.00', '2024-12-28', '2024-11-26 02:11:07', '2024-11-26 02:11:07');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint UNSIGNED NOT NULL,
  `queue` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_09_22_094908_create_brands_table', 1),
(5, '2024_10_12_113506_create_categories_table', 1),
(6, '2024_10_12_171611_create_products_table', 1),
(7, '2024_10_16_062456_create_coupons_table', 1),
(8, '2024_11_22_111959_create_orders_table', 1),
(9, '2024_11_22_112020_create_oder_items_table', 1),
(10, '2024_11_22_112039_create_addresses_table', 1),
(11, '2024_11_22_112058_create_transactions_table', 1),
(12, '2024_11_23_184642_create_slides_table', 1),
(13, '2024_11_24_192402_create_month_names_table', 1),
(14, '2024_11_24_211813_create_contacts_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `month_names`
--

CREATE TABLE `month_names` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `month_names`
--

INSERT INTO `month_names` (`id`, `name`) VALUES
(1, 'January'),
(2, 'February'),
(3, 'March'),
(4, 'April'),
(5, 'May'),
(6, 'June'),
(7, 'July'),
(8, 'August'),
(9, 'September'),
(10, 'October'),
(11, 'November'),
(12, 'December');

-- --------------------------------------------------------

--
-- Table structure for table `oder_items`
--

CREATE TABLE `oder_items` (
  `id` bigint UNSIGNED NOT NULL,
  `product_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `price` decimal(8,2) NOT NULL,
  `quantity` int NOT NULL,
  `options` longtext COLLATE utf8mb4_unicode_ci,
  `rstatus` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oder_items`
--

INSERT INTO `oder_items` (`id`, `product_id`, `order_id`, `price`, `quantity`, `options`, `rstatus`, `created_at`, `updated_at`) VALUES
(1, 12, 1, '400.00', 1, NULL, 0, '2024-11-25 15:29:07', '2024-11-25 15:29:07'),
(2, 12, 2, '400.00', 1, NULL, 0, '2024-11-26 02:19:19', '2024-11-26 02:19:19'),
(3, 11, 2, '1800.00', 1, NULL, 0, '2024-11-26 02:19:19', '2024-11-26 02:19:19'),
(4, 10, 2, '380.00', 1, NULL, 0, '2024-11-26 02:19:19', '2024-11-26 02:19:19'),
(5, 12, 3, '400.00', 1, NULL, 0, '2024-11-26 02:19:40', '2024-11-26 02:19:40'),
(6, 7, 4, '4500.00', 1, NULL, 0, '2024-11-26 02:20:32', '2024-11-26 02:20:32'),
(7, 11, 5, '1800.00', 3, NULL, 0, '2024-11-26 02:23:35', '2024-11-26 02:23:35'),
(8, 8, 6, '3480.00', 3, NULL, 0, '2024-11-26 02:25:49', '2024-11-26 02:25:49'),
(9, 7, 6, '4500.00', 1, NULL, 0, '2024-11-26 02:25:49', '2024-11-26 02:25:49'),
(10, 8, 7, '3480.00', 6, NULL, 0, '2024-11-26 02:26:33', '2024-11-26 02:26:33');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `subtotal` decimal(8,2) NOT NULL,
  `discount` decimal(8,2) NOT NULL DEFAULT '0.00',
  `tax` decimal(8,2) NOT NULL,
  `total` decimal(8,2) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locality` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `landmark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `zip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'home',
  `status` enum('ordered','delivered','canceled') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ordered',
  `is_shipping_different` tinyint(1) NOT NULL DEFAULT '0',
  `delivered_date` date DEFAULT NULL,
  `canceled_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `subtotal`, `discount`, `tax`, `total`, `name`, `phone`, `locality`, `address`, `city`, `state`, `country`, `landmark`, `zip`, `type`, `status`, `is_shipping_different`, `delivered_date`, `canceled_date`, `created_at`, `updated_at`) VALUES
(1, 1, '400.00', '0.00', '40.00', '440.00', 'Ayesha Rahman', '01712345678', 'Road-5, Banani', 'House-23, Building-A', 'Dhaka', 'Dhaka', 'Bangladesh', 'Near Banani Police Station', '1212', 'home', 'ordered', 0, NULL, NULL, '2024-11-25 15:29:07', '2024-11-25 15:29:07'),
(2, 2, '2064.00', '516.00', '206.40', '2270.40', 'Ayesha Akter', '01822345678', 'Road 5, Dhanmondi', 'House 12, Sunny Tower', 'Dhaka', 'Dhaka', 'Bangladesh', 'Near Dhanmondi Lake', '1216', 'home', 'ordered', 0, NULL, NULL, '2024-11-26 02:19:19', '2024-11-26 02:19:19'),
(3, 2, '400.00', '0.00', '40.00', '440.00', 'Ayesha Akter', '01822345678', 'Road 5, Dhanmondi', 'House 12, Sunny Tower', 'Dhaka', 'Dhaka', 'Bangladesh', 'Near Dhanmondi Lake', '1216', 'home', 'canceled', 0, NULL, '2024-11-26', '2024-11-26 02:19:40', '2024-11-26 02:19:57'),
(4, 2, '4400.00', '100.00', '440.00', '4840.00', 'Ayesha Akter', '01822345678', 'Road 5, Dhanmondi', 'House 12, Sunny Tower', 'Dhaka', 'Dhaka', 'Bangladesh', 'Near Dhanmondi Lake', '1216', 'home', 'delivered', 0, '2024-11-26', NULL, '2024-11-26 02:20:32', '2024-11-26 02:20:51'),
(5, 3, '5400.00', '0.00', '540.00', '5940.00', 'Tanvir Ahmed', '01633456789', 'Agrabad Commercial Area', 'Flat B2, Orchid Residency', 'Chattogram', 'Chattogram', 'Bangladesh', 'Beside Agrabad Bus Stand', '4000', 'home', 'ordered', 0, NULL, NULL, '2024-11-26 02:23:35', '2024-11-26 02:23:35'),
(6, 4, '14940.00', '0.00', '1494.00', '16434.00', 'Nusrat Jahan', '01544567890', 'Nirala Residential Area', 'House 7, Green Villa', 'Khulna', 'Khulna', 'Bangladesh', 'Near Nirala Park', '7400', 'home', 'ordered', 0, NULL, NULL, '2024-11-26 02:25:49', '2024-11-26 02:25:49'),
(7, 4, '16704.00', '4176.00', '1670.40', '18374.40', 'Nusrat Jahan', '01544567890', 'Nirala Residential Area', 'House 7, Green Villa', 'Khulna', 'Khulna', 'Bangladesh', 'Near Nirala Park', '7400', 'home', 'ordered', 0, NULL, NULL, '2024-11-26 02:26:33', '2024-11-26 02:26:33');

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `regular_price` decimal(8,2) NOT NULL,
  `sale_price` decimal(8,2) DEFAULT NULL,
  `SKU` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock_status` enum('instock','outofstock') COLLATE utf8mb4_unicode_ci NOT NULL,
  `featured` tinyint(1) NOT NULL DEFAULT '0',
  `quantity` int UNSIGNED NOT NULL DEFAULT '10',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `images` text COLLATE utf8mb4_unicode_ci,
  `category_id` bigint UNSIGNED DEFAULT NULL,
  `brand_id` bigint UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `slug`, `short_description`, `description`, `regular_price`, `sale_price`, `SKU`, `stock_status`, `featured`, `quantity`, `image`, `images`, `category_id`, `brand_id`, `created_at`, `updated_at`) VALUES
(1, 'Classic Cotton Shirt', 'classic-cotton-shirt', 'Comfortable and stylish cotton shirt for everyday use.', 'This breathable cotton shirt is perfect for casual outings and office wear. It offers a regular fit with a clean and timeless design.', '850.00', '750.00', 'MFSHIRT001', 'instock', 1, 50, '1732567037.jpg', '1732567037-1.png,1732567037-2.jpg,1732567037-3.png', 1, 4, '2024-11-25 14:37:18', '2024-11-25 14:37:18'),
(2, 'Slim Fit Jeans', 'slim-fit-jeans', 'Durable slim-fit jeans, perfect for casual outings.', 'Crafted with high-quality denim, these slim-fit jeans provide comfort and style. Perfect for pairing with t-shirts or casual shirts.', '1200.00', '1000.00', 'MFJEANS002', 'instock', 1, 40, '1732567193.jpg', '1732567193-1.jpg,1732567193-2.jpg,1732567193-3.jpg', 1, 9, '2024-11-25 14:39:54', '2024-11-25 14:39:54'),
(3, 'Formal Leather Belt', 'formal-leather-belt', 'Premium leather belt for formal wear.', 'Made with 100% genuine leather, this belt adds sophistication to your formal attire. Adjustable buckle for a perfect fit.', '600.00', '550.00', 'MFBELT003', 'instock', 0, 30, '1732567357.jpg', '1732567357-1.jpg', 1, 2, '2024-11-25 14:42:37', '2024-11-25 14:42:37'),
(4, 'Polo T-shirt', 'polo-t-shirt', 'Casual polo t-shirt for a relaxed look.', 'This high-quality polo t-shirt offers a soft texture and a smart casual look. Available in multiple colors.', '900.00', '820.00', 'MFPOL005', 'instock', 0, 60, '1732567485.jpg', '1732567485-1.jpg', 1, 1, '2024-11-25 14:44:45', '2024-11-25 14:44:45'),
(5, 'Embroidered Silk Saree', 'embroidered-silk-saree', 'Luxurious silk saree with intricate embroidery.', 'Perfect for weddings and special occasions, this silk saree features hand-embroidered patterns for a regal look.', '3500.00', '3200.00', 'WFSAREE006', 'instock', 1, 25, '1732567613.jpg', '1732567613-1.jpg,1732567613-2.jpg', 2, 1, '2024-11-25 14:46:54', '2024-11-25 14:46:54'),
(6, 'Floral Print Kurti', 'floral-print-kurti', 'Comfortable kurti with a stylish floral design.', 'Made with lightweight fabric, this kurti combines comfort and elegance, making it suitable for daily wear or festive occasions.', '1200.00', '1180.00', 'WFKURTI007', 'instock', 0, 33, '1732567780.jpg', '1732567780-1.jpg,1732567780-2.jpg', 2, 11, '2024-11-25 14:49:40', '2024-11-25 14:49:40'),
(7, 'Smart Fitness Watch', 'smart-fitness-watch', 'Fitness tracker with advanced health monitoring features.', 'Track your heart rate, sleep patterns, and fitness goals with this sleek smartwatch. Compatible with Android and iOS devices.', '4500.00', '4500.00', 'GESW009', 'instock', 1, 15, '1732567935.jpg', '1732567935-1.jpg,1732567935-2.jpg,1732567935-3.jpg', 6, 10, '2024-11-25 14:52:16', '2024-11-25 14:52:16'),
(8, 'Wireless Earbuds', 'wireless-earbuds', 'Compact, noise-canceling earbuds for music on the go.', 'Experience crystal-clear sound with these wireless earbuds. Features include active noise cancellation and long battery life.', '3500.00', '3480.00', 'GEWEB010', 'instock', 0, 30, '1732568057.jpg', '1732568057-1.jpg,1732568057-2.jpg', 6, 5, '2024-11-25 14:54:17', '2024-11-25 14:54:17'),
(9, 'Casual Slip-On Sneakers', 'casual-slip-on-sneakers', 'Comfortable slip-on sneakers for daily wear.', 'Designed for convenience, these slip-on sneakers offer a snug fit and casual vibe, suitable for everyday use.', '1200.00', '1199.00', 'SFSS012', 'instock', 1, 100, '1732568156.jpg', '1732568156-1.jpg,1732568156-2.jpg', 4, 9, '2024-11-25 14:55:56', '2024-11-25 14:55:56'),
(10, 'Wooden Coffee Table', 'wooden-coffee-table', 'Stylish wooden coffee table for modern living spaces.', 'This minimalist coffee table features a sturdy wooden top and modern design, ideal for enhancing any living room.', '4000.00', '380.00', 'FHTCT013', 'instock', 0, 15, '1732568378.jpg', '1732568378-1.jpg,1732568378-2.jpg', 13, 7, '2024-11-25 14:59:39', '2024-11-25 14:59:39'),
(11, 'Luxury Skincare Set', 'luxury-skincare-set', 'Complete skincare set for a glowing complexion.', 'This set includes cleanser, moisturizer, and serum to rejuvenate your skin. Suitable for all skin types.', '2000.00', '1800.00', 'BSSK015', 'outofstock', 1, 85, '1732568533.jpg', '1732568533-1.jpg,1732568533-2.jpg,1732568533-3.jpg', 8, 8, '2024-11-25 15:02:14', '2024-11-26 02:34:34'),
(12, 'Baby Cotton Romper', 'baby-cotton-romper', 'Soft and breathable cotton romper for babies.', 'Made from 100% cotton, this romper is gentle on the baby\'s skin, offering comfort and ease for daily wear.', '450.00', '400.00', 'KCR022', 'instock', 1, 60, '1732568725.jpg', '1732568725-1.jpg,1732568725-2.jpg', 3, 11, '2024-11-25 15:05:25', '2024-11-26 02:38:51'),
(13, 'Giter', 'giter', 'PL', 'PL', '100.00', '99.00', 'THMA', 'instock', 1, 1, '1732610242.jpg', '1732610242-1.jpg', 6, 11, '2024-11-26 02:37:25', '2024-11-26 02:37:25');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('hUmSME4IXZNbSbCvYhtpmxAAYNI3fCmdr4J0rIyv', 4, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:132.0) Gecko/20100101 Firefox/132.0', 'YTo3OntzOjY6Il90b2tlbiI7czo0MDoiRGpUUHlCUnQ2QmlmVWVGODhBVFZTdHpwY3Fad0RvVW9EcDMxcEJHViI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hYm91dCI7fXM6NDoiY2FydCI7YToxOntzOjQ6ImNhcnQiO086Mjk6IklsbHVtaW5hdGVcU3VwcG9ydFxDb2xsZWN0aW9uIjoyOntzOjg6IgAqAGl0ZW1zIjthOjE6e3M6MzI6ImVmYjI2ZTJjNmFiNmJkNGQxMzIzMjg4OTIzNTIyZDRlIjtPOjM1OiJTdXJmc2lkZW1lZGlhXFNob3BwaW5nY2FydFxDYXJ0SXRlbSI6OTp7czo1OiJyb3dJZCI7czozMjoiZWZiMjZlMmM2YWI2YmQ0ZDEzMjMyODg5MjM1MjJkNGUiO3M6MjoiaWQiO3M6MToiNCI7czozOiJxdHkiO3M6MToiMSI7czo0OiJuYW1lIjtzOjEyOiJQb2xvIFQtc2hpcnQiO3M6NToicHJpY2UiO2Q6ODIwO3M6Nzoib3B0aW9ucyI7Tzo0MjoiU3VyZnNpZGVtZWRpYVxTaG9wcGluZ2NhcnRcQ2FydEl0ZW1PcHRpb25zIjoyOntzOjg6IgAqAGl0ZW1zIjthOjA6e31zOjI4OiIAKgBlc2NhcGVXaGVuQ2FzdGluZ1RvU3RyaW5nIjtiOjA7fXM6NTI6IgBTdXJmc2lkZW1lZGlhXFNob3BwaW5nY2FydFxDYXJ0SXRlbQBhc3NvY2lhdGVkTW9kZWwiO3M6MTg6IkFwcFxNb2RlbHNcUHJvZHVjdCI7czo0NDoiAFN1cmZzaWRlbWVkaWFcU2hvcHBpbmdjYXJ0XENhcnRJdGVtAHRheFJhdGUiO2k6MTA7czo0NDoiAFN1cmZzaWRlbWVkaWFcU2hvcHBpbmdjYXJ0XENhcnRJdGVtAGlzU2F2ZWQiO2I6MDt9fXM6Mjg6IgAqAGVzY2FwZVdoZW5DYXN0aW5nVG9TdHJpbmciO2I6MDt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjQ7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNzMyNjA5NDc1O31zOjg6Im9yZGVyX2lkIjtpOjc7fQ==', 1732611189),
('lpv227FUvWeX8iCkVuG2lgU2VjbsQ0og0Kl6Sf6B', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:132.0) Gecko/20100101 Firefox/132.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibVFCc1RWdEVaSGxHUGQ3QTh1eXNQOXJkNGdrRkcxNHZSWllvd2plRSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fX0=', 1732611213);

-- --------------------------------------------------------

--
-- Table structure for table `slides`
--

CREATE TABLE `slides` (
  `id` bigint UNSIGNED NOT NULL,
  `tagline` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subtitle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `link` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `slides`
--

INSERT INTO `slides` (`id`, `tagline`, `title`, `subtitle`, `link`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Exclusive Offer!', 'Up to 50% Off on Men’s Fashion', 'Limited Time Sale on Shirts,Jean', '#', '1732569503.png', 1, '2024-11-25 15:07:54', '2024-11-25 15:18:24'),
(2, 'Trendy Women’s Fashion', 'Shop the Latest Styles for Women', 'Dresses, Tops, Accessories, and More!', 'http://127.0.0.1:8000/shop', '1732569403.png', 1, '2024-11-25 15:16:43', '2024-11-25 15:16:43'),
(3, 'Healthy Snacks for You', 'Enjoy Fresh Groceries & Snacks', 'Get Your Daily Dose of Healthy Snacks Now.', 'http://127.0.0.1:8000/shop', '1732569467.png', 1, '2024-11-25 15:17:47', '2024-11-25 15:17:47');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `order_id` bigint UNSIGNED NOT NULL,
  `mode` enum('cod','card','paypal') COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','approved','declined','refunded') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `user_id`, `order_id`, `mode`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'cod', 'pending', '2024-11-25 15:29:07', '2024-11-25 15:29:07'),
(2, 2, 2, 'cod', 'pending', '2024-11-26 02:19:19', '2024-11-26 02:19:19'),
(3, 2, 3, 'cod', 'pending', '2024-11-26 02:19:40', '2024-11-26 02:19:40'),
(4, 2, 4, 'cod', 'approved', '2024-11-26 02:20:32', '2024-11-26 02:20:51'),
(5, 3, 5, 'cod', 'pending', '2024-11-26 02:23:35', '2024-11-26 02:23:35'),
(6, 4, 6, 'cod', 'pending', '2024-11-26 02:25:49', '2024-11-26 02:25:49'),
(7, 4, 7, 'cod', 'pending', '2024-11-26 02:26:33', '2024-11-26 02:26:33');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `utype` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'USR' COMMENT 'ADM For Admin and USR for User or Customer',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `mobile`, `email_verified_at`, `password`, `utype`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Md. Rahim Uddin', 'rahimuddin@gmail.com', '01711234567', NULL, '$2y$12$1zP5KfFFRfCL2vBZV9bdOepsjodFCIeN4SN8ToE/MNs6nZx/X7hDa', 'USR', NULL, '2024-11-25 13:36:07', '2024-11-25 13:36:07'),
(2, 'Ayesha Akter', 'ayesha.akter@hotmail.com', '01822345678', NULL, '$2y$12$Ze5WmDo35rQfdA98UBBtk.VO0oWTwU7kO09oLSAZMc/UuM0qZY69G', 'USR', NULL, '2024-11-25 13:36:45', '2024-11-25 13:36:45'),
(3, 'Tanvir Ahmed', 'tanvir.bd@yahoo.com', '01633456789', NULL, '$2y$12$GqpCQvwfc4ShVy6EQcc2AeAFD.QKKg.EDTFUFOfSxYy.mLCjZpXei', 'USR', NULL, '2024-11-25 13:37:13', '2024-11-25 13:37:13'),
(4, 'Nusrat Jahan', 'nusrat.jahan@gmail.com', '01544567890', NULL, '$2y$12$seschG.Dj5G1Vavxz03jhORfJskmCTP5ewZDWJhF4CPY3Qjo7nqEO', 'USR', NULL, '2024-11-25 13:37:46', '2024-11-25 13:37:46'),
(5, 'Kamal Hossain', 'kamal.hossain@live.com', '01955678901', NULL, '$2y$12$6OelbAQpwc/Rq9Lfv0.ex.NjKG8RpucZKsAKa18w3FLZRum3xLfKu', 'USR', NULL, '2024-11-25 13:38:19', '2024-11-25 13:38:19'),
(6, 'Shamsul Alam', 'shamsul.alam@outlook.com', '01799887766', NULL, '$2y$12$f39InzVSBHg0QTMqVKogVuXQYwMn047C0vHHNKaMyLFvsfPWwwW8q', 'ADM', NULL, '2024-11-25 13:44:55', '2024-11-25 13:44:55'),
(7, 'Farzana Akter', 'farzana.akter123@gmail.com', '01887654321', NULL, '$2y$12$XyumSwXpU8TMyNYBIABK2u57XIUfuofxYuqDv8av8fuYhL6K9L.jW', 'ADM', NULL, '2024-11-25 13:46:06', '2024-11-25 13:46:06'),
(8, 'Md. Yusuf', 'yusuf.bd@gmail.com', '01698876543', NULL, '$2y$12$TXP.pZooXV2UN6XRlnKbsuma3szZ3RJIRYv4NFnToeV88H/e17QxG', 'ADM', NULL, '2024-11-25 13:46:46', '2024-11-25 13:46:46');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `addresses_user_id_foreign` (`user_id`);

--
-- Indexes for table `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `brands_slug_unique` (`slug`);

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
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupons_code_unique` (`code`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `month_names`
--
ALTER TABLE `month_names`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oder_items`
--
ALTER TABLE `oder_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oder_items_product_id_foreign` (`product_id`),
  ADD KEY `oder_items_order_id_foreign` (`order_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `orders_user_id_foreign` (`user_id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `products_slug_unique` (`slug`),
  ADD KEY `products_category_id_foreign` (`category_id`),
  ADD KEY `products_brand_id_foreign` (`brand_id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `slides`
--
ALTER TABLE `slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_foreign` (`user_id`),
  ADD KEY `transactions_order_id_foreign` (`order_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD UNIQUE KEY `users_mobile_unique` (`mobile`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `brands`
--
ALTER TABLE `brands`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `month_names`
--
ALTER TABLE `month_names`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `oder_items`
--
ALTER TABLE `oder_items`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `slides`
--
ALTER TABLE `slides`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `addresses`
--
ALTER TABLE `addresses`
  ADD CONSTRAINT `addresses_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `oder_items`
--
ALTER TABLE `oder_items`
  ADD CONSTRAINT `oder_items_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `oder_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `products_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_order_id_foreign` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
