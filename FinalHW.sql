--CREATE TABLE
USE master;
GO
IF DB_ID('Hollywood') IS NOT NULL
    DROP DATABASE Hollywood;

CREATE DATABASE Hollywood;

USE Hollywood;

CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    YearBuilt CHAR(4),
    Genre VARCHAR(100),
    StudioID INT,
    producerC# INT,
);

CREATE TABLE Studio (
    StudioID INT PRIMARY KEY,
    StudioName VARCHAR(255) NOT NULL,
    Address1 VARCHAR(255),
    Address2 VARCHAR(255),
    City VARCHAR(100),
    [State] VARCHAR(50),
    Zip VARCHAR(20),
    PresC# INT,
);

CREATE TABLE MovieStars (
    MovieStarID INT PRIMARY KEY,
    LastName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    MI CHAR(1),
    Address1 VARCHAR(255),
    Address2 VARCHAR(255),
    City VARCHAR(100),
    [State] VARCHAR(50),
    Zip VARCHAR(20),
    Gender CHAR(1),
    BirthDate DATE
);

CREATE TABLE StarsIn (
    StarsInID INT PRIMARY KEY,
    MovieID INT,
    MovieStarID INT,
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (MovieStarID) REFERENCES MovieStars(MovieStarID)
);

CREATE TABLE MovieExec (
    cert# INT PRIMARY KEY,
    LastName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    netWorth BIGINT,
    Address1 VARCHAR(255),
    City VARCHAR(100),
    [State] VARCHAR(50),
    Zip VARCHAR(20),
    Gender CHAR(1),
    BirthDate DATE
);
ALTER TABLE Movies 
ADD FOREIGN KEY (StudioID) REFERENCES Studio(StudioID),
    FOREIGN KEY (producerC#) REFERENCES MovieExec(cert#);
ALTER TABLE Studio 
ADD FOREIGN KEY (PresC#) REFERENCES MovieExec(cert#);
;
--INSERT INTO
INSERT INTO MovieExec (cert#, LastName, FirstName, netWorth, Address1, City, [State], Zip, Gender, BirthDate)
VALUES
(101, 'Spielberg', 'Steven', 3700000000, '100 Universal City Plaza', 'Los Angeles', 'CA', '90068', 'M', '1946-12-18'),
(102, 'Lucas', 'George', 1000000000, '200 Lucas St', 'San Francisco', 'CA', '94129', 'M', '1944-05-14'),
(103, 'Cameron', 'James', 700000000, '300 Hollywood Blvd', 'Los Angeles', 'CA', '90028', 'M', '1954-08-16'),
(104, 'Nolan', 'Christopher', 250000000, '400 Cine St', 'London', 'UK', 'SW1A1AA', 'M', '1970-07-30'),
(105, 'Kathleen', 'Kennedy', 500000000, '500 Studio Rd', 'Burbank', 'CA', '91521', 'F', '1953-06-05');

INSERT INTO Studio (StudioID, StudioName, Address1, Address2, City, [State], Zip, PresC#)
VALUES
(1, 'Warner Bros.', '4000 Warner Blvd', NULL, 'Burbank', 'CA', '91522', 105),
(2, 'Universal Pictures', '100 Universal City Plaza', NULL, 'Universal City', 'CA', '91608', 101),
(3, '20th Century Fox', '10201 W Pico Blvd', NULL, 'Los Angeles', 'CA', '90064', 102),
(4, 'Paramount Pictures', '5555 Melrose Ave', NULL, 'Hollywood', 'CA', '90038', 103),
(5, 'Legendary Pictures', '2900 W Alameda Ave', NULL, 'Burbank', 'CA', '91505', 104);

INSERT INTO Movies (MovieID, Title, YearBuilt, Genre, StudioID, producerC#)
VALUES
(1, 'Jurassic Park', '1993', 'Adventure', 2, 101),
(2, 'Star Wars: A New Hope', '1977', 'Sci-Fi', 3, 102),
(3, 'Titanic', '1997', 'Romance', 4, 103),
(4, 'Inception', '2010', 'Sci-Fi', 1, 104),
(5, 'E.T. the Extra-Terrestrial', '1982', 'Family', 2, 101),
(6, 'The Matrix', '1999', 'Sci-Fi', 5, 105);

INSERT INTO MovieStars (MovieStarID, LastName, FirstName, MI, Address1, Address2, City, [State], Zip, Gender, BirthDate)
VALUES
(201, 'Ford', 'Harrison', NULL, '123 Hollywood St', NULL, 'Los Angeles', 'CA', '90028', 'M', '1942-07-13'),
(202, 'DiCaprio', 'Leonardo', NULL, '456 Sunset Blvd', NULL, 'Los Angeles', 'CA', '90046', 'M', '1974-11-11'),
(203, 'Winslet', 'Kate', NULL, '789 Vine St', NULL, 'Los Angeles', 'CA', '90038', 'F', '1975-10-05'),
(204, 'Hathaway', 'Anne', NULL, '321 Sunset Blvd', NULL, 'Los Angeles', 'CA', '90027', 'F', '1982-11-12'),
(205, 'Reeves', 'Keanu', NULL, '654 Hollywood Blvd', NULL, 'Los Angeles', 'CA', '90028', 'M', '1964-09-02');

INSERT INTO StarsIn (StarsInID, MovieID, MovieStarID)
VALUES
(301, 1, 201),
(302, 2, 202),
(303, 3, 202),
(304, 3, 203),
(305, 4, 204),
(306, 6, 205);
SELECT * FROM Movies
--UPDATE
UPDATE Movies
SET  Genre = 'Family, Sci-Fi'
WHERE MovieID = 5;
SELECT * FROM Movies
--DELETE
SELECT * FROM Movies
DELETE FROM Movies
where YearBuilt = 1997;
SELECT * FROM Movies
--SELECT
use northwind;
GO
SELECT City FROM Employees
--SELECT DISTINCT
SELECT DISTINCT City FROM Employees
--SELECT … FROM … WHERE
SELECT CategoryName, AvgPrice
FROM (
    SELECT c.CategoryName, AVG(p.UnitPrice) AS AvgPrice
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
    GROUP BY c.CategoryName
) AS CategoryAverages
WHERE AvgPrice > 30;
--ORDER BY
SELECT *
FROM Products
ORDER BY ProductName ASC;
--GROUP BY
SELECT CategoryID, COUNT(*) AS TotalOrders
FROM Products
GROUP BY CategoryID
--HAVING
SELECT CustomerID, COUNT(*) AS TotalOrders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) > 10;
--JOIN queries
SELECT c.CategoryName, AVG(p.UnitPrice) AS AvgPrice
FROM Products p
JOIN Categories c ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryName;
-- inner join
SELECT p.ProductName, c.CategoryName
FROM Products p
INNER JOIN Categories c
    ON p.CategoryID = c.CategoryID;
--CREATE VIEW
CREATE VIEW HighValueOrders AS
SELECT o.OrderID, c.CompanyName, o.Freight
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.Freight > 100;
go
SELECT * FROM HighValueOrders;
--SUM()
SELECT CustomerID, Sum(Freight) AS TotalSpent
FROM Orders
Group by CustomerID
--COUNT()
SELECT EmployeeID, Count(*) AS OrderCompleted
FROM Orders
Group by EmployeeID
--AVG()
SELECT SupplierID, AVG(UnitPrice) AS AverageCost
FROM Products
Group by SupplierID
--MIN()
SELECT ProductID, ProductName, UnitPrice
FROM Products
WHERE UnitPrice = (SELECT MIN(UnitPrice) FROM Products);
--MAX()
SELECT CustomerID, OrderID, Freight
FROM Orders
WHERE Freight = (SELECT MAX(Freight) FROM Orders);
--CREATE PROCEDURE
CREATE PROCEDURE GetOrdersByCustomer
    @CustomerID NVARCHAR(5)
AS
BEGIN
    SELECT * FROM Orders
    WHERE CustomerID = @CustomerID;
END;
--EXECUTE PROCEDURE
EXEC GetOrdersByCustomer @CustomerID = 'ALFKI';
--Sub Query
SELECT CategoryName, AvgPrice
FROM (
    SELECT c.CategoryName, AVG(p.UnitPrice) AS AvgPrice
    FROM Products p
    JOIN Categories c ON p.CategoryID = c.CategoryID
    GROUP BY c.CategoryName
) AS CategoryAverages
WHERE AvgPrice > 30;