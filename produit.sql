-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 15 avr. 2025 à 12:43
-- Version du serveur : 9.1.0
-- Version de PHP : 8.3.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `produit`
--

-- --------------------------------------------------------

--
-- Structure de la table `articles`
--

DROP TABLE IF EXISTS `articles`;
CREATE TABLE IF NOT EXISTS `articles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `prix` decimal(10,2) NOT NULL,
  `quantite` int NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `articles`
--

INSERT INTO `articles` (`id`, `nom`, `description`, `prix`, `quantite`, `image`, `created_at`, `updated_at`) VALUES
(1, 'Savon', 'Savon Ordinaire', 200.00, 1, NULL, '2025-04-13 16:27:14', '2025-04-15 00:51:37'),
(2, 'Riz', 'Riz de Rosso', 1000.00, 1, NULL, '2025-04-14 16:11:21', '2025-04-14 16:11:21'),
(3, 'sucre', 'kilo', 250.00, 1, NULL, '2025-04-14 22:16:59', '2025-04-14 22:16:59'),
(4, 'Boisson', 'Coca', 250.00, 1, NULL, '2025-04-14 22:52:59', '2025-04-14 22:52:59'),
(5, 'Madar', 'savon liquide', 400.00, 4, 'images/1744677828.jpg', '2025-04-15 00:36:41', '2025-04-15 00:43:48');

-- --------------------------------------------------------

--
-- Structure de la table `article_category`
--

DROP TABLE IF EXISTS `article_category`;
CREATE TABLE IF NOT EXISTS `article_category` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_id` bigint UNSIGNED NOT NULL,
  `article_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `article_category_category_id_foreign` (`category_id`),
  KEY `article_category_article_id_foreign` (`article_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `categories`
--

DROP TABLE IF EXISTS `categories`;
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000001_create_cache_table', 1),
(2, '2025_04_13_150309_create_categories_table', 2),
(3, '2025_04_13_150324_create_articles_table', 3),
(4, '2025_04_13_150400_create_articles_category_table', 4),
(5, '2025_04_13_150427_create_sessions_table', 5),
(6, '2025_04_13_150459_create_roles_table', 6),
(7, '2025_04_13_163429_create_role_user_table', 7);

-- --------------------------------------------------------

--
-- Structure de la table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE IF NOT EXISTS `personal_access_tokens` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `personal_access_tokens`
--

INSERT INTO `personal_access_tokens` (`id`, `tokenable_type`, `tokenable_id`, `name`, `token`, `abilities`, `last_used_at`, `expires_at`, `created_at`, `updated_at`) VALUES
(1, 'App\\Models\\User', 1, 'auth_token', '213ff6639b01866ea4335a0849b8aabdb29b90bf78deeee34c15b5367c8b194a', '[\"*\"]', NULL, NULL, '2025-04-14 05:08:47', '2025-04-14 05:08:47'),
(2, 'App\\Models\\User', 1, 'auth_token', '956f74c14499cb71ce622187d90d94e7f505b166a6bc10841cdc51c2041c76e2', '[\"*\"]', NULL, NULL, '2025-04-14 05:14:37', '2025-04-14 05:14:37'),
(3, 'App\\Models\\User', 1, 'auth_token', '7339cc9ac4daf753ccb996b29f4c1e9091ed5a9c0fb9322d64f36281e5a53de7', '[\"*\"]', NULL, NULL, '2025-04-14 05:14:47', '2025-04-14 05:14:47'),
(4, 'App\\Models\\User', 1, 'auth_token', '349c81a761073dd536f584b11f8a9cfc63b1c4d1b16c502a921bc368269aacc0', '[\"*\"]', NULL, NULL, '2025-04-14 05:26:25', '2025-04-14 05:26:25'),
(5, 'App\\Models\\User', 2, 'auth_token', '3efad10cf591f6cf14df6804544c4377cb3f510cb46d0a7000dfa1dd38c2332b', '[\"*\"]', NULL, NULL, '2025-04-14 05:28:13', '2025-04-14 05:28:13'),
(6, 'App\\Models\\User', 2, 'auth_token', '63cab6f6cc45f2d902836916159c2425161dbf2746f3820b6a5f25ed9e016de6', '[\"*\"]', NULL, NULL, '2025-04-14 05:28:43', '2025-04-14 05:28:43'),
(7, 'App\\Models\\User', 2, 'auth_token', '908e911cebcaf9e3aff710905233597ad3b40f03e1d4e4cd19aaae2ad4f557d1', '[\"*\"]', NULL, NULL, '2025-04-14 05:32:11', '2025-04-14 05:32:11'),
(8, 'App\\Models\\User', 2, 'auth_token', 'c7f89a9084f6db04a0db2f8c8733179aca51c7b619cab4a83397ef0a60589ae8', '[\"*\"]', '2025-04-14 05:42:17', NULL, '2025-04-14 05:42:16', '2025-04-14 05:42:17'),
(9, 'App\\Models\\User', 2, 'auth_token', 'cd3545e6fec5b84137dabd0839fce669ae3b6a198ba9b604ff82f22eb602dbc4', '[\"*\"]', '2025-04-14 06:48:00', NULL, '2025-04-14 06:47:58', '2025-04-14 06:48:00'),
(10, 'App\\Models\\User', 2, 'auth_token', 'b5d8b0949b3a3671e1d03a136a567b892bac8c114ffb69567c0fdb15b31c8d11', '[\"*\"]', '2025-04-14 12:02:33', NULL, '2025-04-14 12:02:33', '2025-04-14 12:02:33'),
(11, 'App\\Models\\User', 2, 'auth_token', 'f7c583fbde7541dabefe4f857b5e3b045ef6f0c86c190c7094b9f510e84c7be3', '[\"*\"]', '2025-04-14 12:27:51', NULL, '2025-04-14 12:27:49', '2025-04-14 12:27:51'),
(12, 'App\\Models\\User', 2, 'auth_token', '1476871d0eb1a341f21cfcbcd157e0d235e8354b776bbd2ec07f8173f263312f', '[\"*\"]', '2025-04-14 12:32:36', NULL, '2025-04-14 12:32:34', '2025-04-14 12:32:36'),
(13, 'App\\Models\\User', 2, 'auth_token', '22b516914578e15fa3901f4ad19107541d3a88ab3c1fa1cfa7bb4f6b4d24f778', '[\"*\"]', '2025-04-14 12:50:47', NULL, '2025-04-14 12:50:45', '2025-04-14 12:50:47'),
(14, 'App\\Models\\User', 2, 'auth_token', '4b49a7a3a008939aa961e50b93a8e7d637f7a5d35f2fe740eb573ecdb02edf54', '[\"*\"]', '2025-04-14 13:01:52', NULL, '2025-04-14 13:01:50', '2025-04-14 13:01:52'),
(15, 'App\\Models\\User', 2, 'auth_token', 'dafb5a79f9e0edffd92109378926ae0abb74ae4f7bacdb6c580a706a2441fdec', '[\"*\"]', '2025-04-14 13:12:34', NULL, '2025-04-14 13:12:33', '2025-04-14 13:12:34'),
(16, 'App\\Models\\User', 2, 'auth_token', '597d51421212b1e653ba20ac329eae68bd963c1d42822b9bcaaa62e2e983517c', '[\"*\"]', '2025-04-14 13:17:57', NULL, '2025-04-14 13:17:56', '2025-04-14 13:17:57'),
(17, 'App\\Models\\User', 2, 'auth_token', '4b61bbf8f36bb3bab36df0e74492ebba054f55f01fae8a47d333521fa82bbe11', '[\"*\"]', '2025-04-14 13:20:06', NULL, '2025-04-14 13:20:05', '2025-04-14 13:20:06'),
(18, 'App\\Models\\User', 2, 'auth_token', '20659a6a558c8eae336170f556fe0f7ff55c53a46aefa27dcd3d45039c47e9a9', '[\"*\"]', '2025-04-14 15:38:20', NULL, '2025-04-14 15:38:19', '2025-04-14 15:38:20'),
(19, 'App\\Models\\User', 2, 'auth_token', 'da6ffcf14b35a7c9e9d0657f4d26015f9749824e3f897b261ae8c0a8b7c6f9f3', '[\"*\"]', '2025-04-14 16:06:45', NULL, '2025-04-14 16:06:43', '2025-04-14 16:06:45'),
(20, 'App\\Models\\User', 2, 'auth_token', '169bf99df70f0e0655233f3512f3cfaef5c943744c83582ee4029a05ca12100a', '[\"*\"]', '2025-04-14 16:12:18', NULL, '2025-04-14 16:12:17', '2025-04-14 16:12:18'),
(21, 'App\\Models\\User', 2, 'auth_token', 'a6d445513da6904ed8b00fc945e8f92fb3df35ce92954c767047f97fc27081cf', '[\"*\"]', '2025-04-14 16:17:27', NULL, '2025-04-14 16:17:26', '2025-04-14 16:17:27'),
(22, 'App\\Models\\User', 2, 'auth_token', 'cef5d9edda9b8afe22cc8074ab93d2657751fd51af72ce15a0a7c6b9dde0d0fa', '[\"*\"]', '2025-04-14 16:33:30', NULL, '2025-04-14 16:33:29', '2025-04-14 16:33:30'),
(23, 'App\\Models\\User', 2, 'auth_token', '5800959ca8c16f9009799c79ab74d7d355c966b7c244a46b4ba2400d6ef155c9', '[\"*\"]', '2025-04-14 16:50:57', NULL, '2025-04-14 16:50:56', '2025-04-14 16:50:57'),
(24, 'App\\Models\\User', 2, 'auth_token', 'a40e050c1c8d216ce8fd565f89dc425018d790f2cdc9d62344f48e4138695b17', '[\"*\"]', '2025-04-14 17:04:17', NULL, '2025-04-14 17:04:16', '2025-04-14 17:04:17'),
(25, 'App\\Models\\User', 2, 'auth_token', 'f7c80260024867fe80ab3cb947470d4dc40d79c98cfcf76266e4e575792a42fd', '[\"*\"]', '2025-04-14 17:15:24', NULL, '2025-04-14 17:15:23', '2025-04-14 17:15:24'),
(26, 'App\\Models\\User', 2, 'auth_token', '8d2387f09c70427d05b41d74f638dfd330d65c3504e11ee9f73e4798d5830c26', '[\"*\"]', '2025-04-14 17:38:57', NULL, '2025-04-14 17:38:55', '2025-04-14 17:38:57'),
(27, 'App\\Models\\User', 2, 'auth_token', 'f9d18c2d8fc6f51eaf4bb0f1a2ccec57f3c485f8e5d25376d919b1c380f2ed37', '[\"*\"]', '2025-04-14 17:43:18', NULL, '2025-04-14 17:43:16', '2025-04-14 17:43:18'),
(28, 'App\\Models\\User', 2, 'auth_token', '4ff04ee27f1dc0f0e90a86b9686454a6275b1f20f85c5ecdaa4581dd234e9371', '[\"*\"]', '2025-04-14 17:45:47', NULL, '2025-04-14 17:45:46', '2025-04-14 17:45:47'),
(29, 'App\\Models\\User', 2, 'auth_token', '6328de6f2b5ec52422e55bcbdd8c407415f0a0e92b51127a9ae07fc7e38104f9', '[\"*\"]', '2025-04-14 18:49:14', NULL, '2025-04-14 18:49:13', '2025-04-14 18:49:14'),
(30, 'App\\Models\\User', 2, 'auth_token', '44b76f6cffefce10e24d188b27a9fe23e66b146ecc1ae6bf52d2ce4ef5808716', '[\"*\"]', '2025-04-14 18:51:27', NULL, '2025-04-14 18:51:26', '2025-04-14 18:51:27'),
(31, 'App\\Models\\User', 2, 'auth_token', '58f932b356dfd5b0166dda3fc040051ff19e878beccd12a5873957b11bc25103', '[\"*\"]', '2025-04-14 19:40:19', NULL, '2025-04-14 19:40:17', '2025-04-14 19:40:19'),
(32, 'App\\Models\\User', 2, 'auth_token', 'df79069ad41e2ab7d3f6b5ed8c35ae6a63d9f48e4792b73a4f4303f867f206a9', '[\"*\"]', '2025-04-14 20:05:49', NULL, '2025-04-14 20:05:47', '2025-04-14 20:05:49'),
(33, 'App\\Models\\User', 2, 'auth_token', '519f2af11279c43c0994c882fb9544fdbc759ba0089c3ab6ed064454239c1957', '[\"*\"]', '2025-04-14 20:33:55', NULL, '2025-04-14 20:33:53', '2025-04-14 20:33:55'),
(34, 'App\\Models\\User', 2, 'auth_token', '88c0579428c29cbaff804c7c906e47cb14978b456ab492430777d0b18930011e', '[\"*\"]', '2025-04-14 20:39:13', NULL, '2025-04-14 20:39:11', '2025-04-14 20:39:13'),
(35, 'App\\Models\\User', 2, 'auth_token', '0a53cd359f6e3c82fb165969785ceca44fbc90c421ecf0da4575e58dc030d181', '[\"*\"]', '2025-04-14 20:56:53', NULL, '2025-04-14 20:56:52', '2025-04-14 20:56:53'),
(36, 'App\\Models\\User', 2, 'auth_token', '7ac883d2f512ad8cf2e50eb6fed1ea5f70ab7af469bbfaea860f563d810779c3', '[\"*\"]', '2025-04-14 21:03:52', NULL, '2025-04-14 21:03:50', '2025-04-14 21:03:52'),
(37, 'App\\Models\\User', 2, 'auth_token', '9973ecb89f65b2c8f00cc8f6c782112e5f0a6e171e54d653222525bf79070133', '[\"*\"]', '2025-04-14 21:29:01', NULL, '2025-04-14 21:28:59', '2025-04-14 21:29:01'),
(38, 'App\\Models\\User', 2, 'auth_token', 'd879ba58a8e6920a0742967316d3a36f9d709e559a1fb68bc2aa4671430a4e1c', '[\"*\"]', '2025-04-14 21:45:30', NULL, '2025-04-14 21:45:29', '2025-04-14 21:45:30'),
(39, 'App\\Models\\User', 2, 'auth_token', '0aa534b34f844bc5178e0a6ec01e000020f266e1c4aa181c86346dd43fc65350', '[\"*\"]', '2025-04-14 22:00:48', NULL, '2025-04-14 22:00:45', '2025-04-14 22:00:48'),
(40, 'App\\Models\\User', 2, 'auth_token', '5821b8b5831429ef8d6ac6f56744a11ec189a5535021d659852af459cd385301', '[\"*\"]', '2025-04-14 23:20:58', NULL, '2025-04-14 22:04:08', '2025-04-14 23:20:58'),
(41, 'App\\Models\\User', 1, 'auth_token', 'ccab73658d3550e7b1bf342cd608804965e2073f9547466b0b8372b800626f56', '[\"*\"]', '2025-04-14 23:29:45', NULL, '2025-04-14 23:29:44', '2025-04-14 23:29:45'),
(42, 'App\\Models\\User', 3, 'auth_token', 'a7237bd88752d0f03b28010ea3b3d30c012f0faf12720ce352852919681f0307', '[\"*\"]', NULL, NULL, '2025-04-14 23:31:01', '2025-04-14 23:31:01'),
(43, 'App\\Models\\User', 3, 'auth_token', 'f1635db4d39be4e8948cfefe718b3929659a134b1004e20b8e8301a653781732', '[\"*\"]', '2025-04-14 23:31:54', NULL, '2025-04-14 23:31:53', '2025-04-14 23:31:54'),
(44, 'App\\Models\\User', 2, 'auth_token', '805ed803ea41f71b00f29ed5d313e4d022fef475dff4cae11f39dfc0e69deb20', '[\"*\"]', '2025-04-14 23:33:53', NULL, '2025-04-14 23:33:36', '2025-04-14 23:33:53'),
(45, 'App\\Models\\User', 3, 'auth_token', '4c5f7475d87ed6a767fcbce56ce74e48d60dbc259b0db9a04f77d2d57a5a8b94', '[\"*\"]', '2025-04-14 23:34:44', NULL, '2025-04-14 23:34:43', '2025-04-14 23:34:44'),
(46, 'App\\Models\\User', 3, 'auth_token', 'a13a9ed3c3191ea66efbc453852893fc8ea78c1ec881fff64cbfb8e998885673', '[\"*\"]', NULL, NULL, '2025-04-14 23:39:30', '2025-04-14 23:39:30'),
(47, 'App\\Models\\User', 3, 'auth_token', '499569c4cca54c432c250025fd56cb129d7288eb579ab0b1dc28b625bf918e34', '[\"*\"]', '2025-04-14 23:52:10', NULL, '2025-04-14 23:43:46', '2025-04-14 23:52:10'),
(48, 'App\\Models\\User', 3, 'auth_token', '52fd38438f2481c32e385a2023dc1d453b508f0ea98dd90901e6b62021758677', '[\"*\"]', '2025-04-14 23:52:40', NULL, '2025-04-14 23:52:39', '2025-04-14 23:52:40'),
(49, 'App\\Models\\User', 3, 'auth_token', '27e43ef05c4a238abe8de235bac5dd2e0e722b31f1a558a7c8ef66ca4d5f3ed3', '[\"*\"]', '2025-04-14 23:56:52', NULL, '2025-04-14 23:56:50', '2025-04-14 23:56:52'),
(50, 'App\\Models\\User', 3, 'auth_token', '3ba850fa172d25d20742a8d4445e14731fe3c359f99253df63ef8cf6bc1e8f22', '[\"*\"]', '2025-04-14 23:58:26', NULL, '2025-04-14 23:58:16', '2025-04-14 23:58:26');

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `role_user`
--

DROP TABLE IF EXISTS `role_user`;
CREATE TABLE IF NOT EXISTS `role_user` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `role_user_role_id_user_id_unique` (`role_id`,`user_id`),
  KEY `role_user_user_id_foreign` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4JHg59Hbzqy5XtOtvYE1FiVHDO0U4Lfu3ZpStqvX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoicnBuUDhqSlFnckI1SndnZ2RsdlY0bGxOQTVXWXBKajFHRU1uMEE2UiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1744580305),
('g5TkGWBKFhvNQM83nlZlw0fxZCVsNoncUJGQhrXK', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT0F1QXJCQ1dPSkZMWFduOXB1aWV6ZWRpYzFEbTRnUk00QjNaRnpSeSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1744592077),
('42pOEBUDKXwO5bZKWrBgJ0sbyvL3fAj7mkz8hvaq', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiUEsxdmtrcXN2VHloS1drNkxBYnRPN3ZDVWRkNFlTYVRpMGFQQ2NHSyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9lZGl0LzEiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTt9', 1744567715),
('vkLmejpez8V0wmy797G3NPcn20nZ5RlYMqyBBpwa', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiTXlRcGhtamp6a0FsVnBxY0RucmFqVDVFS1JrRmhyTTNWZkpyVGwzVCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjI3OiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToyO30=', 1744647082),
('cfG0jU2JyijheQJtcOQvdvJdRQmk6FZhr5ijULve', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/132.0.0.0 Safari/537.36 OPR/117.0.0.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTW5Eb0VvUEZPeEZTNjB2SnNuYjM0QUJZakh6NXg1M0tlZlFuejBMVSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjk6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hY2NldWlsIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1744678635);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `verification_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `role`, `verification_token`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Khalilou', 'khalilouybt@gmail.com', NULL, '$2y$12$AzT6gujMvc/Jo25UiQCVJ.nENqIVMe3ZASZPI.UZDPlGlhkqvdWye', 'user', NULL, NULL, '2025-04-13 16:20:23', '2025-04-13 16:20:23'),
(2, 'khaly', 'khaly@gmail.com', NULL, '$2y$12$sTUk/RT1tyu9qa/JiOaLNe2iE7glDdFp0VD4umEqjqtpWdqkPw/k.', 'user', NULL, NULL, '2025-04-14 05:28:13', '2025-04-14 05:28:13'),
(3, 'hamedy', 'hamedy@gmail.com', NULL, '$2y$12$k92OInazKAXlrFBT3AvFHuaXKGBY/2jWDl1EzGvuDsyaDCUmCyVHq', 'user', NULL, NULL, '2025-04-14 23:31:01', '2025-04-14 23:31:01');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
