-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 11, 2018 at 07:17 AM
-- Server version: 10.1.34-MariaDB
-- PHP Version: 7.0.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gokart`
--

-- --------------------------------------------------------

--
-- Table structure for table `fruits`
--

CREATE TABLE `fruits` (
  `email` varchar(30) NOT NULL,
  `name` varchar(20) NOT NULL,
  `price` float NOT NULL,
  `quantity` int(11) NOT NULL,
  `pricedate` date NOT NULL,
  `quantitydate` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `fruits`
--

INSERT INTO `fruits` (`email`, `name`, `price`, `quantity`, `pricedate`, `quantitydate`) VALUES
('bubby@gmail.com', 'apple', 5, 86, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'banana', 0.5, 79, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'guava', 2, 100, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'mango', 15, 100, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'melon', 10, 65, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'orange', 1, 86, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'papaya', 8, 100, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'pineapple', 20, 100, '2018-12-10', '2018-12-10'),
('bubby@gmail.com', 'pomegranate', 12, 100, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'apple', 5, 86, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'banana', 0.5, 85, '2018-12-10', '2018-12-11'),
('harshith@gmail.com', 'guava', 2, 100, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'mango', 9.6, 100, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'melon', 10, 75, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'orange', 1, 86, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'papaya', 8, 91, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'pineapple', 18.7, 100, '2018-12-10', '2018-12-10'),
('harshith@gmail.com', 'pomegranate', 12, 100, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'apple', 5.8, 108, '2018-12-11', '2018-12-11'),
('krishna@gmail.com', 'banana', 0.5, 92, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'guava', 2, 92, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'mango', 15, 89, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'melon', 10, 93, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'orange', 1.5, 107, '2018-12-11', '2018-12-11'),
('krishna@gmail.com', 'papaya', 8, 100, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'pineapple', 20, 79, '2018-12-10', '2018-12-10'),
('krishna@gmail.com', 'pomegranate', 12, 93, '2018-12-10', '2018-12-10'),
('sanketh@gmail.com', 'apple', 5.7, 118, '2018-12-11', '2018-12-11'),
('sanketh@gmail.com', 'banana', 1.2, 92, '2018-12-11', '2018-12-11'),
('sanketh@gmail.com', 'guava', 2, 100, '2018-12-10', '2018-12-10'),
('sanketh@gmail.com', 'mango', 15, 100, '2018-12-10', '2018-12-10'),
('sanketh@gmail.com', 'melon', 10, 100, '2018-12-10', '2018-12-10'),
('sanketh@gmail.com', 'orange', 3, 100, '2018-12-11', '2018-12-10'),
('sanketh@gmail.com', 'papaya', 8, 100, '2018-12-10', '2018-12-10'),
('sanketh@gmail.com', 'pineapple', 20, 100, '2018-12-10', '2018-12-10'),
('sanketh@gmail.com', 'pomegranate', 12, 100, '2018-12-10', '2018-12-10');

-- --------------------------------------------------------

--
-- Table structure for table `retailers`
--

CREATE TABLE `retailers` (
  `name` varchar(26) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `password` varchar(15) NOT NULL,
  `pan` varchar(10) NOT NULL,
  `balance` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `retailers`
--

INSERT INTO `retailers` (`name`, `email`, `phone`, `password`, `pan`, `balance`) VALUES
('bubby', 'bubby@gmail.com', '8246271234', 'sanketh100', 'binche97g', '3945'),
('harshith', 'harshith@gmail.com', '8877554433', 'sanketh100', 'binche97f', '3914'),
('krishna sanketh chachidak', 'krishna@gmail.com', '9515076757', 'sanketh100', 'binche97h', '4259'),
('sanketh', 'sanketh@gmail.com', '9515076756', 'sanketh100', 'binche97a', '3500');

-- --------------------------------------------------------

--
-- Table structure for table `shoppers`
--

CREATE TABLE `shoppers` (
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `phone` varchar(13) NOT NULL,
  `address` varchar(60) NOT NULL,
  `password` varchar(20) NOT NULL,
  `balance` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `shoppers`
--

INSERT INTO `shoppers` (`name`, `email`, `phone`, `address`, `password`, `balance`) VALUES
('chandu tony', 'chandu@gmail.com', '9949699122', 'L B Nagar', 'sanketh100', '2678'),
('rashmith', 'rashmith@gmail.com', '9959699182', 'uppal', 'sanketh100', '3071'),
('Shruthi Gandham', 'shruthi@gmail.com', '8877554433', 'uppal', 'sanketh100', '3135');

-- --------------------------------------------------------

--
-- Table structure for table `stores`
--

CREATE TABLE `stores` (
  `email` varchar(30) NOT NULL,
  `name` varchar(26) NOT NULL,
  `address` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `stores`
--

INSERT INTO `stores` (`email`, `name`, `address`) VALUES
('bubby@gmail.com', 'bubby\'s Fruits', 'kothapet'),
('harshith@gmail.com', 'harshith\'s store', 'uppal'),
('krishna@gmail.com', 'krishna\'s store', 'hayath nagar'),
('sanketh@gmail.com', 'sanketh\'s store', 'hayath nagar');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `amount` float NOT NULL,
  `date` datetime NOT NULL,
  `creditor` varchar(30) NOT NULL,
  `debitor` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `amount`, `date`, `creditor`, `debitor`) VALUES
(1037, 101, '2018-12-11 11:14:48', 'bubby@gmail.com', 'shruthi@gmail.com'),
(1038, 264, '2018-12-11 11:15:12', 'krishna@gmail.com', 'shruthi@gmail.com'),
(1039, 186.5, '2018-12-11 11:15:47', 'bubby@gmail.com', 'chandu@gmail.com'),
(1040, 141.5, '2018-12-11 11:16:17', 'harshith@gmail.com', 'chandu@gmail.com'),
(1041, 495, '2018-12-11 11:16:39', 'krishna@gmail.com', 'chandu@gmail.com'),
(1042, 157, '2018-12-11 11:30:19', 'bubby@gmail.com', 'rashmith@gmail.com'),
(1043, 272, '2018-12-11 11:30:27', 'harshith@gmail.com', 'rashmith@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `fruits`
--
ALTER TABLE `fruits`
  ADD UNIQUE KEY `email` (`email`,`name`);

--
-- Indexes for table `retailers`
--
ALTER TABLE `retailers`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD UNIQUE KEY `pan` (`pan`);

--
-- Indexes for table `shoppers`
--
ALTER TABLE `shoppers`
  ADD PRIMARY KEY (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1044;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
