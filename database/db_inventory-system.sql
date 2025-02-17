/*
SQLyog Community v13.2.0 (64 bit)
MySQL - 8.0.30 : Database - db_inventory_system
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db_inventory_system` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `db_inventory_system`;

/*Table structure for table `cache` */

DROP TABLE IF EXISTS `cache`;

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `cache` */

/*Table structure for table `cache_locks` */

DROP TABLE IF EXISTS `cache_locks`;

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `cache_locks` */

/*Table structure for table `failed_jobs` */

DROP TABLE IF EXISTS `failed_jobs`;

CREATE TABLE `failed_jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `failed_jobs` */

/*Table structure for table `job_batches` */

DROP TABLE IF EXISTS `job_batches`;

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `job_batches` */

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint unsigned NOT NULL,
  `reserved_at` int unsigned DEFAULT NULL,
  `available_at` int unsigned NOT NULL,
  `created_at` int unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `jobs` */

/*Table structure for table `migrations` */

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `migrations` */

insert  into `migrations`(`id`,`migration`,`batch`) values 
(1,'0001_01_01_000000_create_users_table',1),
(2,'0001_01_01_000001_create_cache_table',1),
(3,'0001_01_01_000002_create_jobs_table',1),
(4,'2014_10_12_000000_create_users_table',1),
(5,'2025_02_14_015059_create_vendors_table',1),
(6,'2025_02_14_015250_create_products_table',1),
(7,'2025_02_14_015251_create_stock_adjustments_table',1),
(8,'2025_02_14_015251_create_stock_opname_table',1),
(9,'2025_02_14_015251_create_stock_transactions_table',1),
(10,'2025_02_14_021516_create_personal_access_tokens_table',1),
(11,'2025_02_14_022751_add_role_to_users_table',1),
(12,'2025_02_14_031149_add_soft_deletes_to_users_table',1),
(13,'2025_02_14_031525_add_vendor_id_to_stock_transactions_table',1),
(14,'2025_02_14_141700_create_stock_opnames_table',1),
(15,'2025_02_14_141701_create_stock_opname_items_table',1),
(16,'2025_02_15_020853_add_contact_person_and_is_active_to_vendors_table',2),
(17,'2025_02_15_062419_add_status_to_stock_adjustment_items_table',3),
(18,'2025_02_15_064145_add_transaction_date_to_stock_transactions_table',4);

/*Table structure for table `password_reset_tokens` */

DROP TABLE IF EXISTS `password_reset_tokens`;

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `password_reset_tokens` */

/*Table structure for table `personal_access_tokens` */

DROP TABLE IF EXISTS `personal_access_tokens`;

CREATE TABLE `personal_access_tokens` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `personal_access_tokens` */

insert  into `personal_access_tokens`(`id`,`tokenable_type`,`tokenable_id`,`name`,`token`,`abilities`,`last_used_at`,`expires_at`,`created_at`,`updated_at`) values 
(1,'App\\Models\\User',1,'auth-token','66be799c03e5d58f9b114221a848604986b24d2e083ca8822ea3dfe943a28236','[\"*\"]','2025-02-14 15:40:11',NULL,'2025-02-14 15:38:34','2025-02-14 15:40:11'),
(2,'App\\Models\\User',4,'auth-token','d2343fafdfb51123430976bf334a2a53346251f3f1e8e6d614ce6b3c8c4ff856','[\"*\"]','2025-02-14 15:41:44',NULL,'2025-02-14 15:40:29','2025-02-14 15:41:44'),
(3,'App\\Models\\User',1,'auth-token','c0c265dfa91a0fc2c7112b36fa3e0ec3847d43b4a86afa22cda7c5e503a268f8','[\"*\"]','2025-02-14 16:09:20',NULL,'2025-02-14 15:42:02','2025-02-14 16:09:20'),
(4,'App\\Models\\User',1,'auth-token','e1b1884b558a55fdb41407c5095bfd40002fd6b45dd8b7f4047ce389393e669c','[\"*\"]','2025-02-14 16:32:52',NULL,'2025-02-14 16:09:27','2025-02-14 16:32:52'),
(5,'App\\Models\\User',1,'auth-token','1360e993c9cec27c9fcff5e6e97e9f4384b66440001d1dc83c40967e5284d6aa','[\"*\"]','2025-02-14 17:02:29',NULL,'2025-02-14 16:33:56','2025-02-14 17:02:29'),
(6,'App\\Models\\User',1,'auth-token','b67d9b931d0a0ee35caff7f052432191a7f2191b26dbf6a7ad4b2c6c9878664b','[\"*\"]','2025-02-14 17:08:37',NULL,'2025-02-14 17:06:59','2025-02-14 17:08:37'),
(7,'App\\Models\\User',1,'auth-token','f50da22a1a0f157ffd3d1930f56427af8a327314cba69ad9b5e7e1fcaa5b6968','[\"*\"]','2025-02-14 17:39:18',NULL,'2025-02-14 17:10:04','2025-02-14 17:39:18'),
(8,'App\\Models\\User',1,'auth-token','8ac7e7fc6ae8b885ee9ed28e98be0687afbb549a0e8d54c510a28eddabd3c269','[\"*\"]','2025-02-14 17:32:06',NULL,'2025-02-14 17:22:52','2025-02-14 17:32:06'),
(9,'App\\Models\\User',1,'auth-token','19976949a4f72f92be67a60a618ee4e10c122d20f7bbcd7604985fe0534d18ea','[\"*\"]','2025-02-14 18:12:03',NULL,'2025-02-14 17:45:11','2025-02-14 18:12:03'),
(10,'App\\Models\\User',1,'auth-token','5bb8e462f2e957fb3d1d551e2a482ad40d2efd95dfea2eef42e6bf74e6433383','[\"*\"]','2025-02-14 18:24:09',NULL,'2025-02-14 18:14:21','2025-02-14 18:24:09'),
(11,'App\\Models\\User',1,'auth-token','23cde1b6859fbc860c186c32eff37e93a8a3665d2e9ac199d560adf8f3807639','[\"*\"]','2025-02-14 18:33:33',NULL,'2025-02-14 18:24:50','2025-02-14 18:33:33'),
(12,'App\\Models\\User',1,'auth-token','c9bd5591afb967e0d39ed7e2863b735c48f9df1ecfb25bc31f470cbd16453ade','[\"*\"]',NULL,NULL,'2025-02-14 18:35:05','2025-02-14 18:35:05'),
(13,'App\\Models\\User',1,'auth-token','97947240fef2a2022ec45edc5b90b3490212d056298ac888af3b4aace4efba82','[\"*\"]','2025-02-14 18:43:08',NULL,'2025-02-14 18:35:25','2025-02-14 18:43:08'),
(14,'App\\Models\\User',1,'auth-token','c89086d523369a1ae5228d3bc5633f398b1ea8c33b08210ca3ef38d846cc2ab3','[\"*\"]','2025-02-14 19:27:50',NULL,'2025-02-14 18:47:11','2025-02-14 19:27:50'),
(15,'App\\Models\\User',1,'auth-token','9190528bbafc7d2f9d2d2747c1e1c583d71dd866a309e567302885e4a6043781','[\"*\"]','2025-02-15 05:00:01',NULL,'2025-02-15 01:38:12','2025-02-15 05:00:01'),
(16,'App\\Models\\User',1,'auth-token','2f9c9a9ddad37b29c1060e8494c7560058b4f7958b7cc43100732901e6258cb9','[\"*\"]','2025-02-15 06:26:20',NULL,'2025-02-15 05:15:22','2025-02-15 06:26:20'),
(17,'App\\Models\\User',1,'auth-token','2d61bb213a9bf58eb3e0f51e0a17be27df6d8ca539be1f2c508088175e833e95','[\"*\"]','2025-02-15 08:06:58',NULL,'2025-02-15 06:26:39','2025-02-15 08:06:58'),
(18,'App\\Models\\User',1,'auth-token','9a6948633f9a76a1ef1c722ee934a83ca6681f2df1722144e87f5ab8e4f8c0db','[\"*\"]','2025-02-15 08:26:57',NULL,'2025-02-15 08:07:07','2025-02-15 08:26:57'),
(19,'App\\Models\\User',1,'auth-token','5c0f41f88ba52e66da12db6aa12c1c8eb065fde5df4f3fc6d8caadf00893d143','[\"*\"]','2025-02-15 08:29:09',NULL,'2025-02-15 08:27:20','2025-02-15 08:29:09'),
(20,'App\\Models\\User',1,'auth-token','839734a4243eef85ac9eed6dace1cba848a281ad3fa7d29d7cc1b30904cffa5e','[\"*\"]','2025-02-15 10:52:30',NULL,'2025-02-15 09:31:59','2025-02-15 10:52:30'),
(21,'App\\Models\\User',1,'auth-token','f002fd4de7a25de77b8fd094534489ffcccf706818d2d6f52db8db042ff2c71a','[\"*\"]',NULL,NULL,'2025-02-15 11:00:50','2025-02-15 11:00:50'),
(22,'App\\Models\\User',1,'auth-token','47163fa69ce5a0526f75611d728acb501dcc2d2cc4c7c7e173ddf9310ea96493','[\"*\"]',NULL,NULL,'2025-02-15 11:00:56','2025-02-15 11:00:56'),
(23,'App\\Models\\User',1,'auth-token','3dcec729de2a97312b1acbcc190541eb697c6c62b771a10377b2e21b3dc3f634','[\"*\"]',NULL,NULL,'2025-02-15 11:01:13','2025-02-15 11:01:13'),
(24,'App\\Models\\User',1,'auth-token','a52785608d2bf435b06b0176eee3e24335eacb8089f978418e3d7fc6db82d3e6','[\"*\"]',NULL,NULL,'2025-02-15 11:02:15','2025-02-15 11:02:15'),
(25,'App\\Models\\User',1,'auth-token','587951095a762a1a3542a511b99d8a0b63ce42570c55119ea437381fb5ca5697','[\"*\"]',NULL,NULL,'2025-02-15 11:03:12','2025-02-15 11:03:12'),
(26,'App\\Models\\User',1,'auth-token','2e351f665aa223a9932df75ee84f3544156ccbef4886e522e1d707bf0697b029','[\"*\"]',NULL,NULL,'2025-02-15 11:05:46','2025-02-15 11:05:46'),
(27,'App\\Models\\User',1,'auth-token','30f64a0ee612a2ad2100db308df32f5ac609bb5f9cd312755fa943463d8a25fe','[\"*\"]',NULL,NULL,'2025-02-15 11:07:49','2025-02-15 11:07:49'),
(28,'App\\Models\\User',1,'auth-token','3fbce60ab982d8cbeeb24abc82e60201c61e9b504d1e2adb79320ffe6a49c664','[\"*\"]',NULL,NULL,'2025-02-15 11:10:05','2025-02-15 11:10:05'),
(29,'App\\Models\\User',1,'auth-token','11d0d543b9776dfb956ec005d48bae155d8db7cf9dd2c79d5ef741759b167da2','[\"*\"]',NULL,NULL,'2025-02-15 11:13:33','2025-02-15 11:13:33'),
(30,'App\\Models\\User',1,'auth-token','a26eecc3de7a50eca04c7cf4c0fe40c42f23bc09063921554496930294c6338d','[\"*\"]',NULL,NULL,'2025-02-15 11:13:41','2025-02-15 11:13:41'),
(31,'App\\Models\\User',1,'auth-token','d23d9351d3de0a52224864347d9a35efa5b17400924b6feae1c176406193bf82','[\"*\"]',NULL,NULL,'2025-02-15 11:14:30','2025-02-15 11:14:30'),
(32,'App\\Models\\User',1,'auth-token','8403fa3e707d3a870183f522144aad4f8aba9aea5b95dcade493e53249578864','[\"*\"]',NULL,NULL,'2025-02-15 11:15:25','2025-02-15 11:15:25'),
(33,'App\\Models\\User',1,'auth-token','8876a4f7486073cf561cca2be2a906849cf09ba32d45cec5900e3336ca60b1de','[\"*\"]',NULL,NULL,'2025-02-15 11:16:44','2025-02-15 11:16:44'),
(34,'App\\Models\\User',1,'auth-token','547f0ceb684e7875e40a1ccc8b2595cd2ed91902b90f99258951f1e4c45c0484','[\"*\"]',NULL,NULL,'2025-02-15 11:18:19','2025-02-15 11:18:19'),
(35,'App\\Models\\User',1,'auth-token','c0b5b3b7fa5a3f0ce6b132d9f5983def2c36abf39c554faf1d28c2aceae582f8','[\"*\"]',NULL,NULL,'2025-02-15 11:19:58','2025-02-15 11:19:58'),
(36,'App\\Models\\User',1,'auth-token','334101400215a770c9835b98bf5aa9666e05546a3f3e573b3d2f00eb7d7ccf21','[\"*\"]',NULL,NULL,'2025-02-15 11:20:03','2025-02-15 11:20:03'),
(37,'App\\Models\\User',1,'auth-token','85596375ced7cb434f05461b1188abb66a0d80d5e7f01584f6dc6b508beb9f23','[\"*\"]',NULL,NULL,'2025-02-15 11:20:13','2025-02-15 11:20:13'),
(38,'App\\Models\\User',1,'auth-token','36cc3d7b70fc8ef87fb7ddbeb3b3040856a318beabcdba1dc7706cfd5e0fa960','[\"*\"]',NULL,NULL,'2025-02-15 11:31:26','2025-02-15 11:31:26'),
(39,'App\\Models\\User',1,'auth-token','5055dcd520a50eeb1f3816a1f137031f3ffaf2dca8cad9ded2b9f76198fa9270','[\"*\"]',NULL,NULL,'2025-02-15 11:31:32','2025-02-15 11:31:32'),
(40,'App\\Models\\User',1,'auth-token','444669531c7b21c59f57dd19be4a6fba32722a3d0a811c674347cf1493fac7e3','[\"*\"]',NULL,NULL,'2025-02-15 11:33:14','2025-02-15 11:33:14'),
(41,'App\\Models\\User',1,'auth-token','baf6b30adf022107ed9914bee53b489ff00eec3131533346989eb40444f19d23','[\"*\"]',NULL,NULL,'2025-02-15 11:33:18','2025-02-15 11:33:18'),
(42,'App\\Models\\User',1,'auth-token','1387705cfd7c0a143a6afb596dc195e24e16237fc2296bc92d13850f68fa0cb2','[\"*\"]',NULL,NULL,'2025-02-15 11:34:07','2025-02-15 11:34:07'),
(43,'App\\Models\\User',1,'auth-token','8ceb548837d5ced1e12ced7a047ab3ea419b83e16351c1dc2da0ac68609925fc','[\"*\"]',NULL,NULL,'2025-02-15 12:16:37','2025-02-15 12:16:37'),
(44,'App\\Models\\User',1,'auth-token','5a39cd9ddda997a7aa68ee20920930ea0c76ab7557465ee716800b5588a897f8','[\"*\"]',NULL,NULL,'2025-02-15 12:19:13','2025-02-15 12:19:13'),
(45,'App\\Models\\User',1,'auth-token','2f9f1ef5bb36605c1385c9cb7baa1eed5e6431e12f2f4489e4c168b7efdd4436','[\"*\"]',NULL,NULL,'2025-02-15 12:19:51','2025-02-15 12:19:51'),
(46,'App\\Models\\User',1,'auth-token','25bc16fd48ab0037d103d742a06ded0472522c74ef8867271529f6dcfebed710','[\"*\"]',NULL,NULL,'2025-02-15 12:20:56','2025-02-15 12:20:56'),
(47,'App\\Models\\User',1,'auth-token','8b904966efc17a3e7da060e83f27bf8ba70c6fc302b4b16ce7165b462d6800be','[\"*\"]',NULL,NULL,'2025-02-15 12:23:42','2025-02-15 12:23:42'),
(48,'App\\Models\\User',1,'auth-token','c8c8c40adae8a152151fb337318795e448743c286ebffb55b563b11ae452d4fd','[\"*\"]',NULL,NULL,'2025-02-15 12:23:51','2025-02-15 12:23:51'),
(49,'App\\Models\\User',1,'auth-token','9de60780d5a5c82aaa129db570a852ceb2ad61819b8b752dd6b3e374db443ea0','[\"*\"]',NULL,NULL,'2025-02-15 12:24:14','2025-02-15 12:24:14'),
(50,'App\\Models\\User',1,'auth-token','75e0c6248563194011b9631401a16623406596a56bb89aef9aa547cde03e4b5e','[\"*\"]',NULL,NULL,'2025-02-15 12:24:26','2025-02-15 12:24:26'),
(51,'App\\Models\\User',1,'auth-token','22b6c1bd38110189db8044897f4e67dba5998d80962d1b17a828efe56c47845f','[\"*\"]',NULL,NULL,'2025-02-15 12:24:35','2025-02-15 12:24:35'),
(52,'App\\Models\\User',1,'auth-token','27ee7bb6c619d01acb7ea46b2c860c8ae94396431c2b6f680cda682ab7ffd0dc','[\"*\"]',NULL,NULL,'2025-02-15 12:26:08','2025-02-15 12:26:08'),
(53,'App\\Models\\User',1,'auth-token','9a59cae0b0499fbbae30d8f09acbda81a323dfdcf060da67e624059e86eaf582','[\"*\"]',NULL,NULL,'2025-02-15 12:26:13','2025-02-15 12:26:13'),
(54,'App\\Models\\User',1,'auth-token','0f82282e01e8ac2cfdda247c73c725dc32c354e9dedd0fcda08a1bb18495040d','[\"*\"]',NULL,NULL,'2025-02-15 12:26:17','2025-02-15 12:26:17'),
(55,'App\\Models\\User',1,'auth-token','064ec124e7357e2e1bc80d76cce7ea48df0cd904dccfdf7d65e2a6af684f4f29','[\"*\"]',NULL,NULL,'2025-02-15 12:27:42','2025-02-15 12:27:42'),
(56,'App\\Models\\User',1,'auth-token','99a9a5600a71d1ad524c4b90ff7e6023480ceea684f415a204043704d78f7ddc','[\"*\"]',NULL,NULL,'2025-02-15 12:28:36','2025-02-15 12:28:36'),
(57,'App\\Models\\User',1,'auth-token','096ee64e3bf65cf913fad60463e22fde3da3619876f5b7109d3d47ecd8290910','[\"*\"]',NULL,NULL,'2025-02-15 12:30:12','2025-02-15 12:30:12'),
(58,'App\\Models\\User',1,'auth-token','cd47d7f224f5d7ab4d6545719aa9116bc068c532e4e60395144b24f11a17dd65','[\"*\"]',NULL,NULL,'2025-02-15 12:32:55','2025-02-15 12:32:55'),
(59,'App\\Models\\User',1,'auth-token','3751daed2c1e1bdac28a49241d94e7c0fe3c145124b18be67372221d24a146b2','[\"*\"]',NULL,NULL,'2025-02-15 12:34:46','2025-02-15 12:34:46'),
(60,'App\\Models\\User',1,'auth-token','ddf2d621fb9a18d6747f0e4197045304a05b25a8c8ba8bcdd99073c030f8382f','[\"*\"]',NULL,NULL,'2025-02-15 12:35:55','2025-02-15 12:35:55'),
(61,'App\\Models\\User',1,'auth-token','e7ddbf4fd6aa032769233544aee18214248b9265139d23485bfa74906256306a','[\"*\"]',NULL,NULL,'2025-02-15 12:37:01','2025-02-15 12:37:01'),
(62,'App\\Models\\User',1,'auth-token','abbc48e5a66120327dd5375535324aafee1afcafe2721859321dee1a63e3d935','[\"*\"]',NULL,NULL,'2025-02-15 12:37:47','2025-02-15 12:37:47'),
(63,'App\\Models\\User',1,'auth-token','2cecc4ea8bdb70b77e099a69577949ffe1b8adff657adbd29e8e78795eccb134','[\"*\"]',NULL,NULL,'2025-02-15 12:37:52','2025-02-15 12:37:52'),
(64,'App\\Models\\User',1,'auth-token','6e9393f16eac211b3ddc85165ab079dcf7c8c266c6a66c5e27b3442fb5ce5a2d','[\"*\"]',NULL,NULL,'2025-02-15 12:39:55','2025-02-15 12:39:55'),
(65,'App\\Models\\User',1,'auth-token','3b8317a128d89c8a84e043b07a0b8c5afd65e1dbe9e157593b75243aa0c34672','[\"*\"]',NULL,NULL,'2025-02-15 12:40:01','2025-02-15 12:40:01'),
(66,'App\\Models\\User',1,'auth-token','4b6150a823ff43735f68f64f73c0993eb343b85848769c8ee7b8bf4433b8c309','[\"*\"]',NULL,NULL,'2025-02-15 12:40:17','2025-02-15 12:40:17'),
(67,'App\\Models\\User',1,'auth-token','ea30def0270708f98f2e1e48dd2564423bd9e9b4765af8707a2b62e585021fec','[\"*\"]',NULL,NULL,'2025-02-15 12:41:00','2025-02-15 12:41:00'),
(68,'App\\Models\\User',1,'auth-token','ab1a560dd818dc25949db9118a90181f84ba87282920ee4fd38e5b2c796f5723','[\"*\"]',NULL,NULL,'2025-02-15 12:41:02','2025-02-15 12:41:02'),
(69,'App\\Models\\User',1,'auth-token','6c5f3ff83014603ab5b2e8ae226e94e1e3ebf65d9c85972b15c902d03e5f5487','[\"*\"]',NULL,NULL,'2025-02-15 12:41:33','2025-02-15 12:41:33'),
(70,'App\\Models\\User',1,'auth-token','9b7fbada904127d1b7397aeadcad952ff93e022e5fbfa9a5e2c91d50dd80c0b8','[\"*\"]',NULL,NULL,'2025-02-15 12:42:14','2025-02-15 12:42:14'),
(71,'App\\Models\\User',1,'auth-token','69858e903f741b3df03cb7ea91afa1dbe9931041872a30889349979c3c09540f','[\"*\"]',NULL,NULL,'2025-02-15 12:42:49','2025-02-15 12:42:49'),
(72,'App\\Models\\User',1,'auth-token','53679c775ad1c455a12df76058aa706f43e0c14ee582bd181b9cbc54a9582d23','[\"*\"]',NULL,NULL,'2025-02-15 12:44:09','2025-02-15 12:44:09'),
(73,'App\\Models\\User',1,'auth-token','227ed7a952f8ae02d3a14c65e9d6accc43c4b328e61f9a3c39d1f6737b0f81d9','[\"*\"]',NULL,NULL,'2025-02-15 12:47:04','2025-02-15 12:47:04'),
(74,'App\\Models\\User',1,'auth-token','02c7b5899bcf5131c0e875abc547a5eae0c4eea3524cea46baf40e71281d5df2','[\"*\"]',NULL,NULL,'2025-02-15 12:51:50','2025-02-15 12:51:50'),
(75,'App\\Models\\User',1,'auth-token','b76246212fcbb4aa7db40a7aeb3bb31dcb6f6b729cc51ff2df9d95e7d7fe4783','[\"*\"]',NULL,NULL,'2025-02-15 12:51:55','2025-02-15 12:51:55'),
(76,'App\\Models\\User',1,'auth-token','89b16642997a293b96c6c16eceff4689843cbf6437384932892c7c59d65a24cd','[\"*\"]',NULL,NULL,'2025-02-15 12:52:00','2025-02-15 12:52:00'),
(77,'App\\Models\\User',1,'auth-token','f2a7bef3cd3aed5c195db041e9cbc299a52c617988df294823146d905296726a','[\"*\"]',NULL,NULL,'2025-02-15 12:53:03','2025-02-15 12:53:03'),
(78,'App\\Models\\User',1,'auth-token','162a1ac3b2e9ef87433f77c99878d516c2701804663a155b9daf34c18b0a8d74','[\"*\"]','2025-02-15 12:56:32',NULL,'2025-02-15 12:55:54','2025-02-15 12:56:32'),
(79,'App\\Models\\User',1,'auth-token','00f27365653f281e36c1debd98a1a74f343244e22242bec53599216b6c98e658','[\"*\"]',NULL,NULL,'2025-02-15 12:59:41','2025-02-15 12:59:41'),
(80,'App\\Models\\User',1,'auth-token','86b29cd5e2913cc31f048981a1ff3cb327c7ce9a5f77461cda25cff5bb838038','[\"*\"]',NULL,NULL,'2025-02-15 12:59:48','2025-02-15 12:59:48'),
(81,'App\\Models\\User',1,'auth-token','56713bef6bae95b4b1765d4a3c7843255329fea9d2e39e586af6d0e76ab210a9','[\"*\"]','2025-02-15 13:01:06',NULL,'2025-02-15 13:00:57','2025-02-15 13:01:06'),
(82,'App\\Models\\User',1,'auth-token','e6a12b2583b848ef943e674bda531d70bcf92842e2d952ef4cdd67ad0ddd6127','[\"*\"]','2025-02-15 13:08:04',NULL,'2025-02-15 13:07:13','2025-02-15 13:08:04'),
(83,'App\\Models\\User',1,'auth-token','698e0cfdb9c879998d80482551e3ac2b51c2d53f8407bc2bb57f8fddb976baa4','[\"*\"]','2025-02-15 13:09:41',NULL,'2025-02-15 13:08:24','2025-02-15 13:09:41'),
(84,'App\\Models\\User',1,'auth-token','0c33f7412bc4320b608e72395d87cad3b781f33f22a9347d522e65ce9e152f8c','[\"*\"]','2025-02-15 13:10:26',NULL,'2025-02-15 13:10:17','2025-02-15 13:10:26'),
(85,'App\\Models\\User',1,'auth-token','537d147c311a6e6aeebbb496cfcfe250f73ba581811364eb5f8c8b6d7b1b5d30','[\"*\"]','2025-02-15 13:14:10',NULL,'2025-02-15 13:13:51','2025-02-15 13:14:10'),
(86,'App\\Models\\User',1,'auth-token','68367c2fe70cb2babf9a714fbc8b9a9de4cd8b0e621f33f79f1c1ad1e5acb6fd','[\"*\"]','2025-02-15 13:18:49',NULL,'2025-02-15 13:17:12','2025-02-15 13:18:49'),
(87,'App\\Models\\User',1,'auth-token','c00a39c8ff1a9435686ded921609e4f952dca6f920ad51622db118668dd6bfc6','[\"*\"]',NULL,NULL,'2025-02-15 13:22:46','2025-02-15 13:22:46'),
(88,'App\\Models\\User',1,'auth-token','76a9ab10cbd5740464166162681a832798a9d4b5194cf56615059a0a6aebe593','[\"*\"]','2025-02-15 13:25:42',NULL,'2025-02-15 13:25:23','2025-02-15 13:25:42'),
(89,'App\\Models\\User',1,'auth-token','a4bfc52ccb47836b8713d19d3f20be56cec3ad9e8957153fcfef35555aeed3f9','[\"*\"]','2025-02-15 15:11:09',NULL,'2025-02-15 13:27:03','2025-02-15 15:11:09'),
(90,'App\\Models\\User',1,'auth-token','d855470fca5821c564ad1826dc8d112096007e6fd5e36d07a047bfe3e9ce2ff1','[\"*\"]','2025-02-15 16:20:29',NULL,'2025-02-15 15:16:00','2025-02-15 16:20:29'),
(91,'App\\Models\\User',1,'auth-token','1fa87fad41e9c4f06fef56f3a3fc41d9350906fedabacedd0c64c7628e1b7305','[\"*\"]','2025-02-15 19:01:09',NULL,'2025-02-15 18:57:53','2025-02-15 19:01:09'),
(92,'App\\Models\\User',1,'auth-token','1d46ff061f2d1a320535140446bae68ec73a8850707f2599cc63c74bbf3d6e90','[\"*\"]','2025-02-15 19:12:48',NULL,'2025-02-15 19:06:13','2025-02-15 19:12:48'),
(93,'App\\Models\\User',1,'auth-token','bb73bc5ca996b16bb94bd66904116cedd7e9f8b6c40f93d4953b0feed303cc5b','[\"*\"]','2025-02-16 08:17:14',NULL,'2025-02-16 02:10:37','2025-02-16 08:17:14'),
(94,'App\\Models\\User',1,'auth-token','8743c4157e714dfb4a4cac7602389b6ce6108ca4f66d4c6abb27010d5c27047d','[\"*\"]','2025-02-16 06:20:15',NULL,'2025-02-16 06:19:52','2025-02-16 06:20:15'),
(95,'App\\Models\\User',1,'auth-token','a304c94e401ecf74de18d37356471b4dff51f637ff2179b0a04a6fb71172770f','[\"*\"]','2025-02-16 09:42:58',NULL,'2025-02-16 08:10:16','2025-02-16 09:42:58'),
(96,'App\\Models\\User',1,'auth-token','750460860a9f5eda040218759d6820218f7f2597042aa650e65c62f987640e17','[\"*\"]','2025-02-16 12:24:41',NULL,'2025-02-16 08:17:26','2025-02-16 12:24:41'),
(97,'App\\Models\\User',1,'auth-token','df85b878d93f9f892991d0de5b49b9d5b73824f418fc0a61891db8bcba0fd24c','[\"*\"]','2025-02-16 14:37:12',NULL,'2025-02-16 12:42:28','2025-02-16 14:37:12'),
(98,'App\\Models\\User',1,'auth-token','59c7471ba15c40b466682e54299bddb9a2e125c36a0f5dee8a052f7ee8155618','[\"*\"]','2025-02-16 14:43:16',NULL,'2025-02-16 12:54:10','2025-02-16 14:43:16'),
(99,'App\\Models\\User',1,'auth-token','4e8c9f67fc15a9f633586d07d3337aa93bed7f59e2f99e29264aa600107c8f93','[\"*\"]','2025-02-16 15:50:32',NULL,'2025-02-16 14:38:23','2025-02-16 15:50:32'),
(100,'App\\Models\\User',1,'auth-token','08723a91f66daece28f28d36ede94182f64f40be53c58c229bb79f24f0ed6b77','[\"*\"]','2025-02-16 17:52:00',NULL,'2025-02-16 15:50:41','2025-02-16 17:52:00'),
(101,'App\\Models\\User',1,'auth-token','fc89d8650b8f31bd09dbe6cd953ccdf60223565784d8adf288d7da58c4000f5f','[\"*\"]','2025-02-17 07:10:31',NULL,'2025-02-17 02:11:25','2025-02-17 07:10:31'),
(102,'App\\Models\\User',1,'auth-token','d6a23cbd47cad9f27f0bf140cdabc11f7728fcda94ecf788d8b996d4842f5c49','[\"*\"]','2025-02-17 07:21:16',NULL,'2025-02-17 07:19:50','2025-02-17 07:21:16');

/*Table structure for table `products` */

DROP TABLE IF EXISTS `products`;

CREATE TABLE `products` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `sku` varchar(255) NOT NULL,
  `category` varchar(255) NOT NULL,
  `description` text,
  `current_stock` decimal(10,2) NOT NULL DEFAULT '0.00',
  `minimum_stock` decimal(10,2) NOT NULL DEFAULT '0.00',
  `unit` varchar(255) NOT NULL DEFAULT 'pcs',
  `average_cost` decimal(10,2) NOT NULL DEFAULT '0.00',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `products_sku_unique` (`sku`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `products` */

insert  into `products`(`id`,`name`,`sku`,`category`,`description`,`current_stock`,`minimum_stock`,`unit`,`average_cost`,`is_active`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Product 1','SKU001','Category A','Description for Product 1',74.00,10.00,'pcs',100.00,1,'2025-02-14 15:38:22','2025-02-16 17:06:50',NULL),
(2,'Product 2','SKU002','Category A','Description for Product 2',95.00,15.00,'pcs',150.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(3,'Product 3','SKU003','Category B','Description for Product 3',117.00,20.00,'pcs',200.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(4,'Product 4','SKU004','Category B','Description for Product 4',53.00,10.00,'pcs',120.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(5,'Product 5','SKU005','Category C','Description for Product 5',172.00,25.00,'pcs',180.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(6,'Product 6','SKU006','Category C','Description for Product 6',102.00,15.00,'pcs',90.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(7,'Product 7','SKU007','Category A','Description for Product 7',85.00,12.00,'pcs',110.00,1,'2025-02-14 15:38:22','2025-02-17 02:53:44',NULL),
(8,'Product 8','SKU008','Category B','Description for Product 8',149.00,18.00,'pcs',160.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(9,'Product 9','SKU009','Category C','Description for Product 9',159.00,22.00,'pcs',140.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(10,'Product 10','SKU010','Category A','Description for Product 10',143.00,20.00,'pcs',130.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(11,'Product 11','SKU011','Category B','Description for Product 11',96.00,15.00,'pcs',170.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(12,'Product 12','SKU012','Category C','Description for Product 12',194.00,25.00,'pcs',190.00,1,'2025-02-14 15:38:22','2025-02-14 15:38:22',NULL),
(14,'Electronics Product 1','SKU0026','Electronics','Description for Electronics product 1',77.00,14.00,'pcs',0.00,1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(15,'Electronics Product 2','SKU0027','Electronics','Description for Electronics product 2',114.00,30.00,'pcs',0.00,1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(16,'Electronics Product 3','SKU0028','Electronics','Description for Electronics product 3',54.00,18.00,'pcs',0.00,1,'2025-02-14 17:30:31','2025-02-15 01:51:19',NULL),
(18,'Expected Evidence','SKU777','Batik','User approve',10.00,4.00,'Pcs',0.00,1,'2025-02-14 19:11:11','2025-02-14 19:11:11',NULL),
(19,'Expected Evidence','SKU999','Batik','User approve',10.00,3.00,'Pcs',0.00,1,'2025-02-14 19:25:25','2025-02-14 19:25:25',NULL),
(20,'Inspection Guidance991','SKU991','Technology','User approve',100.00,10.00,'Pcs',0.00,1,'2025-02-15 01:55:57','2025-02-16 02:40:12','2025-02-16 02:40:12'),
(21,'Industry Guidance2','SKU992','Batik','User approve',0.00,5.00,'Pcs',0.00,1,'2025-02-16 02:13:46','2025-02-16 02:14:06','2025-02-16 02:14:06');

/*Table structure for table `sessions` */

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text,
  `payload` longtext NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `sessions` */

/*Table structure for table `stock_adjustment_items` */

DROP TABLE IF EXISTS `stock_adjustment_items`;

CREATE TABLE `stock_adjustment_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stock_adjustment_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `quantity` int NOT NULL,
  `status` enum('Normal','Rusak','Hilang','Expired') DEFAULT NULL COMMENT 'Status produk setelah penyesuaian stok',
  `notes` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_adjustment_items_stock_adjustment_id_foreign` (`stock_adjustment_id`),
  KEY `stock_adjustment_items_product_id_foreign` (`product_id`),
  CONSTRAINT `stock_adjustment_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `stock_adjustment_items_stock_adjustment_id_foreign` FOREIGN KEY (`stock_adjustment_id`) REFERENCES `stock_adjustments` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `stock_adjustment_items` */

insert  into `stock_adjustment_items`(`id`,`stock_adjustment_id`,`product_id`,`quantity`,`status`,`notes`,`created_at`,`updated_at`,`deleted_at`) values 
(1,1,7,1,'Normal','barang ada digudang','2025-02-14 15:41:43','2025-02-14 15:41:43',NULL),
(2,2,7,1,'Normal','test','2025-02-14 16:03:18','2025-02-14 16:03:18',NULL),
(3,3,7,1,'Normal',NULL,'2025-02-14 16:09:55','2025-02-14 16:09:55',NULL),
(4,4,7,1,'Expired',NULL,'2025-02-14 16:12:13','2025-02-14 16:12:13',NULL),
(5,5,7,1,'Normal',NULL,'2025-02-14 16:15:24','2025-02-14 16:15:24',NULL),
(6,6,7,1,'Expired',NULL,'2025-02-14 16:17:29','2025-02-14 16:17:29',NULL),
(7,7,7,1,'Normal',NULL,'2025-02-14 16:19:15','2025-02-14 16:19:15',NULL),
(8,8,7,1,'Normal',NULL,'2025-02-14 16:32:29','2025-02-14 16:32:29',NULL),
(9,10,7,1,NULL,NULL,'2025-02-16 14:30:42','2025-02-16 14:30:42',NULL),
(10,11,7,1,NULL,NULL,'2025-02-16 14:34:32','2025-02-16 14:34:32',NULL),
(11,12,7,1,NULL,NULL,'2025-02-16 14:35:06','2025-02-16 14:35:06',NULL),
(12,13,7,1,NULL,NULL,'2025-02-16 14:36:05','2025-02-16 14:36:05',NULL),
(13,14,1,8,NULL,NULL,'2025-02-16 14:43:16','2025-02-16 14:43:16',NULL),
(14,15,1,8,NULL,NULL,'2025-02-16 15:53:56','2025-02-16 15:53:56',NULL),
(15,16,1,8,NULL,NULL,'2025-02-16 15:54:27','2025-02-16 15:54:27',NULL),
(16,17,1,2,NULL,NULL,'2025-02-16 15:54:54','2025-02-16 15:54:54',NULL);

/*Table structure for table `stock_adjustments` */

DROP TABLE IF EXISTS `stock_adjustments`;

CREATE TABLE `stock_adjustments` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `type` enum('in','out') NOT NULL,
  `status` enum('draft','approved','rejected') NOT NULL DEFAULT 'draft',
  `notes` text,
  `created_by` bigint unsigned NOT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `rejected_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `rejected_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_adjustments_created_by_foreign` (`created_by`),
  KEY `stock_adjustments_approved_by_foreign` (`approved_by`),
  KEY `stock_adjustments_rejected_by_foreign` (`rejected_by`),
  CONSTRAINT `stock_adjustments_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `stock_adjustments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `stock_adjustments_rejected_by_foreign` FOREIGN KEY (`rejected_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `stock_adjustments` */

insert  into `stock_adjustments`(`id`,`date`,`type`,`status`,`notes`,`created_by`,`approved_by`,`rejected_by`,`approved_at`,`rejected_at`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'2025-02-14','in','approved',NULL,4,1,NULL,'2025-02-17 02:53:32',NULL,'2025-02-14 15:41:43','2025-02-17 02:53:32',NULL),
(2,'2025-02-14','out','approved',NULL,1,1,1,'2025-02-17 02:53:44','2025-02-16 17:03:46','2025-02-14 16:03:18','2025-02-17 02:53:44',NULL),
(3,'2025-02-14','in','draft',NULL,1,1,NULL,'2025-02-16 17:03:22',NULL,'2025-02-14 16:09:55','2025-02-16 17:03:22',NULL),
(4,'2025-02-14','out','draft',NULL,1,1,1,'2025-02-14 16:12:18','2025-02-16 17:03:14','2025-02-14 16:12:13','2025-02-16 17:03:14',NULL),
(5,'2025-02-14','in','draft',NULL,1,1,NULL,'2025-02-16 17:03:03',NULL,'2025-02-14 16:15:24','2025-02-16 17:03:03',NULL),
(6,'2025-02-14','out','approved',NULL,1,1,1,'2025-02-16 17:22:30','2025-02-16 17:01:20','2025-02-14 16:17:29','2025-02-16 17:22:30',NULL),
(7,'2025-02-14','in','rejected',NULL,1,1,1,'2025-02-14 16:19:20','2025-02-16 17:22:22','2025-02-14 16:19:15','2025-02-16 17:22:22',NULL),
(8,'2025-02-14','out','approved',NULL,1,1,NULL,'2025-02-16 17:22:18',NULL,'2025-02-14 16:32:29','2025-02-16 17:22:18',NULL),
(9,'2025-02-14','in','approved','Stock Adjustment from Stock Opname #2',1,1,NULL,'2025-02-16 17:12:01',NULL,'2025-02-14 16:41:52','2025-02-16 17:12:01',NULL),
(10,'2025-02-16','in','rejected','barang expired',1,NULL,1,NULL,'2025-02-16 17:11:52','2025-02-16 14:30:42','2025-02-16 17:11:52',NULL),
(11,'2025-02-16','in','approved','barang expired',1,1,1,'2025-02-16 17:11:47','2025-02-16 16:53:48','2025-02-16 14:34:32','2025-02-16 17:11:47',NULL),
(12,'2025-02-16','in','approved','barang expired',1,1,1,'2025-02-16 17:11:28','2025-02-16 16:35:59','2025-02-16 14:35:06','2025-02-16 17:11:28',NULL),
(13,'2025-02-16','in','approved','barang expired',1,1,1,'2025-02-16 17:09:33','2025-02-16 16:32:42','2025-02-16 14:36:05','2025-02-16 17:09:33',NULL),
(14,'2025-02-16','out','rejected','barang expired',1,1,1,'2025-02-16 17:01:06','2025-02-16 17:06:55','2025-02-16 14:43:16','2025-02-16 17:06:55',NULL),
(15,'2025-02-16','out','approved','barang expired',1,1,NULL,'2025-02-16 17:06:50',NULL,'2025-02-16 15:53:56','2025-02-16 17:06:50',NULL),
(16,'2025-02-16','out','rejected','barang expired',1,1,1,'2025-02-16 16:23:44','2025-02-16 17:06:42','2025-02-16 15:54:27','2025-02-16 17:06:42',NULL),
(17,'2025-02-16','in','approved','barang tambah',1,1,NULL,'2025-02-16 17:06:33',NULL,'2025-02-16 15:54:54','2025-02-16 17:06:33',NULL);

/*Table structure for table `stock_opname_items` */

DROP TABLE IF EXISTS `stock_opname_items`;

CREATE TABLE `stock_opname_items` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `stock_opname_id` bigint unsigned NOT NULL,
  `product_id` bigint unsigned NOT NULL,
  `system_stock` int NOT NULL,
  `physical_stock` int NOT NULL,
  `difference` int NOT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_opname_items_stock_opname_id_foreign` (`stock_opname_id`),
  KEY `stock_opname_items_product_id_foreign` (`product_id`),
  CONSTRAINT `stock_opname_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `stock_opname_items_stock_opname_id_foreign` FOREIGN KEY (`stock_opname_id`) REFERENCES `stock_opnames` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `stock_opname_items` */

insert  into `stock_opname_items`(`id`,`stock_opname_id`,`product_id`,`system_stock`,`physical_stock`,`difference`,`notes`,`created_at`,`updated_at`) values 
(1,1,1,87,87,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(2,1,2,95,95,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(3,1,7,79,80,1,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(4,1,10,143,143,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(5,1,3,117,117,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(6,1,4,53,53,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(7,1,8,149,149,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(8,1,11,96,96,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(9,1,5,172,172,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(10,1,6,102,102,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(11,1,9,159,159,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(12,1,12,194,194,0,'test item','2025-02-14 15:39:58','2025-02-14 15:39:58'),
(13,2,1,87,87,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(14,2,2,95,95,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(15,2,7,79,79,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(16,2,10,143,143,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(17,2,3,117,117,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(18,2,4,53,53,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(19,2,8,149,149,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(20,2,11,96,96,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(21,2,5,172,172,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(22,2,6,102,102,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(23,2,9,159,159,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40'),
(24,2,12,194,194,0,'test','2025-02-14 16:41:40','2025-02-14 16:41:40');

/*Table structure for table `stock_opnames` */

DROP TABLE IF EXISTS `stock_opnames`;

CREATE TABLE `stock_opnames` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `status` enum('draft','pending','approved','rejected') NOT NULL DEFAULT 'draft',
  `created_by` bigint unsigned NOT NULL,
  `approved_by` bigint unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_opnames_created_by_foreign` (`created_by`),
  KEY `stock_opnames_approved_by_foreign` (`approved_by`),
  CONSTRAINT `stock_opnames_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`),
  CONSTRAINT `stock_opnames_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `stock_opnames` */

insert  into `stock_opnames`(`id`,`date`,`status`,`created_by`,`approved_by`,`approved_at`,`notes`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'2025-02-14','draft',1,NULL,NULL,NULL,'2025-02-14 15:39:58','2025-02-14 15:39:58',NULL),
(2,'2025-02-14','approved',1,1,'2025-02-14 16:41:52',NULL,'2025-02-14 16:41:40','2025-02-14 16:41:52',NULL);

/*Table structure for table `stock_transactions` */

DROP TABLE IF EXISTS `stock_transactions`;

CREATE TABLE `stock_transactions` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `product_id` bigint unsigned NOT NULL,
  `vendor_id` bigint unsigned DEFAULT NULL,
  `transaction_type` enum('in','out') NOT NULL,
  `quantity` decimal(10,2) NOT NULL,
  `unit_price` decimal(15,2) NOT NULL,
  `total_price` decimal(15,2) NOT NULL,
  `transaction_date` date DEFAULT NULL COMMENT 'Tanggal transaksi stok',
  `reference_number` varchar(255) NOT NULL,
  `notes` text,
  `created_by` bigint unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `stock_transactions_product_id_foreign` (`product_id`),
  KEY `stock_transactions_created_by_foreign` (`created_by`),
  KEY `stock_transactions_vendor_id_foreign` (`vendor_id`),
  CONSTRAINT `stock_transactions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`),
  CONSTRAINT `stock_transactions_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  CONSTRAINT `stock_transactions_vendor_id_foreign` FOREIGN KEY (`vendor_id`) REFERENCES `vendors` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `stock_transactions` */

insert  into `stock_transactions`(`id`,`product_id`,`vendor_id`,`transaction_type`,`quantity`,`unit_price`,`total_price`,`transaction_date`,`reference_number`,`notes`,`created_by`,`created_at`,`updated_at`,`deleted_at`) values 
(1,1,2,'in',1.00,12000.00,12000.00,'2025-02-15','INV-001','User create',1,'2025-02-15 03:14:32','2025-02-15 06:42:48',NULL),
(2,1,3,'in',1.00,13000.00,13000.00,'2025-02-15','INV-002','User approve',1,'2025-02-15 03:16:45','2025-02-15 06:42:48',NULL),
(3,1,4,'in',10.00,14000.00,140000.00,'2025-02-15','INV-003','Item create',1,'2025-02-15 03:18:00','2025-02-15 06:42:48',NULL),
(4,1,5,'in',10.00,13000.00,130000.00,'2025-02-15','INV-004',NULL,1,'2025-02-15 03:21:52','2025-02-15 06:42:48',NULL),
(5,1,1,'in',1.00,20000.00,20000.00,'2025-02-15','INV-005','Item create',1,'2025-02-15 03:26:32','2025-02-15 06:42:48',NULL);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role` enum('admin','manager','warehouse','staff') NOT NULL DEFAULT 'staff',
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `users` */

insert  into `users`(`id`,`name`,`email`,`email_verified_at`,`password`,`remember_token`,`created_at`,`updated_at`,`role`,`deleted_at`) values 
(1,'Admin User','admin@example.com',NULL,'$2y$12$4nSwvCCzYMPScO6nCy/CAOvr63YS6JVliuw4OSVKUtUOYICmQ/h52',NULL,'2025-02-14 15:38:17','2025-02-14 15:38:17','admin',NULL),
(2,'Manager User','manager@example.com',NULL,'$2y$12$3leE9AolP4WMseLmZZ4jFO0SyM24CaVZ89d5xCw1eJSR9cpSWuI/S',NULL,'2025-02-14 15:38:17','2025-02-14 15:38:17','manager',NULL),
(3,'Warehouse User','warehouse@example.com',NULL,'$2y$12$j2JATeXkKA4ylPpO9Joo0OCuPu4k3zSHFaiuAFZGau8UySAvr25Lm',NULL,'2025-02-14 15:38:17','2025-02-14 15:38:17','warehouse',NULL),
(4,'Staff User','staff@example.com',NULL,'$2y$12$3hX4g1HSXGclSNS7HHmsI.I/m2r8gycaIlRvRZeru1oY1NtmaSOAy',NULL,'2025-02-14 15:38:18','2025-02-14 15:38:18','staff',NULL);

/*Table structure for table `vendors` */

DROP TABLE IF EXISTS `vendors`;

CREATE TABLE `vendors` (
  `id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `contact_person` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `address` text,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

/*Data for the table `vendors` */

insert  into `vendors`(`id`,`name`,`contact_person`,`email`,`phone`,`address`,`is_active`,`created_at`,`updated_at`,`deleted_at`) values 
(1,'Vendor 1','lukman V1V2','vendor1@example.com','081234567891','Address for vendor 1',1,'2025-02-14 17:26:52','2025-02-16 02:41:12','2025-02-16 02:41:12'),
(2,'Vendor 2',NULL,'vendor2@example.com','081234567892','Address for vendor 2',1,'2025-02-14 17:26:52','2025-02-14 17:26:52',NULL),
(3,'Vendor 3',NULL,'vendor3@example.com','081234567893','Address for vendor 3',1,'2025-02-14 17:26:52','2025-02-14 17:26:52',NULL),
(4,'Vendor 4',NULL,'vendor4@example.com','081234567894','Address for vendor 4',1,'2025-02-14 17:26:52','2025-02-14 17:26:52',NULL),
(5,'Vendor 5',NULL,'vendor5@example.com','081234567895','Address for vendor 5',1,'2025-02-14 17:26:52','2025-02-14 17:26:52',NULL),
(6,'Vendor 1','lukman','vendor1@example.com','0812345678912222','Address for vendor 1222',1,'2025-02-14 17:30:07','2025-02-15 02:37:29',NULL),
(7,'Vendor 2',NULL,'vendor2@example.com','081234567892','Address for vendor 2',1,'2025-02-14 17:30:07','2025-02-14 17:30:07',NULL),
(8,'Vendor 3',NULL,'vendor3@example.com','081234567893','Address for vendor 3',1,'2025-02-14 17:30:07','2025-02-14 17:30:07',NULL),
(9,'Vendor 4',NULL,'vendor4@example.com','081234567894','Address for vendor 4',1,'2025-02-14 17:30:07','2025-02-14 17:30:07',NULL),
(10,'Vendor 5',NULL,'vendor5@example.com','081234567895','Address for vendor 5',1,'2025-02-14 17:30:07','2025-02-14 17:30:07',NULL),
(11,'Vendor 1',NULL,'vendor1@example.com','081234567891','Address for vendor 1',1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(12,'Vendor 2',NULL,'vendor2@example.com','081234567892','Address for vendor 2',1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(13,'Vendor 3',NULL,'vendor3@example.com','081234567893','Address for vendor 3',1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(14,'Vendor 4',NULL,'vendor4@example.com','081234567894','Address for vendor 4',1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(15,'Vendor 5',NULL,'vendor5@example.com','081234567895','Address for vendor 5',1,'2025-02-14 17:30:31','2025-02-14 17:30:31',NULL),
(16,'Karjono Karjono','Karjono Karjono','aryo@gmail.com','01123456789','Jombang',1,'2025-02-15 02:09:39','2025-02-15 02:37:53','2025-02-15 02:37:53');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
