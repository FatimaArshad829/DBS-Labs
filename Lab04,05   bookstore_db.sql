-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 02, 2026 at 04:00 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bookstore_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `BookID` varchar(10) NOT NULL,
  `BookTitle` varchar(100) DEFAULT NULL,
  `PublisherID` int(11) DEFAULT NULL,
  `UnitPrice` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`BookID`, `BookTitle`, `PublisherID`, `UnitPrice`) VALUES
('B-1', 'SQL Basics', 1, 1200),
('B-2', 'Python 101', 2, 1500),
('B-3', 'Networks', 1, 1800);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustID` varchar(10) NOT NULL,
  `CustName` varchar(50) DEFAULT NULL,
  `CustEmail` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustID`, `CustName`, `CustEmail`) VALUES
('C-11', 'Bilal', 'bilal@x.com'),
('C-12', 'Areeba', 'areeba@x.com');

-- --------------------------------------------------------

--
-- Table structure for table `orderbook_1nf`
--

CREATE TABLE `orderbook_1nf` (
  `OrderID` varchar(10) NOT NULL,
  `OrderDate` date DEFAULT NULL,
  `CustID` varchar(10) DEFAULT NULL,
  `CustName` varchar(50) DEFAULT NULL,
  `CustEmail` varchar(50) DEFAULT NULL,
  `BookID` varchar(10) NOT NULL,
  `BookTitle` varchar(100) DEFAULT NULL,
  `Publisher` varchar(50) DEFAULT NULL,
  `UnitPrice` int(11) DEFAULT NULL,
  `Qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderbook_1nf`
--

INSERT INTO `orderbook_1nf` (`OrderID`, `OrderDate`, `CustID`, `CustName`, `CustEmail`, `BookID`, `BookTitle`, `Publisher`, `UnitPrice`, `Qty`) VALUES
('O-501', '2026-04-02', 'C-11', 'Bilal', 'bilal@x.com', 'B-1', 'SQL Basics', 'Pearson', 1200, 1),
('O-501', '2026-04-02', 'C-11', 'Bilal', 'bilal@x.com', 'B-2', 'Python 101', 'OReilly', 1500, 2),
('O-502', '2026-04-03', 'C-12', 'Areeba', 'areeba@x.com', 'B-1', 'SQL Basics', 'Pearson', 1200, 3),
('O-503', '2026-04-05', 'C-11', 'Bilal', 'bilal@x.com', 'B-2', 'Python 101', 'OReilly', 1500, 1),
('O-503', '2026-04-05', 'C-11', 'Bilal', 'bilal@x.com', 'B-3', 'Networks', 'Pearson', 1800, 1);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE `orderdetails` (
  `OrderID` varchar(10) NOT NULL,
  `BookID` varchar(10) NOT NULL,
  `Qty` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`OrderID`, `BookID`, `Qty`) VALUES
('O-501', 'B-1', 1),
('O-501', 'B-2', 2),
('O-502', 'B-1', 3),
('O-503', 'B-2', 1),
('O-503', 'B-3', 1);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderID` varchar(10) NOT NULL,
  `OrderDate` date DEFAULT NULL,
  `CustID` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`OrderID`, `OrderDate`, `CustID`) VALUES
('O-501', '2026-04-02', 'C-11'),
('O-502', '2026-04-03', 'C-12'),
('O-503', '2026-04-05', 'C-11');

-- --------------------------------------------------------

--
-- Table structure for table `publishers`
--

CREATE TABLE `publishers` (
  `PublisherID` int(11) NOT NULL,
  `PublisherName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `publishers`
--

INSERT INTO `publishers` (`PublisherID`, `PublisherName`) VALUES
(1, 'Pearson'),
(2, 'OReilly');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`BookID`),
  ADD KEY `PublisherID` (`PublisherID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustID`);

--
-- Indexes for table `orderbook_1nf`
--
ALTER TABLE `orderbook_1nf`
  ADD PRIMARY KEY (`OrderID`,`BookID`);

--
-- Indexes for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD PRIMARY KEY (`OrderID`,`BookID`),
  ADD KEY `BookID` (`BookID`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`OrderID`);

--
-- Indexes for table `publishers`
--
ALTER TABLE `publishers`
  ADD PRIMARY KEY (`PublisherID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `publishers`
--
ALTER TABLE `publishers`
  MODIFY `PublisherID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `books_ibfk_1` FOREIGN KEY (`PublisherID`) REFERENCES `publishers` (`PublisherID`);

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `orders` (`OrderID`),
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`BookID`) REFERENCES `books` (`BookID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
