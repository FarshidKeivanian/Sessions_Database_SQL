-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 05, 2024 at 09:42 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `farshid`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CUS_CODE` varchar(10) NOT NULL,
  `CUS_LNAME` varchar(50) DEFAULT NULL,
  `CUS_FNAME` varchar(50) DEFAULT NULL,
  `CUS_INITIAL` char(1) DEFAULT NULL,
  `CUS_AREACODE` char(5) DEFAULT NULL,
  `CUS_PHONE` varchar(15) DEFAULT NULL,
  `CUS_BALANCE` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CUS_CODE`, `CUS_LNAME`, `CUS_FNAME`, `CUS_INITIAL`, `CUS_AREACODE`, `CUS_PHONE`, `CUS_BALANCE`) VALUES
('C001', 'Smith', 'John', 'D', '02', '123456789', 100.00),
('C002', 'Doe', 'Jane', 'M', '03', '987654321', 200.00);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `INV_NUMBER` varchar(10) NOT NULL,
  `CUS_CODE` varchar(10) DEFAULT NULL,
  `INV_DATE` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`INV_NUMBER`, `CUS_CODE`, `INV_DATE`) VALUES
('INV001', 'C001', '2023-05-05'),
('INV002', 'C002', '2023-05-06');

-- --------------------------------------------------------

--
-- Table structure for table `line`
--

CREATE TABLE `line` (
  `INV_NUMBER` varchar(10) NOT NULL,
  `LINE_NUMBER` int(11) NOT NULL,
  `P_CODE` varchar(10) DEFAULT NULL,
  `LINE_UNITS` int(11) DEFAULT NULL,
  `LINE_PRICE` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `line`
--

INSERT INTO `line` (`INV_NUMBER`, `LINE_NUMBER`, `P_CODE`, `LINE_UNITS`, `LINE_PRICE`) VALUES
('INV001', 1, 'P100', 2, 40.00),
('INV002', 1, 'P101', 1, 25.00);

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `P_CODE` varchar(10) NOT NULL,
  `P_DESCRIPT` varchar(100) DEFAULT NULL,
  `P_INDATE` date DEFAULT NULL,
  `P_QOH` int(11) DEFAULT NULL,
  `P_MIN` int(11) DEFAULT NULL,
  `P_PRICE` decimal(10,2) DEFAULT NULL,
  `P_DISCOUNT` decimal(5,2) DEFAULT NULL,
  `V_CODE` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`P_CODE`, `P_DESCRIPT`, `P_INDATE`, `P_QOH`, `P_MIN`, `P_PRICE`, `P_DISCOUNT`, `V_CODE`) VALUES
('P100', 'Woolen Hat', '2023-05-01', 100, 10, 20.00, 1.50, 'V001'),
('P101', 'Silk Scarf', '2023-04-15', 50, 5, 25.00, 2.00, 'V002');

-- --------------------------------------------------------

--
-- Table structure for table `vendor`
--

CREATE TABLE `vendor` (
  `V_CODE` varchar(10) NOT NULL,
  `V_NAME` varchar(50) DEFAULT NULL,
  `V_CONTACT` varchar(50) DEFAULT NULL,
  `V_AREACODE` char(5) DEFAULT NULL,
  `V_PHONE` varchar(15) DEFAULT NULL,
  `V_STATE` char(2) DEFAULT NULL,
  `V_ORDER` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `vendor`
--

INSERT INTO `vendor` (`V_CODE`, `V_NAME`, `V_CONTACT`, `V_AREACODE`, `V_PHONE`, `V_STATE`, `V_ORDER`) VALUES
('V001', 'Sydney Supplies', 'Alice Johnson', '02', '123123123', 'NS', 5000.00),
('V002', 'Melbourne Goods', 'Bob Smith', '03', '321321321', 'VI', 3000.00);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CUS_CODE`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`INV_NUMBER`),
  ADD KEY `CUS_CODE` (`CUS_CODE`);

--
-- Indexes for table `line`
--
ALTER TABLE `line`
  ADD PRIMARY KEY (`INV_NUMBER`,`LINE_NUMBER`),
  ADD KEY `P_CODE` (`P_CODE`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`P_CODE`),
  ADD KEY `V_CODE` (`V_CODE`);

--
-- Indexes for table `vendor`
--
ALTER TABLE `vendor`
  ADD PRIMARY KEY (`V_CODE`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`CUS_CODE`) REFERENCES `customer` (`CUS_CODE`);

--
-- Constraints for table `line`
--
ALTER TABLE `line`
  ADD CONSTRAINT `line_ibfk_1` FOREIGN KEY (`INV_NUMBER`) REFERENCES `invoice` (`INV_NUMBER`),
  ADD CONSTRAINT `line_ibfk_2` FOREIGN KEY (`P_CODE`) REFERENCES `product` (`P_CODE`);

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`V_CODE`) REFERENCES `vendor` (`V_CODE`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
