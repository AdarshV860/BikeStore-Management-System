INSERT INTO Customers (customer_id, first_name, last_name, phone, email) 
VALUES (1400, 'Nathan', 'Scott', '(312) 123-4567', 'nathan.scott@gmail.com');

INSERT INTO Orders (order_id, customer_id, store_id, staff_id, order_status, order_date, required_date, shipped_date) 
VALUES (16, 1400, 1, 2, 'Pending', '2024-04-01', '2024-04-07', '2024-04-05');

UPDATE Customers 
SET phone = '(312) 765-4321' 
WHERE customer_id = 1400;

UPDATE Orders 
SET order_status = 'Shipped' 
WHERE order_id = 16;

DELETE FROM Customers WHERE customer_id = 1400;

SELECT first_name, last_name, phone, email 
FROM Customers 
WHERE customer_id = 1396;

SELECT Customers.first_name, Customers.last_name, Orders.order_id, Orders.order_status 
FROM Customers
JOIN Orders ON Customers.customer_id = Orders.customer_id 
WHERE Orders.order_status = 'Pending';

SELECT Orders.order_id, Order_Items.product_id, Order_Items.quantity, Order_Items.list_price 
FROM Orders
JOIN Order_Items ON Orders.order_id = Order_Items.order_id;

SELECT COUNT(customer_id) AS total_customers_with_phone 
FROM Customers 
WHERE phone IS NOT NULL;

SELECT store_id, SUM(list_price * quantity * (1 - discount/100)) AS total_revenue 
FROM Order_Items 
JOIN Orders ON Order_Items.order_id = Orders.order_id 
GROUP BY store_id;

SELECT Customers.first_name, Customers.last_name, Orders.order_id, Products.product_name, Order_Items.quantity 
FROM Customers 
JOIN Orders ON Customers.customer_id = Orders.customer_id 
JOIN Order_Items ON Orders.order_id = Order_Items.order_id 
JOIN Products ON Order_Items.product_id = Products.product_id;


SELECT Customers.customer_id, Customers.first_name, Customers.last_name 
FROM Customers 
LEFT JOIN Orders ON Customers.customer_id = Orders.customer_id 
WHERE Orders.order_id IS NULL;
