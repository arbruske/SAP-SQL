--Employee Portal Item Price List and Inventory Status 01 22 2018

SELECT
T1.[ItemCode] AS 'Item No.', 
T0.[ItemName] AS 'Item Description',
T1.[Price] AS 'Unit Price',
(SELECT T4.Amount FROM SPP2 T4 WHERE T4.[SPP2LNum] = 0 AND T4.ItemCode = T1.ItemCode ) AS 'Tier 2 Min Quantity',
(SELECT T4.Price FROM SPP2 T4 WHERE T4.[SPP2LNum] = 0 AND T4.ItemCode = T1.ItemCode ) AS 'Tier 2 Price',
(SELECT T4.Amount FROM SPP2 T4 WHERE T4.[SPP2LNum] = 1 AND T4.ItemCode = T1.ItemCode) AS 'Tier 3 Min Quantity',
(SELECT T4.Price FROM SPP2 T4 WHERE T4.[SPP2LNum] = 1 AND T4.ItemCode = T1.ItemCode) AS 'Tier 3 Price',
T0.[OnHand] AS 'In Stock',
T0.[CommisPcnt] AS '% Commission'

FROM 
OITM T0 
INNER JOIN [dbo].[ITM1] T1 ON T0.ItemCode = T1.ItemCode 
INNER JOIN OPLN T2 ON T1.PriceList = T2.ListNum 

WHERE 
T1.PriceList = 2 AND T1.[Price] > 0

ORDER BY
T1.[ItemCode]