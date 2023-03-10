-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Nov 09, 2019 at 12:40 PM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dbcarconnect`
--

-- --------------------------------------------------------

--
-- Table structure for table `CAR`
--

CREATE TABLE `CAR` (
  `id_car` int(11) NOT NULL,
  `carregistration` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `idcus_frk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `CUSTOMER`
--

CREATE TABLE `CUSTOMER` (
  `id_cus` int(11) NOT NULL,
  `name_cus` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `email_cus` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `password_cus` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `gender_cus` enum('ชาย','หญิง') COLLATE utf8_unicode_ci NOT NULL,
  `birthdate_cus` date NOT NULL,
  `tel_cus` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `EMPLOYEE`
--

CREATE TABLE `EMPLOYEE` (
  `id_emp` int(11) NOT NULL,
  `name_emp` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `password_emp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `gender_emp` enum('ชาย','หญิง') COLLATE utf8_unicode_ci NOT NULL,
  `birthdate_emp` date NOT NULL,
  `tel_emp` int(10) NOT NULL,
  `type_emp` enum('พนักงาน','ช่างซ่อมบำรุง') COLLATE utf8_unicode_ci NOT NULL,
  `idsvp_frk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `HISTORY`
--

CREATE TABLE `HISTORY` (
  `id_history` int(11) NOT NULL,
  `date_history` date NOT NULL,
  `idcar_frk` int(11) NOT NULL,
  `idservice_frk` int(11) NOT NULL,
  `status_history` enum('ยังไม่ดำเนินการ','ดำเนินการแล้ว') COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `RECEIVE`
--

CREATE TABLE `RECEIVE` (
  `id_receive` int(11) NOT NULL,
  `idcus_frk` int(11) NOT NULL,
  `idcar_frk` int(11) NOT NULL,
  `sumtime_receive` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `status_receive` enum('ดำเนินการแล้ว','ยังไม่ดำเนินการ') COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SERVICE`
--

CREATE TABLE `SERVICE` (
  `id_service` int(11) NOT NULL,
  `name_service` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `price_service` decimal(10,2) NOT NULL,
  `time_service` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `idsvp_frk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `SERVICEPROVIDERS`
--

CREATE TABLE `SERVICEPROVIDERS` (
  `id_svp` int(11) NOT NULL,
  `name_svp` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `email_svp` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `password_svp` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `workingtime_svp` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `address_svp` varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  `tel_svp` int(10) NOT NULL,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `SERVICEPROVIDERS`
--

INSERT INTO `SERVICEPROVIDERS` (`id_svp`, `name_svp`, `email_svp`, `password_svp`, `workingtime_svp`, `address_svp`, `tel_svp`, `latitude`, `longitude`) VALUES
(1, 'carcar', 'carcar@gmail.com', '123456', '10.00-14.00', '123 moo4 hong', 986667589, 1435676.5435, -32454.76),
(2, '1', '1', '1', '1', '1', 1, 1, 1),
(3, '3', '3', '3', '3', '3', 3, 3, 3);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `CAR`
--
ALTER TABLE `CAR`
  ADD PRIMARY KEY (`id_car`),
  ADD KEY `idcus_frk` (`idcus_frk`);

--
-- Indexes for table `CUSTOMER`
--
ALTER TABLE `CUSTOMER`
  ADD PRIMARY KEY (`id_cus`);

--
-- Indexes for table `EMPLOYEE`
--
ALTER TABLE `EMPLOYEE`
  ADD PRIMARY KEY (`id_emp`),
  ADD KEY `idsvp_frk` (`idsvp_frk`);

--
-- Indexes for table `HISTORY`
--
ALTER TABLE `HISTORY`
  ADD PRIMARY KEY (`id_history`),
  ADD KEY `idcar_frk` (`idcar_frk`),
  ADD KEY `idservice_frk` (`idservice_frk`);

--
-- Indexes for table `RECEIVE`
--
ALTER TABLE `RECEIVE`
  ADD PRIMARY KEY (`id_receive`),
  ADD KEY `idcus_frk` (`idcus_frk`),
  ADD KEY `idcar_frk` (`idcar_frk`);

--
-- Indexes for table `SERVICE`
--
ALTER TABLE `SERVICE`
  ADD PRIMARY KEY (`id_service`),
  ADD KEY `idsvp_frk` (`idsvp_frk`);

--
-- Indexes for table `SERVICEPROVIDERS`
--
ALTER TABLE `SERVICEPROVIDERS`
  ADD PRIMARY KEY (`id_svp`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `CAR`
--
ALTER TABLE `CAR`
  MODIFY `id_car` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `CUSTOMER`
--
ALTER TABLE `CUSTOMER`
  MODIFY `id_cus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `EMPLOYEE`
--
ALTER TABLE `EMPLOYEE`
  MODIFY `id_emp` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `HISTORY`
--
ALTER TABLE `HISTORY`
  MODIFY `id_history` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `RECEIVE`
--
ALTER TABLE `RECEIVE`
  MODIFY `id_receive` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SERVICE`
--
ALTER TABLE `SERVICE`
  MODIFY `id_service` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SERVICEPROVIDERS`
--
ALTER TABLE `SERVICEPROVIDERS`
  MODIFY `id_svp` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CAR`
--
ALTER TABLE `CAR`
  ADD CONSTRAINT `car_ibfk_1` FOREIGN KEY (`idcus_frk`) REFERENCES `CUSTOMER` (`id_cus`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EMPLOYEE`
--
ALTER TABLE `EMPLOYEE`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`idsvp_frk`) REFERENCES `SERVICEPROVIDERS` (`id_svp`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `HISTORY`
--
ALTER TABLE `HISTORY`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`idcar_frk`) REFERENCES `CAR` (`id_car`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `history_ibfk_2` FOREIGN KEY (`idservice_frk`) REFERENCES `SERVICE` (`id_service`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `RECEIVE`
--
ALTER TABLE `RECEIVE`
  ADD CONSTRAINT `receive_ibfk_1` FOREIGN KEY (`idcus_frk`) REFERENCES `CUSTOMER` (`id_cus`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `receive_ibfk_2` FOREIGN KEY (`idcar_frk`) REFERENCES `CAR` (`id_car`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `SERVICE`
--
ALTER TABLE `SERVICE`
  ADD CONSTRAINT `service_ibfk_1` FOREIGN KEY (`idsvp_frk`) REFERENCES `SERVICEPROVIDERS` (`id_svp`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
