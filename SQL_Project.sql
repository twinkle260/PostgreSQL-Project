CREATE TABLE product_data (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),
	CONSTRAINT fk_product FOREIGN KEY (product_id)
	REFERENCES product_data(product_id) ON DELETE CASCADE
	);

SELECT * FROM products;

--Q1 Show each order along with the product name and price.
SELECT
    o.order_id,
    p.product_name,
    p.price
FROM public.orders o
INNER JOIN public.products p
ON o.product_id = p.product_id
ORDER BY o.order_id;

--Q1. Display Order ID, Product Name and Price
SELECT o.order_id, p.product_name, p.price
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
ORDER BY o.order_id;

--Q2. Display all products and their order details
SELECT p.product_id, p.product_name, o.order_id, o.quantity
FROM products p
LEFT JOIN orders o
ON p.product_id = o.product_id;

--Q3. Display orders for Electronics category

SELECT o.order_id, p.product_name, p.category
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
WHERE LOWER(p.category) = 'electronics';

--Q4. Find total quantity ordered for each product

SELECT p.product_id, p.product_name,
       SUM(o.quantity) AS total_quantity
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name;

--Q5. Find total number of orders placed by each customer

SELECT customer_name,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_name
ORDER BY total_orders DESC;

--Q6. Display orders paid using Credit Card

SELECT *
FROM orders
WHERE payment_method = 'Credit Card';

--Q7. Find total sales amount for each product

SELECT p.product_id, p.product_name,
       SUM(o.quantity * p.price) AS total_sales
FROM orders o
INNER JOIN products p
ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name;

--Q8. Display customers who placed more than 2 orders

SELECT customer_name,
       COUNT(order_id) AS total_orders
FROM orders
GROUP BY customer_name
HAVING COUNT(order_id) > 2;