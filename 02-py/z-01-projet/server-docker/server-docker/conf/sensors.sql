-- phpMyAdmin SQL Dump
-- version 4.6.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Sep 16, 2016 at 10:58 AM
-- Server version: 10.1.16-MariaDB-1~jessie
-- PHP Version: 5.6.23

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sensors`
--

-- --------------------------------------------------------

--
-- Table structure for table `data`
--

CREATE TABLE `data` (
  `id` int(11) NOT NULL,
  `sensor_id` int(11) NOT NULL,
  `server_timestamp` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `gps_lat` float(10,6) DEFAULT NULL,
  `gps_lng` float(10,6) DEFAULT NULL,
  `gps_alt` int(11) DEFAULT NULL,
  `batt_v` float DEFAULT NULL,
  `pressure` float DEFAULT NULL,
  `humidity` float DEFAULT NULL,
  `temperature` float DEFAULT NULL,
  `pm1.0` int(11) DEFAULT NULL,
  `pm2.5` int(11) DEFAULT NULL,
  `pm10` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `field-conf`
--

CREATE TABLE `field-conf` (
  `id` int(11) NOT NULL,
  `field` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datatype` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `field-conf`
--

INSERT INTO `field-conf` (`id`, `field`, `datatype`) VALUES
(0, 'interval', 'B');

-- --------------------------------------------------------

--
-- Table structure for table `field-data`
--

CREATE TABLE `field-data` (
  `id` int(11) NOT NULL,
  `field` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `datatype` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `multiplier` float NOT NULL DEFAULT '1',
  `bias` float NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `field-data`
--

INSERT INTO `field-data` (`id`, `field`, `datatype`, `multiplier`, `bias`) VALUES
(1, 'gps_lat', 'f', 1, 0),
(2, 'gps_lng', 'f', 1, 0),
(3, 'gps_alt', 'h', 1, 0),
(4, 'temperature', 'h', 0.1, 0),
(5, 'humidity', 'H', 0.1, 0),
(6, 'pressure', 'H', 0.1, 0),
(7, 'pm2.5', 'H', 1, 0),
(8, 'pm10', 'H', 1, 0),
(9, 'pm1.0', 'H', 1, 0),
(10, 'batt_v', 'H', 0.001, 0);

-- --------------------------------------------------------

--
-- Table structure for table `field-view`
--

CREATE TABLE `field-view` (
  `field` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unit` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `minimum` float NOT NULL COMMENT 'green',
  `threshold` float DEFAULT NULL COMMENT 'yellow',
  `maximum` float NOT NULL COMMENT 'red'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `field-view`
--

INSERT INTO `field-view` (`field`, `name`, `unit`, `minimum`, `threshold`, `maximum`) VALUES
('batt_v', 'Battery voltage', 'V', 4.2, 3.7, 3),
('humidity', 'Relative humidity', '%', 20, NULL, 80),
('pm1.0', 'PM1.0', 'μg/m3', 0, NULL, 50),
('pm10', 'PM10', 'μg/m3', 0, 40, 50),
('pm2.5', 'PM2.5', 'μg/m3', 0, 25, 50),
('pressure', 'Air pressure', 'hPa', 950, NULL, 1080),
('temperature', 'Temperature', '°C', 10, NULL, 40);

-- --------------------------------------------------------

--
-- Table structure for table `sensor`
--

CREATE TABLE `sensor` (
  `id` int(11) NOT NULL,
  `name` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `interval` int(11) NOT NULL DEFAULT '5'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sensor`
--

INSERT INTO `sensor` (`id`, `name`, `interval`) VALUES
(1, 'dummy', 1),
(2, 'test', 1),
(3, 'S3', 5),
(4, 'S4', 5),
(5, 'S5', 5),
(6, 'S6', 5),
(7, 'S7', 5),
(8, 'S8', 5),
(9, 'S9', 5),
(10, 'tenth', 5),
(11, 'eleventh', 5);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `data`
--
ALTER TABLE `data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uid` (`timestamp`,`sensor_id`),
  ADD KEY `timestamp` (`timestamp`),
  ADD KEY `sensor_id` (`sensor_id`);

--
-- Indexes for table `field-conf`
--
ALTER TABLE `field-conf`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `field` (`field`) USING BTREE;

--
-- Indexes for table `field-data`
--
ALTER TABLE `field-data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `field` (`field`) USING BTREE;

--
-- Indexes for table `field-view`
--
ALTER TABLE `field-view`
  ADD PRIMARY KEY (`field`) USING BTREE;

--
-- Indexes for table `sensor`
--
ALTER TABLE `sensor`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `data`
--
ALTER TABLE `data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
