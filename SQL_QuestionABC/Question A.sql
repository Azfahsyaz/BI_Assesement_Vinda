SELECT
    p.Item_id,
    MAX(p.manufacture_date) AS Manufacturing_Date,
    MAX(p.Number_of_carton_produce) AS Total_carton_produced,
    COALESCE(SUM(s.number_of_carton_sell), 0) AS Total_carton_sold,
    MAX(p.Number_of_carton_produce) - COALESCE(SUM(s.number_of_carton_sell), 0) AS Number_of_carton_available
FROM
    vinda_test.production p
LEFT JOIN
    vinda_test.sales s ON p.Item_id = s.Item_id
WHERE
    p.manufacture_date <= DATE_SUB(CURDATE(), INTERVAL 3 YEAR) -- Filter for products manufactured more than 3 years ago
GROUP BY
    p.Item_id
HAVING
    Number_of_carton_available > 0 -- Ensure available cartons are positive
LIMIT 0, 1000;
