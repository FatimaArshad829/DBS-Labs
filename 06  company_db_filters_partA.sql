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
-- Task A1
SELECT EmpID, EmpName, Salary
FROM Employee
WHERE Salary > 90000;

-- Task A2
SELECT EmpName, Salary
FROM Employee
WHERE Salary <= 75000;

-- Task A3
SELECT *
FROM Employee
WHERE City = 'Lahore'
AND Salary > 90000;

-- Task A4
SELECT EmpName, City
FROM Employee
WHERE City = 'Karachi'
OR City = 'Islamabad';

-- Task A5
SELECT *
FROM Employee
WHERE Gender = 'Female'
AND Department <> 'Engineering';

-- Task A6
SELECT *
FROM Employee
WHERE Gender = 'Male'
AND Salary >= 70000
AND Salary <= 90000;

-- Task A7
SELECT *
FROM Employee
WHERE JobTitle = 'Software Engineer'
OR Salary > 100000;

-- Task A8
SELECT *
FROM Employee
WHERE Department <> 'Marketing'
AND Department <> 'Sales';
