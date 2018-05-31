SELECT 
T0.SlpCode AS 'Sales Person Code',
T2.SlpName,
T0.CardCode AS 'Cust Code',
T0.CardName AS 'Customer Name', 
T1.PymntGroup AS ' Pay Terms',
T0.DocEntry,
T0.DocNum AS 'Invoice Num',
T0.DocTotal - T0.PaidToDate AS 'Total Due', 
T0.DocDate AS 'Invoice Date', 
DATEDIFF(DAY, T0.DocDate, GETDATE ( )) AS 'Actual Days Past Invoicing Date',
T0.DocDueDate AS 'Due Date',
DATEDIFF(DAY, T0.DocDueDate, GETDATE ( )) AS 'Actual Days Past Due Date'

FROM 
OINV T0
INNER JOIN OCTG T1 ON T0.GroupNum = T1.GroupNum 
INNER JOIN OSLP T2 ON T0.SlpCode = T2.SlpCode

WHERE 
T0.DocStatus = 'O' AND T0.Canceled = 'N'   
AND (DATEDIFF(DAY, T0.DocDate,  GETDATE ( )) >= 90 AND DATEDIFF(DAY, T0.DocDate,  GETDATE ( )) <= 96)

ORDER BY 
DATEDIFF(DAY, T0.DocDate, GETDATE ( )) DESC