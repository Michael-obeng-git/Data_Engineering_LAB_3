-- Creation of the TechCorp database
create database TechCorps;
use TechCorps;

-- Create Customers table
CREATE TABLE customers (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(50),
  CustomerEmail VARCHAR(50)
);

-- Create Suppliers table  
CREATE TABLE suppliers (
  SupplierID INT PRIMARY KEY,
  SupplierName VARCHAR(50),
  SupplierAddress VARCHAR(100)
);

-- Create Products table
CREATE TABLE products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(50),
  Category VARCHAR(50),
  SupplierID INT,
  Price DECIMAL(10,2),
  FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create Orders table
CREATE TABLE orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductID INT,
  OrderDate DATE,
  Quantity INT,
  Total DECIMAL(10,2),
  FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insertion of sample data
INSERT INTO customers (CustomerID, CustomerName, CustomerEmail)
VALUES
  (001, 'Jean Doe', 'jsmith@mail.com'),
  (002, 'Rebecca Yeboah', 'ryeb@mail.com'),
  (003, 'Jean Doe', 'jdoe@mail.com'),
  (004, 'Bertina Ayuure', 'bayuure@mail.com');

INSERT INTO suppliers (SupplierID, SupplierName, SupplierAddress)
VALUES
  (1, 'CompuGhana', 'Ghana-Accra'),
  (2, 'RobotTech', 'Rwanda-Kigali'),
  (3, 'RapasatTech', 'Ghana-Accra'),
  (4, 'T-Shop', 'German-Bonn');

INSERT INTO products (ProductID, ProductName, Category, SupplierID, Price)
VALUES
  (101, 'Laptop', 'Electronics', 1, 1000),
  (102, 'Phone', 'Electronics', 2, 500),
  (103, 'Mouse', 'Electronics', 3, 25),
  (104, 'Keyboard', 'Accessories', 4, 10);

INSERT INTO orders (OrderID, CustomerID, ProductID, OrderDate, Quantity, Total)
VALUES
  (001, 001, 101, '2023-11-01', 1, 1000),
  (002, 002, 102, '2023-11-02', 2, 1000),
  (003, 003, 103, '2024-11-02', 2, 50),
  (004, 004, 104, '2024-11-03', 1, 10);