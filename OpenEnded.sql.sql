-- =========================================================================
-- CARGO RENTALS — Car Rental Management System
-- DBMS Open-Ended Lab
-- Student: Fatima Arshad | Roll No: 2024-SE-24
-- =========================================================================
-- Sections in this file:
--   1. Database Creation
--   2. Reset Tables (safe re-run)
--   3. Table Creation (Schema, Keys, Constraints)
--   4. Sample Data Insertion
--   5. Task 3 — JOIN Queries
--   6. Task 4 — View
--   7. Task 5 — Trigger
--   8. Task 6 — Stored Procedure
--   9. Task 7 — Optimization (Indexes)
--  10. Management Reports
--  11. Final Verification
-- =========================================================================


-- =========================================================================
-- 1. DATABASE CREATION
-- =========================================================================

CREATE DATABASE IF NOT EXISTS cargo_rentals;
USE cargo_rentals;


-- =========================================================================
-- 2. RESET TABLES (safe to re-run this file from scratch)
-- =========================================================================

DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Rental;
DROP TABLE IF EXISTS Vehicle;
DROP TABLE IF EXISTS Customer;


-- =========================================================================
-- 3. TABLE CREATION (SCHEMA, KEYS, CONSTRAINTS)
-- =========================================================================

-- 3.1 Customer
CREATE TABLE Customer (
    CustomerID        INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName      VARCHAR(100) NOT NULL,
    Phone             VARCHAR(20) NOT NULL UNIQUE,
    Email             VARCHAR(100) UNIQUE,
    CNIC              VARCHAR(20) UNIQUE,
    City              VARCHAR(50) NOT NULL,
    RegistrationDate  DATE NOT NULL DEFAULT (CURRENT_DATE)
);

-- 3.2 Vehicle
CREATE TABLE Vehicle (
    VehicleID       INT PRIMARY KEY AUTO_INCREMENT,
    VehicleNumber   VARCHAR(20) NOT NULL UNIQUE,
    VehicleModel    VARCHAR(50) NOT NULL,
    VehicleYear     INT NOT NULL,
    DailyRate       DECIMAL(10,2) NOT NULL,
    VehicleStatus   VARCHAR(20) NOT NULL DEFAULT 'Available',
    CHECK (DailyRate > 0),
    CHECK (VehicleYear BETWEEN 2000 AND 2030),
    CHECK (VehicleStatus IN ('Available', 'Maintenance'))
);

-- 3.3 Rental
CREATE TABLE Rental (
    RentalID       INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID     INT NOT NULL,
    VehicleID      INT NOT NULL,
    RentalDate     DATE NOT NULL,
    ReturnDate     DATE NULL,
    DailyRate      DECIMAL(10,2) NOT NULL,
    RentalCharge   DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
    FOREIGN KEY (VehicleID) REFERENCES Vehicle(VehicleID),
    CHECK (DailyRate > 0),
    CHECK (RentalCharge >= 0),
    CHECK (ReturnDate IS NULL OR ReturnDate >= RentalDate)
);

-- 3.4 Payment
CREATE TABLE Payment (
    PaymentID       INT PRIMARY KEY AUTO_INCREMENT,
    RentalID        INT NOT NULL UNIQUE,
    PaymentAmount   DECIMAL(10,2) NOT NULL,
    PaymentDate     DATE NOT NULL DEFAULT (CURRENT_DATE),
    PaymentMethod   VARCHAR(20) NOT NULL DEFAULT 'Cash',
    FOREIGN KEY (RentalID) REFERENCES Rental(RentalID),
    CHECK (PaymentAmount >= 0),
    CHECK (PaymentMethod IN ('Cash', 'Card', 'Bank Transfer', 'Online'))
);


-- =========================================================================
-- 4. SAMPLE DATA INSERTION
-- =========================================================================

-- 4.1 Customers
INSERT INTO Customer (CustomerName, Phone, Email, CNIC, City) VALUES
('Ali Khan',     '0300-1234567', 'ali.khan@gmail.com',    '37405-1234567-1', 'Lahore'),
('Sara Ahmed',   '0311-2345678', 'sara.ahmed@gmail.com',  '35202-2345678-2', 'Islamabad'),
('Hamza Raza',   '0322-3456789', 'hamza.raza@gmail.com',  '61101-3456789-3', 'Karachi'),
('Ayesha Noor',  '0333-4567890', 'ayesha.noor@gmail.com', '37405-4567890-4', 'Lahore'),
('Bilal Ahmed',  '0344-5678901', 'bilal.ahmed@gmail.com', '35202-5678901-5', 'Rawalpindi'),
('Fatima Ali',   '0355-6789012', 'fatima.ali@gmail.com',  '61101-6789012-6', 'Multan'),
('Usman Tariq',  '0366-7890123', 'usman.tariq@gmail.com', '37405-7890123-7', 'Peshawar');

-- 4.2 Vehicles
INSERT INTO Vehicle (VehicleNumber, VehicleModel, VehicleYear, DailyRate, VehicleStatus) VALUES
('ABC-123', 'Toyota Corolla',  2022, 5000.00,  'Available'),
('XYZ-456', 'Honda Civic',     2023, 6500.00,  'Available'),
('LEA-789', 'Suzuki Swift',    2021, 4000.00,  'Available'),
('ISB-321', 'Toyota Yaris',    2022, 4500.00,  'Available'),
('KHI-654', 'Honda City',      2023, 5500.00,  'Available'),
('RWP-987', 'Suzuki Wagon R',  2020, 3500.00,  'Maintenance'),
('PSH-555', 'Toyota Fortuner', 2024, 12000.00, 'Available');

-- 4.3 Rentals (RentalID 4 and 5 are active -> ReturnDate is NULL)
INSERT INTO Rental (CustomerID, VehicleID, RentalDate, ReturnDate, DailyRate, RentalCharge) VALUES
(1, 1, '2026-09-01', '2026-09-04', 5000.00, 15000.00),
(2, 2, '2026-09-05', '2026-09-08', 6500.00, 19500.00),
(3, 3, '2026-09-10', '2026-09-12', 4000.00, 8000.00),
(4, 4, '2026-09-11', NULL,         4500.00, 0.00),
(5, 5, '2026-09-12', NULL,         5500.00, 0.00);

-- 4.4 Payments (only for the 3 closed rentals)
INSERT INTO Payment (RentalID, PaymentAmount, PaymentMethod) VALUES
(1, 15000.00, 'Cash'),
(2, 19500.00, 'Card'),
(3, 8000.00,  'Online');


-- =========================================================================
-- 5. TASK 3 — JOIN QUERIES
-- =========================================================================

-- 5.1 Query 1: Customer, vehicle, rental date, and return date for every rental
SELECT c.CustomerName, v.VehicleNumber, v.VehicleModel,
       r.RentalDate, r.ReturnDate
FROM Rental r
INNER JOIN Customer c ON r.CustomerID = c.CustomerID
INNER JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY r.RentalDate;

-- 5.2 Query 2: All customers and vehicles rented (incl. customers with zero rentals)
SELECT c.CustomerName, v.VehicleNumber, v.VehicleModel,
       r.RentalDate, r.ReturnDate
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
LEFT JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY c.CustomerName;

-- 5.3 Query 3: All vehicles and current rental info (incl. vehicles not currently rented)
SELECT v.VehicleNumber, v.VehicleModel, v.VehicleStatus,
       c.CustomerName, r.RentalDate, r.ReturnDate
FROM Vehicle v
LEFT JOIN Rental r
    ON v.VehicleID = r.VehicleID
    AND r.ReturnDate IS NULL
LEFT JOIN Customer c ON r.CustomerID = c.CustomerID
ORDER BY v.VehicleNumber;

-- 5.4 Query 4: Total rentals per customer (incl. customers with zero rentals)
SELECT c.CustomerID, c.CustomerName,
       COUNT(r.RentalID) AS TotalRentals
FROM Customer c
LEFT JOIN Rental r ON c.CustomerID = r.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalRentals DESC;


-- =========================================================================
-- 6. TASK 4 — VIEW
-- =========================================================================

DROP VIEW IF EXISTS RentalReport;

CREATE VIEW RentalReport AS
SELECT
    r.RentalID,
    c.CustomerName,
    c.Phone,
    v.VehicleNumber,
    v.VehicleModel,
    r.RentalDate,
    r.ReturnDate,
    r.DailyRate,
    r.RentalCharge,
    p.PaymentAmount,
    p.PaymentDate,
    p.PaymentMethod
FROM Rental r
INNER JOIN Customer c ON r.CustomerID = c.CustomerID
INNER JOIN Vehicle v ON r.VehicleID = v.VehicleID
LEFT JOIN Payment p ON r.RentalID = p.RentalID;

-- Example usage:
-- SELECT * FROM RentalReport;


-- =========================================================================
-- 7. TASK 5 — TRIGGER
-- =========================================================================

DROP TRIGGER IF EXISTS PreventDoubleBooking;

DELIMITER //

CREATE TRIGGER PreventDoubleBooking
BEFORE INSERT ON Rental
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Rental
        WHERE VehicleID = NEW.VehicleID
        AND ReturnDate IS NULL
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle is already rented and cannot be booked again.';
    END IF;
END //

DELIMITER ;

-- 7.1 Trigger test (expected to be REJECTED — vehicle 4 already has an active rental):
-- INSERT INTO Rental (CustomerID, VehicleID, RentalDate, ReturnDate, DailyRate, RentalCharge)
-- VALUES (6, 4, '2026-09-15', NULL, 4500.00, 0.00);


-- =========================================================================
-- 8. TASK 6 — STORED PROCEDURE
-- =========================================================================

DROP PROCEDURE IF EXISTS RegisterRental;

DELIMITER //

CREATE PROCEDURE RegisterRental(
    IN p_CustomerID INT,
    IN p_VehicleID INT,
    IN p_RentalDate DATE,
    IN p_ReturnDate DATE
)
BEGIN
    DECLARE v_DailyRate DECIMAL(10,2);
    DECLARE v_RentalDays INT;
    DECLARE v_RentalCharge DECIMAL(10,2);
    DECLARE v_ActiveRental INT DEFAULT 0;

    IF NOT EXISTS (
        SELECT 1 FROM Customer
        WHERE CustomerID = p_CustomerID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Customer does not exist.';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Vehicle
        WHERE VehicleID = p_VehicleID
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle does not exist.';
    END IF;

    SELECT COUNT(*)
    INTO v_ActiveRental
    FROM Rental
    WHERE VehicleID = p_VehicleID
    AND ReturnDate IS NULL;

    IF v_ActiveRental > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Vehicle is currently rented.';
    END IF;

    SELECT DailyRate
    INTO v_DailyRate
    FROM Vehicle
    WHERE VehicleID = p_VehicleID;

    IF p_ReturnDate < p_RentalDate THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return date cannot be before rental date.';
    END IF;

    SET v_RentalDays = GREATEST(DATEDIFF(p_ReturnDate, p_RentalDate), 1);
    SET v_RentalCharge = v_RentalDays * v_DailyRate;

    INSERT INTO Rental(
        CustomerID, VehicleID, RentalDate, ReturnDate,
        DailyRate, RentalCharge
    )
    VALUES(
        p_CustomerID, p_VehicleID, p_RentalDate, p_ReturnDate,
        v_DailyRate, v_RentalCharge
    );
END //

DELIMITER ;

-- 8.1 Procedure test (vehicle 7's daily rate is 12000; 3 days -> charge 36000):
-- CALL RegisterRental(6, 7, '2026-09-15', '2026-09-18');
-- SELECT * FROM Rental ORDER BY RentalID DESC LIMIT 1;


-- =========================================================================
-- 9. TASK 7 — OPTIMIZATION (INDEXES)
-- =========================================================================

-- 9.1 Supporting indexes for the most frequent lookups
CREATE INDEX idx_rental_vehicle_return ON Rental(VehicleID, ReturnDate);
CREATE INDEX idx_rental_customer       ON Rental(CustomerID);
CREATE INDEX idx_rental_date           ON Rental(RentalDate);

-- 9.2 Improved search query (benefits from idx_rental_vehicle_return)
SELECT RentalID, CustomerID, VehicleID, RentalDate, ReturnDate
FROM Rental
WHERE VehicleID = 4
AND ReturnDate IS NULL;


-- =========================================================================
-- 10. MANAGEMENT REPORTS
-- =========================================================================

-- 10.1 Customer Rental History
SELECT c.CustomerName, v.VehicleNumber, v.VehicleModel,
       r.RentalDate, r.ReturnDate, r.RentalCharge
FROM Customer c
JOIN Rental r ON c.CustomerID = r.CustomerID
JOIN Vehicle v ON r.VehicleID = v.VehicleID
ORDER BY c.CustomerName, r.RentalDate;

-- 10.2 Currently Rented Vehicles
SELECT v.VehicleNumber, v.VehicleModel,
       c.CustomerName, r.RentalDate
FROM Vehicle v
JOIN Rental r ON v.VehicleID = r.VehicleID
JOIN Customer c ON r.CustomerID = c.CustomerID
WHERE r.ReturnDate IS NULL;

-- 10.3 Vehicle Rental Activity
SELECT v.VehicleNumber, v.VehicleModel,
       COUNT(r.RentalID) AS TotalRentals,
       COALESCE(SUM(r.RentalCharge), 0) AS TotalRevenue
FROM Vehicle v
LEFT JOIN Rental r ON v.VehicleID = r.VehicleID
GROUP BY v.VehicleID, v.VehicleNumber, v.VehicleModel
ORDER BY TotalRentals DESC;


-- =========================================================================
-- 11. FINAL VERIFICATION
-- =========================================================================

SELECT * FROM Customer;
SELECT * FROM Vehicle;
SELECT * FROM Rental;
SELECT * FROM Payment;
SELECT * FROM RentalReport;
SHOW TRIGGERS;
SHOW PROCEDURE STATUS WHERE Db = 'cargo_rentals';

-- =========================================================================
-- END OF FILE
-- =========================================================================
