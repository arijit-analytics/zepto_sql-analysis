create table zepto(
sku_id SERIAL PRIMARY KEY,
category VARCHAR(150),
name VARCHAR(150) NOT NULL,
mrp NUMERIC(8,2),
discountpercent NUMERIC(8,2),
availablequantity INTEGER,
discountedSellingPrice NUMERIC(8,2),
weightInGms INTEGER,
outOfStock BOOLEAN,
quantity INTEGER
); 	

-- Exploring the Data
SELECT * FROM ZEPTO
LIMIT 30

--count of data
SELECT COUNT(*) FROM zepto;

--null values
SELECT * FROM zepto
where
name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountpercent IS NULL
OR
availablequantity IS NULL
OR
discountedsellingprice IS NULL
OR
weightingms IS NULL
OR
outofstock IS NULL
OR
quantity IS NULL;

--Unique Product Categories
SELECT DISTINCT 
category FROM ZEPTO
ORDER BY category ASC;

--Product in stock/out of stock
SELECT outofstock, COUNT(sku_id)
FROM zepto
GROUP BY outofstock;

--Product Names present multiple times
SELECT name, COUNT(sku_id) as "No of SKUs"
FROM zepto
GROUP BY name
HAVING COUNT(sku_id)>1
ORDER BY COUNT(sku_id) DESC;

-- Products with Price=0
SELECT * FROM zepto
WHERE discountedsellingprice=0;

DELETE FROM ZEPTO
WHERE discountedsellingprice=0;

--Converting Paise to Rupees
UPDATE zepto
SET mrp = mrp/100.0,
discountedsellingprice = discountedsellingprice/100.0;

SELECT mrp, discountedsellingprice 
FROM zepto;

-- Q1. Find the top 10 best-value products based on the discount percentage.
SELECT name, discountpercent
FROM zepto
ORDER BY discountpercent DESC
Limit 10;

--Q2.What are the Products with High MRP but Out of Stock
SELECT name, mrp
FROM zepto 
WHERE outofstock = true
ORDER BY mrp DESC;

--Q3.Calculate Estimated Revenue for each category
SELECT category, SUM(availablequantity * discountedsellingprice) 
AS total_revenue
FROM zepto
GROUP BY category
ORDER BY SUM(availablequantity * discountedsellingprice) DESC;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

SELECT name, mrp, discountpercentage 
AS discount
FROM zepto
WHERE mrp>500 AND discount<10

-- Q5. Identify the top 5 categories offering the highest average discount percentage.

SELECT DISTINCT category, 
ROUND(AVG(discountpercent),2) 
AS avg_discount
FROM zepto
GROUP BY category
ORDER BY avg_discount DESC
LIMIT 5;

-- Q6. Find the price per gram for products above 100g and sort by best value.

SELECT DISTINCT name, weightingms, discountedsellingprice,
ROUND(discountedsellingprice/weightingms,2) 
AS price_per_gm
FROM zepto
WHERE weightingms>=100
ORDER BY price_per_gm

--Q7.Group the products into categories like Low, Medium, Bulk.

SELECT DISTINCT name, weightingms,
CASE
WHEN weightInGms < 1001 THEN 'low'
WHEN weightInGms < 4999 THEN 'medium'
ELSE 'bulk'
END AS quantity_type
FROM ZEPTO
ORDER BY NAME asc;

--Q8.What is the Total Inventory Weight Per Category 

SELECT CATEGORY, SUM(availablequantity*weightingms/1000) AS total_weightinkg
FROM zepto
GROUP BY CATEGORY
ORDER BY total_weightinkg DESC;










