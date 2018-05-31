SELECT
T5.[Code], 
T5.[Name], 
T5.[Rate], 
T3.[Line_ID],
T3.[STACode],
(SELECT 
T01.[Name]
FROM OSTA T01 WHERE T01.Code = T3.[STACode] AND T01.[Type] = T6.[AbsId]) AS "Name",
T6.[AbsId],
T3.[EfctivRate],
T4.TaxCode,
T0.[DocEntry],
T2.[DocEntry],
T0.[DocNum],
T0.[DocDate],
T0.[CardCode],
T0.[CardName],
T0.[VatSumSy],
(T0.DocTotal - T0.[VatSumSy]) AS 'Total Sales',
(DATEDIFF(DD,T0.[DocDate],GetDate())) [Age],
(DATEDIFF(DD,T0.[DocDate],T2.[DocDate])) [Aging Paid Date],
SUM(T4.[LineTotal]) "Total SALES", 
SUM(CASE
        WHEN T4.[U_BRU_FigComm] IS NULL OR T4.[U_BRU_FigComm] = 0.00
               THEN (T4.[Commission]/100) * T4.[LineTotal]
               ELSE T4.[U_BRU_FigComm]
    END) AS "Total Commission",
(T0.DocTotal + T0.DpmAmnt) [Total Invoiced],
(T0.DpmAmnt + T0.PaidToDate)[Paid],
(T0.DocTotal - T0.PaidToDate)[Unpaid],
CASE WHEN T0.DocTotal - T0.PaidToDate = 0 THEN 'Paid' ELSE 'Unpaid' END AS 'Paid/Unpaid',
MAX(T2.[DocNum]) 'Payment#',
T2.[DocDate] 'Payment Date'

FROM
OINV T0 WITH (NOLOCK)
INNER JOIN INV1 T4 WITH (NOLOCK) ON T0.DocEntry = T4.DocEntry
LEFT OUTER JOIN RCT2 T1 WITH (NOLOCK) ON T0.DocEntry = T1.DocEntry AND T1.InvType = '13'
LEFT OUTER JOIN ORCT T2 WITH (NOLOCK) ON T1.DocNum = T2.DocNum
LEFT OUTER JOIN OSTC T5 WITH (NOLOCK) ON T4.TaxCode = T5.Code
LEFT JOIN STC1 T3 WITH (NOLOCK) ON T4.TaxCode = T3.[STCCode]
INNER JOIN OSTT T6 ON T3.[STAType] = T6.[AbsId]

WHERE 
T0.DocTotal + T0.DpmAmnt - T0.PaidToDate = 0.00 AND LEFT(T4.TaxCode,2) = 'MN' AND T0.Canceled = 'N' AND T2.Canceled = 'N' 

GROUP BY 
T0.[DocEntry],
T2.[DocEntry],
T0.[DocNum], 
T5.[Code], 
T5.[Name], 
T5.[Rate], 
T3.[Line_ID],
T3.[STACode],
T4.TaxCode,
T6.[AbsId],
T3.[EfctivRate],
T0.[DocNum], 
T0.[DocDate], 
T0.[CardCode], 
T0.[CardName], 
T0.[VatSumSy],
T0.DocTotal, 
T0.DpmAmnt, 
T0.PaidToDate, 
T2.[DocDate], 
T0.[VatSum], 
T0.[TotalExpns]