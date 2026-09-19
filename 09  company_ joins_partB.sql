-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 16, 2026 at 06:56 PM
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
-- Database: `company`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `EmpID` int(11) NOT NULL,
  `ProjectID` int(11) NOT NULL,
  `WeeklyHours` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`EmpID`, `ProjectID`, `WeeklyHours`) VALUES
(1, 1, 20),
(2, 3, 15),
(3, 2, 18),
(6, 1, 25),
(7, 4, 12);

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `DeptID` int(11) NOT NULL,
  `DeptName` varchar(100) DEFAULT NULL,
  `Location` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`DeptID`, `DeptName`, `Location`) VALUES
(1, 'Engineering', 'Lahore'),
(2, 'HR', 'Karachi'),
(3, 'Marketing', 'Islamabad'),
(4, 'Finance', 'Lahore');

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `EmpID` int(11) NOT NULL,
  `EmpName` varchar(100) DEFAULT NULL,
  `Salary` decimal(10,2) DEFAULT NULL,
  `City` varchar(100) DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL,
  `ManagerID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`EmpID`, `EmpName`, `Salary`, `City`, `DeptID`, `ManagerID`) VALUES
(1, 'Ali Khan', 95000.00, 'Lahore', 1, NULL),
(2, 'Sara Ahmed', 72000.00, 'Karachi', 2, 1),
(3, 'Bilal Hussain', 68000.00, 'Islamabad', 3, 1),
(4, 'Maham Noor', 88000.00, 'Lahore', 2, 1),
(5, 'Usman Tariq', 120000.00, 'Karachi', 1, NULL),
(6, 'Areeba Khan', 85000.00, 'Lahore', 1, 5),
(7, 'Daniyal Raza', 76000.00, 'Islamabad', 4, 5);

-- --------------------------------------------------------

--
-- Table structure for table `project`
--

CREATE TABLE `project` (
  `ProjectID` int(11) NOT NULL,
  `ProjectName` varchar(100) DEFAULT NULL,
  `DeptID` int(11) DEFAULT NULL,
  `StartDate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `project`
--

INSERT INTO `project` (`ProjectID`, `ProjectName`, `DeptID`, `StartDate`) VALUES
(1, 'Mobile App', 1, '2024-01-10'),
(2, 'Website Redesign', 3, '2024-03-15'),
(3, 'HR System', 2, '2023-11-20'),
(4, 'Finance Tracker', NULL, '2024-02-05');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`EmpID`,`ProjectID`),
  ADD KEY `ProjectID` (`ProjectID`);

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`DeptID`);

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`EmpID`),
  ADD KEY `DeptID` (`DeptID`);

--
-- Indexes for table `project`
--
ALTER TABLE `project`
  ADD PRIMARY KEY (`ProjectID`),
  ADD KEY `DeptID` (`DeptID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `assignment_ibfk_1` FOREIGN KEY (`EmpID`) REFERENCES `employee` (`EmpID`),
  ADD CONSTRAINT `assignment_ibfk_2` FOREIGN KEY (`ProjectID`) REFERENCES `project` (`ProjectID`);

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`);

--
-- Constraints for table `project`
--
ALTER TABLE `project`
  ADD CONSTRAINT `project_ibfk_1` FOREIGN KEY (`DeptID`) REFERENCES `department` (`DeptID`);
COMMIT;


-- =========================
-- PART B — SELF & MULTI TABLE JOINS
-- =========================

-- Task B1
SELECT e.EmpName AS EmployeeName,
m.EmpName AS ManagerName
FROM Employee e
LEFT JOIN Employee m
ON e.ManagerID = m.EmpID;

-- Task B2
SELECT e.EmpName,
e.Salary AS EmployeeSalary,
m.EmpName AS ManagerName,
m.Salary AS ManagerSalary
FROM Employee e
INNER JOIN Employee m
ON e.ManagerID = m.EmpID
WHERE e.Salary > m.Salary;

-- Task B3
SELECT e.EmpName,
m.EmpName AS ManagerName,
d1.DeptName AS EmployeeDepartment,
d2.DeptName AS ManagerDepartment
FROM Employee e
INNER JOIN Employee m
ON e.ManagerID = m.EmpID
INNER JOIN Department d1
ON e.DeptID = d1.DeptID
INNER JOIN Department d2
ON m.DeptID = d2.DeptID
WHERE e.DeptID <> m.DeptID;

-- Task B4
SELECT e.EmpName,
p.ProjectName,
a.WeeklyHours
FROM Employee e
INNER JOIN Assignment a
ON e.EmpID = a.EmpID
INNER JOIN Project p
ON a.ProjectID = p.ProjectID;

-- Task B5
SELECT e.EmpName,
p.ProjectName,
d.DeptName
FROM Assignment a
INNER JOIN Employee e
ON a.EmpID = e.EmpID
INNER JOIN Project p
ON a.ProjectID = p.ProjectID
LEFT JOIN Department d
ON p.DeptID = d.DeptID;

-- Task B6
SELECT e.EmpName,
a.WeeklyHours
FROM Employee e
INNER JOIN Assignment a
ON e.EmpID = a.EmpID
INNER JOIN Project p
ON a.ProjectID = p.ProjectID
WHERE p.ProjectName = 'Mobile App';

-- Task B7
SELECT e.EmpName,
p.ProjectName,
a.WeeklyHours
FROM Employee e
LEFT JOIN Assignment a
ON e.EmpID = a.EmpID
LEFT JOIN Project p
ON a.ProjectID = p.ProjectID
WHERE e.City = 'Lahore';

-- Task B8
SELECT DISTINCT e.EmpName
FROM Employee e
INNER JOIN Assignment a
ON e.EmpID = a.EmpID
INNER JOIN Project p
ON a.ProjectID = p.ProjectID
WHERE e.DeptID <> p.DeptID;

-- Task B9
SELECT d.DeptName,
p.ProjectName
FROM Department d
LEFT JOIN Project p
ON d.DeptID = p.DeptID
AND YEAR(p.StartDate) = 2024;

-- Task B10
SELECT e.EmpName,
IFNULL(SUM(a.WeeklyHours),0) AS TotalHours
FROM Employee e
LEFT JOIN Assignment a
ON e.EmpID = a.EmpID
GROUP BY e.EmpName;

