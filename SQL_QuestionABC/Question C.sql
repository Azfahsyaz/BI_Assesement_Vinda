SELECT 
    s.category_name AS Category,
    SUBSTRING(s.sales_date, 1, 10) AS Day,
    ROUND(AVG((CAST(REPLACE(s.price, ',', '') AS SIGNED) / s.number_of_carton_Sell)), 1) AS Average_Price
FROM 
    vinda_test.sales s
WHERE 
    s.sales_date LIKE '2022-11%'
GROUP BY 
    Category, Day
ORDER BY 
    Category, Day;
