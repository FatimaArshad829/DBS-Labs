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
-- Database: `agg_lab`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer , product, orderitem, `
--
CREATE TABLE Customer (
    CustID INT PRIMARY KEY,
    CustName VARCHAR(60) NOT NULL,
    City VARCHAR(30),
    JoinDate DATE
);

CREATE TABLE Product (
    ProdID INT PRIMARY KEY,
    ProdName VARCHAR(60) NOT NULL,
    Category VARCHAR(30),
    Price DECIMAL(10,2),
    StockQty INT
);

CREATE TABLE OrderItem (
    OrderID INT PRIMARY KEY,
    CustID INT,
    ProdID INT,
    Quantity INT,
    OrderDate DATE,
    FOREIGN KEY (CustID) REFERENCES Customer(CustID),
    FOREIGN KEY (ProdID) REFERENCES Product(ProdID)
);
INSERT INTO Customer VALUES
(1, 'Ali Khan', 'Lahore', '2022-01-15'),
(2, 'Sara Iqbal', 'Karachi', '2022-04-22'),
(3, 'Hamza Raza', 'Lahore', '2023-02-10'),
(4, 'Ayesha Noor', 'Islamabad', '2023-05-18'),
(5, 'Bilal Ahmed', 'Karachi', '2023-09-01'),
(6, 'Fatima Sheikh', NULL, '2024-01-12'),
(7, 'Usman Tariq', 'Lahore', '2024-06-30'),
(8, 'Maira Javed', 'Islamabad', '2024-08-25');

INSERT INTO Product VALUES
(101, 'Laptop Pro 15', 'Electronics', 185000.00, 12),
(102, 'Wireless Mouse', 'Electronics', 2500.00, 50),
(103, 'USB-C Cable', 'Electronics', 800.00, 100),
(104, 'Office Chair', 'Furniture', 18500.00, 8),
(105, 'Standing Desk', 'Furniture', 45000.50, 5),
(106, 'Notebook A4', 'Stationery', 350.00, 200),
(107, 'Ballpoint Pen 10pk', 'Stationery', 450.00, 150),
(108, 'Coffee Beans 1kg', 'Grocery', 1899.99, 30),
(109, 'Green Tea Box', 'Grocery', 650.00, 45),
(110, 'Bluetooth Speaker', 'Electronics', 7500.00, 18);

INSERT INTO OrderItem VALUES
(1001, 1, 101, 1, '2023-03-10'),
(1002, 1, 102, 2, '2023-03-10'),
(1003, 2, 104, 1, '2023-05-22'),
(1004, 2, 106, 5, '2023-05-22'),
(1005, 3, 101, 1, '2023-08-15'),
(1006, 3, 110, 1, '2023-08-15'),
(1007, 4, 108, 3, '2023-11-02'),
(1008, 5, 103, 4, '2024-01-20'),
(1009, 5, 102, 1, '2024-01-20'),
(1010, 6, 105, 1, '2024-02-14'),
(1011, 7, 107, 2, '2024-04-08'),
(1012, 7, 106, 10, '2024-04-08'),
(1013, 7, 109, 3, '2024-07-19'),
(1014, 2, 110, 1, '2024-09-05'),
(1015, 3, 108, 2, '2024-10-11');

/*Part A — A1 to A10*/

-- Task A1
SELECT
    (SELECT COUNT(*) FROM Customer) AS TotalCustomers,
    (SELECT COUNT(*) FROM Product) AS TotalProducts,
    (SELECT COUNT(*) FROM OrderItem) AS TotalOrders;


-- Task A2
SELECT
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM Product;


-- Task A3
SELECT
    ROUND(AVG(Price), 2) AS AveragePrice
FROM Product;


-- Task A4
SELECT
    SUM(StockQty) AS TotalStockQuantity
FROM Product;


-- Task A5
SELECT
    COUNT(DISTINCT City) AS DistinctCities
FROM Customer
WHERE City IS NOT NULL;


-- Task A6
SELECT
    COUNT(DISTINCT Category) AS DistinctCategories
FROM Product;


-- Task A7
SELECT
    COUNT(City) AS CustomersWithCity
FROM Customer;

SELECT
    COUNT(*) - COUNT(City) AS CustomersWithoutCity
FROM Customer;


-- Task A8
SELECT
    MIN(OrderDate) AS EarliestOrderDate,
    MAX(OrderDate) AS LatestOrderDate
FROM OrderItem;


-- Task A9
SELECT
    SUM(oi.Quantity * p.Price) AS TotalRevenue
FROM OrderItem oi
JOIN Product p
    ON oi.ProdID = p.ProdID;


-- Task A10
SELECT
    ROUND(AVG(Quantity), 2) AS AverageQuantity
FROM OrderItem;

/*Part B — B1 to B17*/

-- Task B1
SELECT
    City,
    COUNT(*) AS NumCustomers
FROM Customer
GROUP BY City
ORDER BY NumCustomers DESC;


-- Task B2
SELECT
    Category,
    COUNT(*) AS NumProducts
FROM Product
GROUP BY Category
ORDER BY NumProducts DESC;


-- Task B3
SELECT
    Category,
    ROUND(AVG(Price), 2) AS AvgPrice,
    MIN(Price) AS MinPrice,
    MAX(Price) AS MaxPrice
FROM Product
GROUP BY Category
ORDER BY AvgPrice DESC;


-- Task B4
SELECT
    Category,
    SUM(StockQty) AS TotalStock
FROM Product
GROUP BY Category
ORDER BY TotalStock DESC;


-- Task B5
SELECT
    YEAR(OrderDate) AS Year,
    COUNT(*) AS NumOrders
FROM OrderItem
GROUP BY YEAR(OrderDate)
ORDER BY Year;


-- Task B6
SELECT
    MONTH(OrderDate) AS Month,
    COUNT(*) AS NumOrders
FROM OrderItem
WHERE YEAR(OrderDate) = 2024
GROUP BY MONTH(OrderDate)
ORDER BY Month;


-- Task B7
SELECT
    Category,
    ROUND(AVG(Price), 2) AS AvgPrice
FROM Product
GROUP BY Category
HAVING AVG(Price) > 5000;


-- Task B8
SELECT
    City,
    COUNT(*) AS NumCustomers
FROM Customer
WHERE City IS NOT NULL
GROUP BY City
HAVING COUNT(*) > 1;


-- Task B9
SELECT
    c.CustID,
    c.CustName,
    COUNT(oi.OrderID) AS NumOrders
FROM Customer c
LEFT JOIN OrderItem oi
    ON c.CustID = oi.CustID
GROUP BY c.CustID, c.CustName
ORDER BY NumOrders DESC;


-- Task B10
SELECT
    p.ProdName,
    COALESCE(SUM(oi.Quantity), 0) AS TotalQty
FROM Product p
LEFT JOIN OrderItem oi
    ON p.ProdID = oi.ProdID
GROUP BY p.ProdID, p.ProdName
ORDER BY TotalQty DESC;


-- Task B11
SELECT
    p.Category,
    SUM(oi.Quantity * p.Price) AS Revenue
FROM OrderItem oi
JOIN Product p
    ON oi.ProdID = p.ProdID
GROUP BY p.Category
ORDER BY Revenue DESC;


-- Task B12
SELECT
    c.CustName,
    COALESCE(SUM(oi.Quantity * p.Price), 0) AS TotalSpend
FROM Customer c
LEFT JOIN OrderItem oi
    ON c.CustID = oi.CustID
LEFT JOIN Product p
    ON oi.ProdID = p.ProdID
GROUP BY c.CustID, c.CustName
ORDER BY TotalSpend DESC;


-- Task B13
SELECT
    c.CustName,
    SUM(oi.Quantity * p.Price) AS TotalSpend
FROM Customer c
JOIN OrderItem oi
    ON c.CustID = oi.CustID
JOIN Product p
    ON oi.ProdID = p.ProdID
GROUP BY c.CustID, c.CustName
HAVING SUM(oi.Quantity * p.Price) > 50000;


-- Task B14
SELECT
    c.City,
    COUNT(DISTINCT c.CustID) AS NumCustomers,
    COALESCE(SUM(oi.Quantity * p.Price), 0) AS TotalRevenue
FROM Customer c
LEFT JOIN OrderItem oi
    ON c.CustID = oi.CustID
LEFT JOIN Product p
    ON oi.ProdID = p.ProdID
WHERE c.City IS NOT NULL
GROUP BY c.City
HAVING COUNT(DISTINCT c.CustID) > 1;


-- Task B15
SELECT
    p.ProdName,
    SUM(oi.Quantity) AS TotalQty
FROM Product p
JOIN OrderItem oi
    ON p.ProdID = oi.ProdID
GROUP BY p.ProdID, p.ProdName
ORDER BY TotalQty DESC
LIMIT 3;


-- Task B16
SELECT
    YEAR(oi.OrderDate) AS Year,
    SUM(oi.Quantity * p.Price) AS Revenue
FROM OrderItem oi
JOIN Product p
    ON oi.ProdID = p.ProdID
GROUP BY YEAR(oi.OrderDate)
ORDER BY Year;


-- Task B17
SELECT
    ROUND(AVG(OrderValue), 2) AS AverageOrderValue
FROM (
    SELECT
        OrderID,
        SUM(Quantity * p.Price) AS OrderValue
    FROM OrderItem oi
    JOIN Product p
        ON oi.ProdID = p.ProdID
    GROUP BY OrderID
) AS OrderTotals;