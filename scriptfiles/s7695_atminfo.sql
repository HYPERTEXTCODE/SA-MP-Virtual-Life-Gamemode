-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 26, 2017 at 10:37 AM
-- Server version: 10.1.16-MariaDB
-- PHP Version: 5.5.38

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smrp`
--

-- --------------------------------------------------------

--
-- Table structure for table `atminfo`
--

CREATE TABLE `atminfo` (
  `ID` smallint(3) NOT NULL DEFAULT '-1',
  `X` float NOT NULL DEFAULT '1681.97',
  `Y` float NOT NULL DEFAULT '-1245.81',
  `Z` float NOT NULL DEFAULT '129.365',
  `rotX` float NOT NULL DEFAULT '0',
  `rotY` float NOT NULL DEFAULT '0',
  `rotZ` float NOT NULL DEFAULT '0',
  `Interior` int(9) NOT NULL DEFAULT '0',
  `VirtualWorld` int(9) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `atminfo`
--
ALTER TABLE `atminfo`
  ADD UNIQUE KEY `ID` (`ID`,`X`,`Y`,`Z`,`rotX`,`rotY`,`rotZ`,`Interior`,`VirtualWorld`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
