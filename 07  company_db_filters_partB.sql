-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2026 at 11:48 AM
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
-- Database: `companydb`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `EmpID` int(11) NOT NULL,
  `EmpName` varchar(100) DEFAULT NULL,
  `Gender` varchar(10) DEFAULT NULL,
  `Department` varchar(50) DEFAULT NULL,
  `JobTitle` varchar(100) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `City` varchar(50) DEFAULT NULL,
  `HireDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmpID`, `EmpName`, `Gender`, `Department`, `JobTitle`, `Salary`, `City`, `HireDate`) VALUES
(1, 'Ali Khan', 'Male', 'Engineering', 'Software Engineer', 95000.00, 'Lahore', '2021-03-15'),
(2, 'Sara Ahmed', 'Female', 'Marketing', 'Marketing Officer', 72000.00, 'Karachi', '2020-07-10'),
(3, 'Bilal Hussain', 'Male', 'Sales', 'Sales Executive', 68000.00, 'Islamabad', '2019-11-05'),
(4, 'Maham Noor', 'Female', 'HR', 'HR Manager', 88000.00, 'Lahore', '2022-01-20'),
(5, 'Usman Tariq', 'Male', 'Engineering', 'Senior Software Engineer', 120000.00, 'Karachi', '2018-09-12'),
(6, 'Areeba Khan', 'Female', 'Engineering', 'QA Engineer', 85000.00, NULL, '2023-04-18'),
(7, 'Daniyal Raza', 'Male', 'Finance', 'Accountant', 76000.00, 'Islamabad', '2021-06-25'),
(8, 'Minal Fatima', 'Female', 'Sales', 'Sales Manager', 99000.00, 'Lahore', '2020-12-01'),
(9, 'Hassan Ali', 'Male', 'Marketing', 'SEO Specialist', 81000.00, 'Karachi', '2022-08-30'),
(10, 'Maryam Imran', 'Female', 'Engineering', 'DevOps Engineer', 105000.00, 'Lahore', '2019-05-14');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmpID`);
COMMIT;

-- Task B1
SELECT *
FROM Employee
WHERE Salary BETWEEN 75000 AND 100000
ORDER BY Salary ASC;

-- Task B2
SELECT *
FROM Employee
WHERE HireDate BETWEEN '2020-01-01' AND '2022-12-31';

-- Task B3
SELECT *
FROM Employee
WHERE Salary NOT BETWEEN 80000 AND 100000;

-- Task B4
SELECT *
FROM Employee
WHERE City IN ('Lahore', 'Islamabad')
ORDER BY City ASC, Salary DESC;

-- Task B5
SELECT *
FROM Employee
WHERE Department NOT IN ('Engineering', 'Sales', 'HR');

-- Task B6
SELECT EmpName
FROM Employee
WHERE EmpName LIKE 'M%';

-- Task B7
SELECT *
FROM Employee
WHERE EmpName LIKE '%a%';

-- Task B8
SELECT *
FROM Employee
WHERE EmpName LIKE '%an';

-- Task B9
SELECT *
FROM Employee
WHERE JobTitle LIKE '%Engineer%'
AND Department <> 'Engineering';

-- Task B10
SELECT EmpName
FROM Employee
WHERE City IS NULL;

-- Task B11
SELECT *
FROM Employee
WHERE City IS NOT NULL
ORDER BY City ASC;

-- Task B12
SELECT EmpName, Salary
FROM Employee
ORDER BY Salary DESC
LIMIT 3;

-- Task B13
SELECT *
FROM Employee
ORDER BY HireDate DESC
LIMIT 5;

-- Task B14
SELECT Salary
FROM Employee
ORDER BY Salary ASC
LIMIT 3;

-- Task B15
SELECT *
FROM Employee
ORDER BY Department ASC, HireDate ASC;