-- Create database
CREATE DATABASE sales_analysis;

-- Use the database
USE sales_analysis;

-- Create sales_sample table
CREATE TABLE sales_sample (
    Product_Id INT,
    Region VARCHAR(50),
    Date DATE,
    Sales_Amount DECIMAL(10,2)
);

INSERT INTO sales_sample VALUES
(101, 'East', '2025-07-01', 1000),
(102, 'West', '2025-07-01', 1500),
(101, 'East', '2025-07-02', 1200),
(103, 'North', '2025-07-01', 2000),
(102, 'West', '2025-07-02', 1700),
(103, 'North', '2025-07-02', 1800),
(101, 'East', '2025-07-03', 1100),
(104, 'South', '2025-07-01', 1600),
(104, 'South', '2025-07-02', 1400),
(103, 'North', '2025-07-03', 1900);

---a) Drill Down — Region → Product Level
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id;

---b) Rollup — Product → Region (Total by Region + Grand Total)
SELECT Region, Product_Id, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample
GROUP BY Region, Product_Id WITH ROLLUP;


---c) Cube — Simulate Cube (All Dimensions) using UNION ALL 
-- By Region
SELECT Region, NULL AS Product_Id, NULL AS Date, SUM(Sales_Amount) AS Total_Sales
FROM sales_sample GROUP BY Region

UNION ALL

-- By Product
SELECT NULL, Product_Id, NULL, SUM(Sales_Amount)
FROM sales_sample GROUP BY Product_Id

UNION ALL

-- By Date
SELECT NULL, NULL, Date, SUM(Sales_Amount)
FROM sales_sample GROUP BY Date

UNION ALL

-- Grand Total
SELECT NULL, NULL, NULL, SUM(Sales_Amount)
FROM sales_sample;

--- d) Slice — Filter by Region or Date Slice by Region = 'East'
SELECT * FROM sales_sample
WHERE Region = 'East';

---e) Dice — Multiple Filters
-- Dice: Product_Id = 103, Region = 'North', Date between '2025-07-01' and '2025-07-02'
SELECT * FROM sales_sample
WHERE Product_Id = 103
  AND Region = 'North'
  AND Date BETWEEN '2025-07-01' AND '2025-07-02';

