-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2026 at 10:14 AM
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
-- Database: `scalar_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CustID` int(11) NOT NULL,
  `CustName` varchar(60) NOT NULL,
  `Email` varchar(80) DEFAULT NULL,
  `City` varchar(30) DEFAULT NULL,
  `Phone` varchar(20) DEFAULT NULL,
  `JoinDate` date DEFAULT NULL,
  `DOB` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CustID`, `CustName`, `Email`, `City`, `Phone`, `JoinDate`, `DOB`) VALUES
(1, ' Ali Khan ', 'ali.khan@MAIL.com', 'Lahore', '0300-1112233', '2022-01-15', '1995-04-12'),
(2, 'Sara Iqbal', 'sara@example.com', 'Karachi', '0301-4445566', '2022-04-22', '1998-11-20'),
(3, 'HAMZA RAZA', 'hamza@example.com', 'Lahore', '0302-7778899', '2023-02-10', '1997-08-05'),
(4, 'Ayesha Noor', NULL, 'Islamabad', '0303-1234567', '2023-05-18', '1999-02-14'),
(5, 'bilal ahmed', 'bilal@MAIL.COM', 'Karachi', '0304-2345678', '2023-09-01', '2000-06-30'),
(6, 'Fatima Sheikh', 'fatima@example.com', NULL, '0305-3456789', '2024-01-12', '1996-10-25'),
(7, 'Usman Tariq', 'usman@example.com', 'Lahore', NULL, '2024-06-30', '2001-03-18'),
(8, 'Maira Javed', 'maira@example.com', 'Islamabad', '0307-5678901', '2024-08-25', '1994-12-09');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `ProdID` int(11) NOT NULL,
  `ProdName` varchar(60) NOT NULL,
  `Category` varchar(30) DEFAULT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `StockQty` int(11) DEFAULT NULL,
  `LaunchDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`ProdID`, `ProdName`, `Category`, `Price`, `StockQty`, `LaunchDate`) VALUES
(101, 'Laptop Pro 15', 'Electronics', 185000.00, 12, '2023-03-10'),
(102, 'Wireless Mouse', 'Electronics', 2500.00, 50, '2022-07-22'),
(103, 'USB-C Cable', 'Electronics', 800.00, 100, '2021-11-05'),
(104, 'Office Chair', 'Furniture', 18500.00, 8, '2023-01-15'),
(105, 'Standing Desk', 'Furniture', 45000.50, 5, '2024-02-28'),
(106, 'Notebook A4', 'Stationery', 350.00, 200, '2020-04-01'),
(107, 'Ballpoint Pen 10pk', 'Stationery', 450.00, 150, '2020-04-01'),
(108, 'Coffee Beans 1kg', 'Grocery', 1899.99, 30, '2023-09-20'),
(109, 'Green Tea Box', 'Grocery', 650.00, 45, '2022-12-12'),
(110, 'Bluetooth Speaker', 'Electronics', 7500.00, 18, '2024-05-18');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CustID`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProdID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*Task A1 — Trim customer name*/

SELECT 
    CustID,
    CustName AS OriginalName,
    TRIM(CustName) AS CleanedName
FROM Customers;

/* Task A2 — Uppercase and lowercase*/

SELECT 
    CustID,
    UPPER(CustName) AS UpperName,
    LOWER(CustName) AS LowerName
FROM Customers;

/* Task A3 — Trimmed name + number of characters*/

SELECT 
    CustID,
    TRIM(CustName) AS TrimmedName,
    CHAR_LENGTH(TRIM(CustName)) AS NameLength
FROM Customers;

/* Task A4 — Greeting*/

SELECT 
    CustID,
    CONCAT('Dear ', TRIM(CustName), ', welcome!') AS Greeting
FROM Customers;

/* Task A5 — Email username*/

SELECT 
    CustName,
    SUBSTRING_INDEX(Email, '@', 1) AS Username
FROM Customers
WHERE Email IS NOT NULL
  AND Email <> '';

/* Task A6 — Email domain*/

SELECT 
    CustName,
    SUBSTRING_INDEX(Email, '@', -1) AS Domain
FROM Customers
WHERE Email IS NOT NULL
  AND Email <> '';

/* Task A7 — First 3 characters of customer name*/

SELECT 
    CustID,
    LEFT(TRIM(CustName), 3) AS First3Characters
FROM Customers;

/* Task A8 — Mask phone number*/

SELECT 
    CustID,
    CustName,
    CONCAT(LEFT(Phone, 4), 'XXX-XXXX') AS MaskedPhone
FROM Customers
WHERE Phone IS NOT NULL
  AND Phone <> '';

/*Task A9 — Replace spaces with hyphens in product name*/

SELECT 
    ProdID,
    REPLACE(ProdName, ' ', '-') AS SlugName
FROM Products;

/* Task A10 — Pad ProdID to 5 digits*/

SELECT 
    ProdID,
    LPAD(ProdID, 5, '0') AS PaddedProdID
FROM Products;

Example: 101 → 00101

/*Task A11 — Product names containing "Pro" + position*/

SELECT 
    ProdID,
    ProdName,
    LOCATE('Pro', ProdName) AS ProPosition
FROM Products
WHERE LOCATE('Pro', ProdName) > 0;

Agar pro, PRO, etc. bhi match karne hain:

SELECT 
    ProdID,
    ProdName,
    LOCATE('pro', LOWER(ProdName)) AS ProPosition
FROM Products
WHERE LOCATE('pro', LOWER(ProdName)) > 0;

/* Task A12 — Customer ka first name*/

SELECT 
    CustID,
    SUBSTRING_INDEX(TRIM(CustName), ' ', 1) AS FirstName
FROM Customers;