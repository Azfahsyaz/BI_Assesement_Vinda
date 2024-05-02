SELECT 
    COALESCE(s.brand_name, 'Unknown Brand') AS Brand_Name,
    DATE_FORMAT(s.sales_date, '%M') AS Month,
    IFNULL(SUM((CAST(REPLACE(s.price, ',', '') AS DECIMAL(10, 2)) * s.number_of_carton_sell)), 0) - 
    IFNULL(SUM((CAST(REPLACE(p.raw_material_cost, ',', '') AS DECIMAL(10, 2)) * p.number_of_carton_produce)), 0) AS Sales_Revenue
FROM 
    vinda_test.sales s
LEFT JOIN 
    vinda_test.production p ON EXTRACT(YEAR_MONTH FROM s.sales_date) = EXTRACT(YEAR_MONTH FROM p.manufacture_date)
GROUP BY 
    Brand_Name, Month
ORDER BY 
    Brand_Name, Month;
