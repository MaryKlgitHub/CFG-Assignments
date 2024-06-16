/*
Scenario for a Fashion Boutique Database

I want to help my local fashion boutique, Elegance Boutique, to manage their inventory, customer loyalty program, sales, and supplier information efficiently. 
To achieve this, I will store products (id, name, category, price, size, color), customers (id, first_name, last_name, email, phone_number, membership_id, join_date, points_collected), 
sales (id, customer_id, product_id, quantity, total, sale_date), inventory (product_id, stock, min_stock), suppliers (id, name, contact_name, contact_phone, contact_email), 
orders (id, product_id, supplier_id, quantity, order_date, status), and employees (id, first_name, last_name, email, phone_number, hire_date).

I will ensure that products, customers, sales, inventory, suppliers, orders, and employees tables are interconnected using primary and foreign keys where necessary. 
For example, I will link sales to customers and products, inventory to products, and orders to suppliers and products. I will enforce constraints like NOT NULL and UNIQUE where appropriate to maintain data integrity. 
The membership_id in the customers table will be set to AUTOINCREMENT, and various data types such as VARCHAR for text data, INT for quantities, and DECIMAL for prices will be used.

To simulate the real-life usage, I will:
1. Store and retrieve product details including prices and stock levels.
2. Manage customer information, track their points, and sales history.
3. Track inventory levels and use a stored procedure to alert when stock is low.
4. Record supplier details and manage orders from suppliers.
5. Handle employee records and link them to orders they manage.

I will write queries to add, delete, and update data in various tables. I will use aggregate functions to show statistics such as the total quantity of products sold and average product price. 
I will use joins to retrieve customer purchase histories and product details. Additionally, I will implement in-built functions to calculate lengths of customer emails and extract the year from sale dates.

To demonstrate functionality, I will:
1. Add new customers and products.
2. Record sales transactions and adjust inventory levels accordingly.
3. Increase stock levels when new orders are received from suppliers.
4. Use the stored procedure to check and alert for low stock levels.
5. Retrieve and display customer purchase histories and sales data.

This setup will help Elegance Boutique efficiently manage their operations, from inventory management to customer relationship management, ensuring a smooth and organized workflow.
*/

-- Create the Database with name EleganceBoutiqueDB
CREATE DATABASE EleganceBoutiqueDB;
USE EleganceBoutiqueDB;

-- Table 1: Products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL, -- Ensures name cannot be NULL
    category VARCHAR(100),
    price DECIMAL(7, 2) NOT NULL, -- Ensures price cannot be NULL
    size VARCHAR(10),
    color VARCHAR(50),
    CONSTRAINT chk_price CHECK (price > 0)  -- Ensures price is greater than 0
);

-- Table 2: Customers
-- Creating the 'customers' table with NOT NULL and UNIQUE constraints
CREATE TABLE customers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL, -- Ensures first_name cannot be NULL
    last_name VARCHAR(50) NOT NULL, -- Ensures last_name cannot be NULL
    email VARCHAR(100) UNIQUE NOT NULL, -- Ensures email is unique and cannot be NULL
    phone_number VARCHAR(15),
    join_date DATE NOT NULL,
    points_collected INT DEFAULT 0,
    CONSTRAINT chk_points CHECK (points_collected >= 0)
);

-- Table 3: Sales
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT NOT NULL, -- Ensures quantity cannot be NULL
    total DECIMAL(7, 2) NOT NULL, -- Ensures total cannot be NULL
    sale_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT chk_total CHECK (total > 0) -- Ensures total is greater than 0
);

-- Table 4: Inventory
CREATE TABLE inventory (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT,
    stock INT NOT NULL, -- Ensures stock cannot be NULL 
    min_stock INT NOT NULL, -- Ensures min_stock cannot be NULL
    FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT chk_stock CHECK (stock >= 0), -- Ensures stock cannot be negative
    CONSTRAINT chk_min_stock CHECK (min_stock >= 0) -- Ensures min_stock cannot be negative
);

-- Table 5: Suppliers
CREATE TABLE suppliers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL, -- Name of the supplier, cannot be NULL
    contact_person VARCHAR(255),
    phone_number VARCHAR(15),
    email VARCHAR(100) UNIQUE NOT NULL, -- Email address of the supplier, must be unique and cannot be NULL
    address VARCHAR(255)
);

-- Table 6: Orders
CREATE TABLE orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_id INT,
    product_id INT,
    order_date DATE NOT NULL, -- Date when the order was placed, cannot be NULL
    quantity INT NOT NULL, -- Quantity of products ordered, cannot be NULL
    total_cost DECIMAL(10, 2) NOT NULL, -- Total cost of the order, cannot be NULL
    status VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (supplier_id) REFERENCES suppliers(id),
    FOREIGN KEY (product_id) REFERENCES products(id),
    CONSTRAINT chk_total_cost CHECK (total_cost > 0), -- Check constraint ensuring total_cost is greater than 0
    CONSTRAINT chk_quantity CHECK (quantity > 0) -- Check constraint ensuring quantity is greater than 0
);

-- Table 7: Employees
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL, -- First name of the employee, cannot be NULL
    last_name VARCHAR(50) NOT NULL, -- Last name of the employee, cannot be NULL
    email VARCHAR(100) UNIQUE NOT NULL, -- Unique email address of the employee, cannot be NULL
    phone_number VARCHAR(15),
    hire_date DATE NOT NULL, -- Date when the employee was hired, cannot be NULL
    position VARCHAR(100),
    salary DECIMAL(10, 2),
    CONSTRAINT chk_salary CHECK (salary >= 0) -- Check constraint ensuring salary is non-negative
);

-- Insert data into products
INSERT INTO products (name, category, price, size, color)
VALUES
('T-Shirt', 'Top', 19.99, 'M', 'Red'),
('Jeans', 'Bottom', 49.99, 'L', 'Blue'),
('Jacket', 'Outerwear', 89.99, 'M', 'Black'),
('Sneakers', 'Footwear', 69.99, '10', 'White'),
('Dress', 'Top', 59.99, 'S', 'Green'),
('Shorts', 'Bottom', 29.99, 'M', 'Blue'),
('Hat', 'Accessory', 15.99, 'One Size', 'Black'),
('Scarf', 'Accessory', 12.99, 'One Size', 'Red');

-- SELECT * FROM products;

-- Insert data into customers
INSERT INTO customers (first_name, last_name, email, phone_number, join_date, points_collected)
VALUES
('John', 'Doe', 'john.doe@example.com', '1234567890', '2023-01-15', 100),
('Jane', 'Smith', 'jane.smith@example.com', '0987654321', '2023-02-20', 150),
('Alice', 'Johnson', 'alice.johnson@example.com', '1112223333', '2023-03-10', 200),
('Bob', 'Brown', 'bob.brown@example.com', '4445556666', '2023-04-05', 50),
('Charlie', 'Davis', 'charlie.davis@example.com', '7778889999', '2023-05-15', 120),
('David', 'Miller', 'david.miller@example.com', '2223334444', '2023-06-12', 180),
('Eva', 'Wilson', 'eva.wilson@example.com', '5556667777', '2023-07-08', 75),
('Grace', 'Lee', 'grace.lee@example.com', '8889990000', '2023-08-25', 90);

-- SELECT * FROM customers;

-- Insert data into inventory
INSERT INTO inventory (product_id, stock, min_stock)
VALUES
(1, 30, 5),
(2, 20, 5),
(3, 15, 5),
(4, 25, 5),
(5, 10, 5),
(6, 40, 5),
(7, 50, 5),
(8, 35, 5);

SELECT * FROM inventory;

ALTER TABLE inventory ADD location VARCHAR(50);

-- Insert inventory for T-Shirt in Warehouse
INSERT INTO inventory (product_id, stock, min_stock, location)
VALUES (1, 30, 5, 'Warehouse');

-- Insert inventory for T-Shirt in Storefront
INSERT INTO inventory (product_id, stock, min_stock, location)
VALUES (1, 20, 5, 'Storefront');

-- Updating 'location' column for the products where 'location' is ' NULL'
UPDATE inventory
SET location = 'Warehouse'
WHERE location IS NULL;

-- Insert data into sales
INSERT INTO sales (customer_id, product_id, quantity, total)
VALUES
(1, 1, 2, 39.98),
(2, 2, 1, 49.99),
(3, 3, 3, 269.97),
(4, 4, 1, 69.99),
(5, 5, 2, 119.98),
(6, 6, 1, 29.99),
(7, 7, 1, 15.99),
(8, 8, 2, 25.98);

-- Insert data into suppliers
INSERT INTO suppliers (name, contact_person, phone_number, email, address)
VALUES
('Fashion Supply Co.', 'Emily Taylor', '5551234567', 'emily@fashionsupply.com', '123 Fashion Ave'),
('Style Source Ltd.', 'Michael Brown', '5559876543', 'michael@stylesource.com', '456 Style Blvd'),
('Trend Traders Inc.', 'Sarah Johnson', '5556789012', 'sarah@trendtraders.com', '789 Trend St'),
('Elegant Essentials', 'David White', '5552345678', 'david@elegantessentials.com', '321 Elegant Rd'),
('Glamour Goods', 'Rebecca Green', '5553456789', 'rebecca@glamourgoods.com', '654 Glamour Dr'),
('Chic Couture', 'Daniel King', '5554567890', 'daniel@chiccouture.com', '987 Chic Ln'),
('Urban Outfitters', 'Sophia Hall', '5555678901', 'sophia@urbanoutfitters.com', '111 Urban St'),
('Luxury Labels', 'Henry Scott', '5556789012', 'henry@luxurylabels.com', '222 Luxury Blvd');

-- Insert data into orders
INSERT INTO orders (supplier_id, product_id, order_date, quantity, total_cost, status)
VALUES
(1, 1, '2023-06-01', 50, 999.50, 'Completed'),
(2, 2, '2023-06-15', 30, 1499.70, 'Completed'),
(3, 3, '2023-07-01', 20, 1799.80, 'Pending'),
(4, 4, '2023-07-15', 40, 2799.60, 'Completed'),
(1, 5, '2023-08-01', 10, 599.90, 'Pending'),
(2, 6, '2023-08-15', 60, 1799.40, 'Completed'),
(3, 7, '2023-09-01', 80, 1279.20, 'Pending'),
(4, 8, '2023-09-15', 70, 909.30, 'Completed');

-- Insert data into employees
INSERT INTO employees (first_name, last_name, email, phone_number, hire_date, position, salary)
VALUES
('Emma', 'Taylor', 'emma.taylor@eleganceboutique.com', '5551112222', '2023-01-10', 'Manager', 5000.00),
('Liam', 'Brown', 'liam.brown@eleganceboutique.com', '5553334444', '2023-02-20', 'Sales Associate', 3000.00),
('Olivia', 'Johnson', 'olivia.johnson@eleganceboutique.com', '5555556666', '2023-03-15', 'Cashier', 2500.00),
('Noah', 'Smith', 'noah.smith@eleganceboutique.com', '5557778888', '2023-04-25', 'Stock Manager', 3500.00),
('Ava', 'Davis', 'ava.davis@eleganceboutique.com', '5559990000', '2023-05-30', 'Customer Service', 2700.00),
('Sophia', 'Williams', 'sophia.williams@eleganceboutique.com', '5550001111', '2023-06-20', 'Sales Associate', 3000.00),
('James', 'Martinez', 'james.martinez@eleganceboutique.com', '5552223333', '2023-07-10', 'Accountant', 4500.00),
('Isabella', 'Garcia', 'isabella.garcia@eleganceboutique.com', '5554445555', '2023-08-05', 'Marketing Specialist', 4000.00);

-- Queries to demonstrate functionality

-- Add a new customer
INSERT INTO customers (first_name, last_name, email, phone_number, join_date, points_collected)
VALUES ('Lucas', 'Taylor', 'lucas.taylor@example.com', '9998887777', CURDATE(), 50);

-- Add a new customer
INSERT INTO customers (first_name, last_name, email, phone_number, join_date, points_collected)
VALUES ('Charlie', 'Davis', 'charlie.davis@example.com', '7778889999', '2023-05-15', 120);

SELECT id FROM customers WHERE email = 'charlie.davis@example.com';

-- Table 8: CustomerPoints
CREATE TABLE IF NOT EXISTS CustomerPoints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    points_collected INT,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

SELECT * FROM CustomerPoints;

RENAME TABLE CustomerPoints TO customer_points;

-- Delete a Customer and the points
-- Start a transaction
START TRANSACTION;

-- Delete the customer's points from the CustomerPoints table
DELETE FROM CustomerPoints WHERE customer_id = (
    SELECT id FROM customers WHERE email = 'charlie.davis@example.com'
);

-- Delete the customer from the customers table
DELETE FROM customers WHERE email = 'charlie.davis@example.com';

-- Commit the transaction
COMMIT;

SELECT * FROM customers;

-- Insert a new customer and their points
-- Start a transaction
START TRANSACTION;

-- Insert new customer data into the customers table
INSERT INTO customers (first_name, last_name, email, phone_number, join_date)
VALUES ('Charlie', 'Davis', 'charlie.davis@example.com', '7778889999', '2023-05-15');

-- Retrieve the last inserted customer ID
SET @customer_id = LAST_INSERT_ID();

-- Insert points data into the CustomerPoints table
INSERT INTO CustomerPoints (customer_id, points_collected)
VALUES (@customer_id, 120);

-- Commit the transaction
COMMIT;

-- Check and insert customer data conditionally
-- Start a transaction
START TRANSACTION;

-- Check if the email already exists
SET @existing_customer_id = (SELECT id FROM customers WHERE email = 'charlie.davis@example.com');

-- Insert new customer data only if the email does not exist

-- Commit the transaction
COMMIT;

-- Insert customer data with condional points insertion
-- Start a transaction
START TRANSACTION;

-- Insert new customer data, ignoring if email already exists
INSERT IGNORE INTO customers (first_name, last_name, email, phone_number, join_date)
VALUES ('Charlie', 'Davis', 'charlie.davis@example.com', '7778889999', '2023-05-15');

-- Get the id of the newly inserted customer (or 0 if no new customer was inserted)
SET @customer_id = LAST_INSERT_ID();

-- Insert points data into the CustomerPoints table if a new customer was inserted
INSERT INTO CustomerPoints (customer_id, points_collected)
SELECT @customer_id, 120
WHERE @customer_id <> 0;

-- Commit the transaction
COMMIT;

-- Add a new product
INSERT INTO products (name, category, price, size, color)
VALUES ('Blazer', 'Outerwear', 99.99, 'L', 'Gray');

-- Record a new sale transaction
INSERT INTO sales (customer_id, product_id, quantity, total)
VALUES (1, 2, 2, 99.98);

-- Update stock levels when a new order is received
UPDATE inventory SET stock = stock + 50 WHERE product_id = 1;

-- Retrieve customer purchase histories
SELECT c.first_name, c.last_name, p.name AS product_name, s.quantity, s.total, s.sale_date
FROM sales s
JOIN customers c ON s.customer_id = c.id
JOIN products p ON s.product_id = p.id
WHERE c.id = 1;

-- Retrieve total quantity of products sold and average product price with average price rounded to two decimal places
SELECT p.name, 
       SUM(s.quantity) AS total_quantity_sold, 
       ROUND(AVG(p.price), 2) AS average_price
FROM sales s
JOIN products p ON s.product_id = p.id
GROUP BY p.name;

-- Retrieve employees and their positions
SELECT first_name, last_name, position
FROM employees;

SELECT * FROM inventory;

-- Start a transaction
START TRANSACTION;

-- Insert a new sales record for selling 6 dresses (product ID 5)
INSERT INTO sales (customer_id, product_id, quantity, total)
VALUES (1, 5, 6, 359.94); -- Assuming the price of each dress is 59.99

-- Update the inventory to decrease the stock of product ID 5 by 6
UPDATE inventory
SET stock = stock - 6
WHERE product_id = 5;

-- Commit the transaction
COMMIT;

-- Retrieve low stock products
SELECT p.name, i.stock, i.min_stock
FROM inventory i
JOIN products p ON i.product_id = p.id
WHERE i.stock < i.min_stock;

-- Retrieve all data from products table
-- The results are ordered by the price of each product in ascending order
SELECT * FROM products ORDER BY price;

-- Retrieve all customer information from the customers table
-- The results are ordered by the join date of each customer in descending order
SELECT * FROM customers ORDER BY join_date DESC;

-- Retrieve information of all customers who have collected more than 100 points
-- The results are ordered by the points collected in descending order
SELECT * FROM customers WHERE points_collected > 100 ORDER BY points_collected DESC;

-- Retrieve all sales made in the last 30 days
-- The results are ordered by the sale date in descending order
SELECT * FROM sales WHERE sale_date >= NOW() - INTERVAL 30 DAY ORDER BY sale_date DESC;

-- Calculate the total quantity of products sold
-- The result is displayed as a single column with the alias 'total_products_sold'
SELECT SUM(quantity) AS total_products_sold FROM sales;
-- SELECT * FROM SALES;

-- Delete sales records associated with customer_id = 5
DELETE FROM sales WHERE customer_id = 5;

-- Delete the customer with id = 5 from the customers table
DELETE FROM customers WHERE id = 5;
SELECT * FROM customers;

-- Aggregate functions
-- Calculate the average price of products and round to 2 decimal places
SELECT ROUND(AVG(price), 2) AS average_product_price FROM products;

-- Calculate the total stock across all products
SELECT SUM(stock) AS total_stock FROM inventory;

-- Joins
-- Retrieve customer and sales information joined from customers and sales tables
-- Includes customer's first name, last name, sale details such as product ID, quantity, total amount, and sale date
-- Results are ordered by sale date in descending order
SELECT c.first_name, c.last_name, s.product_id, s.quantity, s.total, s.sale_date
FROM customers c
JOIN sales s ON c.id = s.customer_id
ORDER BY s.sale_date DESC;

-- Retrieve product and sales information joined from products and sales tables
-- Includes product details such as name and price, sale details such as quantity, total amount, and sale date
-- Results are ordered by sale date in descending order
SELECT p.name AS product_name, p.price, s.quantity, s.total, s.sale_date
FROM products p
JOIN sales s ON p.id = s.product_id
ORDER BY s.sale_date DESC;

-- Retrieve customer and sales information joined from customers and sales tables
-- Includes customer's first name, last name, sale details such as product ID, quantity, total amount, and sale date
-- Orders results by sale date in descending order, and if sale dates are the same, orders by customer last name ascending
SELECT c.first_name, c.last_name, s.product_id, s.quantity, s.total, s.sale_date
FROM customers c
JOIN sales s ON c.id = s.customer_id
ORDER BY s.sale_date DESC, c.last_name ASC;

-- Calculate the length of each customer's email address and order results by email length in descending order
SELECT id, email, LENGTH(email) AS email_length FROM customers ORDER BY email_length DESC;

-- Extract the year from each sale date and order results by sale date in descending order
SELECT id, sale_date, YEAR(sale_date) AS sale_year FROM sales ORDER BY sale_date DESC;

-- Retrieve product and supplier information for each order using multiple joins
-- Joins products, orders, and suppliers tables to link product ID with orders and supplier ID with orders
-- Displays product name, supplier name, order quantity, and order date
-- Orders results by order date in descending order
SELECT p.name AS product_name, s.name AS supplier_name, o.quantity, o.order_date
FROM products p
JOIN orders o ON p.id = o.product_id
JOIN suppliers s ON o.supplier_id = s.id
ORDER BY o.order_date DESC;

-- Retrieve order handling details including employee information
-- Joins employees and orders tables to link employee ID with order handler
-- Displays employee's first and last name, order ID, order status, and order date
-- Orders results by order date in descending order
SELECT e.first_name, e.last_name, o.id AS order_id, o.status, o.order_date
FROM employees e
JOIN orders o ON e.id = o.id
ORDER BY o.order_date DESC;

-- Stored Procedure to Check Stock Levels
DELIMITER //
CREATE PROCEDURE CheckStockLevels()
BEGIN
	-- Selects product name, current stock, and minimum stock from products with insufficient stock
    SELECT p.name, i.stock, i.min_stock
    FROM products p
    JOIN inventory i ON p.id = i.product_id
    WHERE i.stock < i.min_stock;
END //
DELIMITER ;

-- Call the stored procedure
CALL CheckStockLevels();

-- the DB Normalisation
-- Decided to split size and color into separate tables to avoid storing multiple values in a single column
-- Comment to explain the benefits to your teacher
/*
Benefits of Normalization:

1. Data Integrity: Each size ('M', 'L', etc.) and color ('Red', 'Blue', etc.) is stored in dedicated tables (sizes and colors), eliminating redundancy. This ensures consistency because any updates, such as changing 'M' to 'Medium', need only be made in one place.

2. Efficiency: Using numeric identifiers (size_id and color_id) in the products table instead of text reduces storage requirements and enhances query performance.

3. Scalability: Adding new sizes or colors is straightforward without altering existing product records. Simply insert new rows into the sizes or colors tables, and they become immediately available for new products.
*/

-- Create table sizes
CREATE TABLE sizes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    size VARCHAR(10) NOT NULL
);

-- create table colors
CREATE TABLE colors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    color VARCHAR(50) NOT NULL
);

-- Modify Products table to reference Size and Color
ALTER TABLE products
ADD COLUMN size_id INT,
ADD COLUMN color_id INT,
ADD CONSTRAINT fk_size FOREIGN KEY (size_id) REFERENCES sizes(id),
ADD CONSTRAINT fk_color FOREIGN KEY (color_id) REFERENCES colors(id);

-- Insert sample data into sizes and colors tables
INSERT INTO sizes (size) VALUES ('M'), ('L'), ('S'), ('10'), ('One Size');
INSERT INTO colors (color) VALUES ('Red'), ('Blue'), ('Black'), ('White'), ('Green');

SELECT * FROM colors;
SELECT * FROM sizes;

SELECT * FROM products;

-- Update size_id based on size values
UPDATE products p
JOIN sizes s ON p.size = s.size
SET p.size_id = s.id;

-- Update color_id based on color values
UPDATE products p
JOIN colors c ON p.color = c.color
SET p.color_id = c.id;

INSERT INTO colors (color) VALUES ('Gray');

ALTER TABLE products
DROP COLUMN size,
DROP COLUMN color;

-- Insert product in different colors and sizes
INSERT INTO products (name, category, price, size_id, color_id)
VALUES
    ('T-Shirt', 'Top', 19.99, 1, 1),   -- Size: M, Color: Red
    ('T-Shirt', 'Top', 19.99, 1, 2),   -- Size: M, Color: Blue
    ('T-Shirt', 'Top', 19.99, 1, 3),   -- Size: M, Color: Black
    ('T-Shirt', 'Top', 19.99, 2, 1),   -- Size: L, Color: Red
    ('T-Shirt', 'Top', 19.99, 2, 2),   -- Size: L, Color: Blue
    ('T-Shirt', 'Top', 19.99, 2, 3),   -- Size: L, Color: Black
    ('T-Shirt', 'Top', 19.99, 3, 1),   -- Size: S, Color: Red
    ('T-Shirt', 'Top', 19.99, 3, 2),   -- Size: S, Color: Blue
    ('T-Shirt', 'Top', 19.99, 3, 3),   -- Size: S, Color: Black
    ('T-Shirt', 'Top', 19.99, 4, 1),   -- Size: 10, Color: Red
    ('T-Shirt', 'Top', 19.99, 4, 2),   -- Size: 10, Color: Blue
    ('T-Shirt', 'Top', 19.99, 4, 3);   -- Size: 10, Color: Black

-- Select all products with their size and color details
SELECT p.id, p.name, p.category, p.price, s.size, c.color
FROM products p
JOIN sizes s ON p.size_id = s.id
JOIN colors c ON p.color_id = c.id;

-- Retrieve products by color
SELECT p.id, p.name AS product_name, p.category, p.price, s.size, c.color
FROM products p
JOIN sizes s ON p.size_id = s.id
JOIN colors c ON p.color_id = c.id
WHERE c.color = 'Red';

-- Update size information from 'M' to 'Medium'
-- Find out the id for size 'M'
SELECT id
FROM sizes
WHERE size = 'M';

-- Update size 'M' to 'Medium'
UPDATE sizes
SET size = 'Medium'
WHERE id = 1; -- Replaced [id_for_M] with the actual id retrieved from the previous query

-- Query to show updated products with new size
SELECT p.id, p.name AS product_name, p.category, p.price, s.size, c.color
FROM products p
JOIN sizes s ON p.size_id = s.id
JOIN colors c ON p.color_id = c.id;




