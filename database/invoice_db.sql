-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.4.28-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for invoice_db
CREATE DATABASE IF NOT EXISTS `invoice_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `invoice_db`;

-- Dumping structure for table invoice_db.brand_list
CREATE TABLE IF NOT EXISTS `brand_list` (
  `id` int(30) NOT NULL,
  `name` varchar(250) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.brand_list: ~2 rows (approximately)
INSERT INTO `brand_list` (`id`, `name`) VALUES
	(1, 'Nigey'),
	(2, 'Adidoy');

-- Dumping structure for table invoice_db.invoice_list
CREATE TABLE IF NOT EXISTS `invoice_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `customer_name` varchar(100) NOT NULL,
  `sub_total` float NOT NULL,
  `tax_rate` float NOT NULL,
  `total_amount` float NOT NULL,
  `remarks` text NOT NULL,
  `date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime NOT NULL,
  `variant_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `brand_list` (`variant_id`) USING BTREE,
  KEY `user_id` (`user_id`),
  CONSTRAINT `FK_invoice_list_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_invoice_list_variant_list` FOREIGN KEY (`variant_id`) REFERENCES `variant_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.invoice_list: ~0 rows (approximately)

-- Dumping structure for table invoice_db.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(20) NOT NULL DEFAULT 'employee',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.role: ~3 rows (approximately)
INSERT INTO `role` (`id`, `role_name`) VALUES
	(1, 'employee'),
	(2, 'admin'),
	(3, 'super_admin');

-- Dumping structure for table invoice_db.system_info
CREATE TABLE IF NOT EXISTS `system_info` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `meta_field` text NOT NULL,
  `meta_value` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.system_info: ~6 rows (approximately)
INSERT INTO `system_info` (`id`, `meta_field`, `meta_value`) VALUES
	(1, 'name', 'Simple Invoice Management System'),
	(6, 'short_name', 'Invoice System'),
	(11, 'logo', 'uploads/1664025480_bch-icon-transparent.png'),
	(13, 'user_avatar', 'uploads/user_avatar.jpg'),
	(14, 'cover', 'uploads/1624240440_banner1.jpg'),
	(15, 'tax_rate', '12');

-- Dumping structure for table invoice_db.type_list
CREATE TABLE IF NOT EXISTS `type_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `brand` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `brand` (`brand`),
  CONSTRAINT `FK_type_list_brand_list` FOREIGN KEY (`brand`) REFERENCES `brand_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.type_list: ~2 rows (approximately)
INSERT INTO `type_list` (`id`, `name`, `brand`) VALUES
	(1, 'Sukma diiku', 1),
	(2, 'Uniga', 2);

-- Dumping structure for table invoice_db.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(50) NOT NULL AUTO_INCREMENT,
  `name` varchar(250) NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `last_login` datetime DEFAULT NULL,
  `role_id` int(2) DEFAULT 1,
  `date_added` datetime NOT NULL DEFAULT current_timestamp(),
  `date_updated` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `FK_users_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.users: ~2 rows (approximately)
INSERT INTO `users` (`id`, `name`, `username`, `password`, `last_login`, `role_id`, `date_added`, `date_updated`) VALUES
	(1, 'Adminstrator', 'admin', '0192023a7bbd73250516f069df18b500', NULL, 2, '2021-01-20 14:02:37', '2023-05-03 21:10:32'),
	(2, 'Fahmi Pradana', 'pammi', '234', NULL, 1, '2023-05-03 21:07:08', '2023-05-03 21:10:34');

-- Dumping structure for table invoice_db.variant_list
CREATE TABLE IF NOT EXISTS `variant_list` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `color` varchar(100) NOT NULL,
  `size` varchar(100) NOT NULL,
  `price` float NOT NULL,
  `type_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jenis` (`type_id`) USING BTREE,
  CONSTRAINT `FK_variant_list_type_list` FOREIGN KEY (`type_id`) REFERENCES `type_list` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table invoice_db.variant_list: ~1 rows (approximately)
INSERT INTO `variant_list` (`id`, `name`, `color`, `size`, `price`, `type_id`) VALUES
	(1, 'asalole jos', 'hitam', '64', 619000, 1);

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
