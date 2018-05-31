--SQL Code for Sales Rep Commission

SELECT 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T2.[CardName], 
T2.[DocNum], 
T2.[U_BRU_Class], 
T2.[DocDate], 
T3.[U_BRU_SlsPrsnType], 
SUM(T1.[LineTotal]) "Total SALES", 
SUM(CASE
              WHEN T1.[U_BRU_FigComm] IS NULL OR T1.[U_BRU_FigComm] = 0.00
                      THEN (T8.[CommisPcnt]/100) * T1.[LineTotal]
                      ELSE T1.[U_BRU_FigComm]
        END) AS "Total Commission",
T4.[U_BRU_Sec_Dep],
SUM(T1.[LineTotal] * 0) "Security Deposit Subtract", 
SUM(CASE
              WHEN T1.[U_BRU_FigComm] IS NULL OR T1.[U_BRU_FigComm] = 0.00
                     THEN (((T8.[CommisPcnt]/100) * T1.[LineTotal]) * .10)
                      ELSE (T1.[U_BRU_FigComm] * .10)
       END) "Security Deposit Addition",
T4.[U_BRU_Salary], 
T7.[CreateDate], 
T2.[ObjType],
T2.[U_BRU_RcptMthd],
SUM(T1.[U_BRU_FigComm]) "Total Fig Comm",
(SELECT DISTINCT
MAX(T0.[DocDate])

FROM 
OINV T0 INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode]

WHERE
T0.[DocDate]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.CANCELED ='N' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
) "Last SAP Invoice Date",

(SELECT DISTINCT
MAX(T0.[U_BRU_DocDateLG])

FROM 
[dbo].[@BRU_SALESHISTORY] T0 INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND  T0.[U_BRU_ObjTypeLG] = 13
) "Last QB Invoice Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode]  AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13)
AS a ORDER BY a.docDate DESC) AS "Last Purchase Date"



FROM 
INV1 T1 INNER JOIN OINV T2 ON T2.[DocEntry] = T1.[DocEntry] 
AND T2.Canceled = 'N'
INNER JOIN OSLP T3 ON T2.[SlpCode] = T3.[SlpCode] 
LEFT OUTER JOIN [@BRU_SALESREPSECDEP] T4 ON T4.[U_BRU_RepCode] = T3.[SlpName] 
INNER JOIN OCRD T7 ON T2.[CardCode] = T7.[CardCode]
LEFT JOIN OITM T8 ON T1.ItemCode = T8.ItemCode

WHERE 
T2.[DocDate] >= GETDATE() - 5 AND T2.[DocDate] <= GETDATE()

GROUP BY 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T2.[CardName], 
T2.[DocNum], 
T2.[U_BRU_Class], 
T2.[DocDate], 
T3.[U_BRU_SlsPrsnType], 
T4.[U_BRU_Sec_Dep], 
T4.[U_BRU_Salary], 
T2.[ObjType],
T7.[CreateDate],
T2.[U_BRU_RcptMthd]

UNION ALL

SELECT
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T6.[CardName], 
T6.[DocNum], 
T6.[U_BRU_Class], 
T6.[DocDate], 
T3.[U_BRU_SlsPrsnType], 
SUM(-(T5.[LineTotal])) "Total SALES", 
SUM(CASE
              WHEN T5.[U_BRU_FigComm] IS NULL OR T5.[U_BRU_FigComm] = 0.00
                      THEN -(T8.[CommisPcnt]/100) * T5.[LineTotal]
                       ELSE -(T5.[U_BRU_FigComm])
        END) AS "Total Commission",
T4.[U_BRU_Sec_Dep], 
SUM(CASE
              WHEN T5.[U_BRU_FigComm] IS NULL OR T5.[U_BRU_FigComm] = 0.00
                      THEN -(T8.[CommisPcnt]/100) * T5.[LineTotal]
                      ELSE -(T5.[U_BRU_FigComm])
       END) AS "Security Deposit Subtract",
SUM(T5.[LineTotal] * 0) "Security Deposit Addition", 
T4.[U_BRU_Salary], 
T7.[CreateDate], 
T6.[U_BRU_RcptMthd],
T6.[ObjType],
SUM(T5.[U_BRU_FigComm]) "Total Fig Comm",
(SELECT DISTINCT
MAX(T0.[DocDate])

FROM 
ORIN T0 INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode]

WHERE
T0.[DocDate]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.CANCELED = 'N') "Last Credit Memo Date",
(SELECT DISTINCT
MAX(T0.[U_BRU_DocDateLG])

FROM 
[dbo].[@BRU_SALESHISTORY] T0 INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode]  AND T0.[U_BRU_ObjTypeLG] = 13
) "Last QB Invoice Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13)
AS a ORDER BY a.docDate DESC) AS "Last Purchase Date"


FROM 
RIN1 T5 INNER JOIN ORIN T6 ON T6.[DocEntry] = T5.[DocEntry] 
AND T6.Canceled = 'N'
INNER JOIN OSLP T3 ON T6.[SlpCode] = T3.[SlpCode] 
LEFT OUTER JOIN [@BRU_SALESREPSECDEP] T4 ON T4.[U_BRU_RepCode] = T3.[SlpName] 
INNER JOIN OCRD T7 ON T6.[CardCode] = T7.[CardCode]
LEFT JOIN OITM T8 ON T5.ItemCode = T8.ItemCode

WHERE 
T6.[DocDate] >= GETDATE() - 5 AND T6.[DocDate] <= GETDATE()

GROUP BY 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T6.[ObjType],
T7.[CardCode],
T6.[CardName], 
T6.[DocNum], 
T6.[U_BRU_Class], 
T6.[DocDate], 
T3.[U_BRU_SlsPrsnType], 
T4.[U_BRU_Sec_Dep], 
T4.[U_BRU_Salary], 
T7.[CreateDate],
T6.[U_BRU_RcptMthd];

--SQL Code For Manager Commission

SELECT 
T0.[U_BRU_ManagerCode], 
T1.Memo, 
T2.[U_BRU_Salary],
T0.[U_BRU_SalesmanCode], 
T0.[U_BRU_SalesManRealCode], 
T0.[U_BRU_SalesManName],
(SELECT SUM(T01.DocTotal - T01.[VatSum] - T01.[TotalExpns])

FROM OINV T01

WHERE 
T01.SlpCode = T0.[U_BRU_SalesmanCode] AND T01.CANCELED = 'N' AND (T01.DocDate >= GETDATE() - 5 AND T01.DocDate <= GETDATE())) AS 'Total Sales',

(SELECT SUM(T02.DocTotal - T02.[VatSum] - T02.[TotalExpns])

FROM ORIN T02

WHERE 
T02.SlpCode = T0.[U_BRU_SalesmanCode] AND T02.CANCELED = 'N' AND (T02.DocDate >= GETDATE() - 5 AND T02.DocDate <= GETDATE())) AS 'Total Credit Memo',
(SELECT SUM(CASE
              WHEN T03.[U_BRU_FigComm] IS NULL OR T03.[U_BRU_FigComm] = 0.00
                      THEN (T8.[CommisPcnt]/100) * T03.[LineTotal]
                      ELSE T03.[U_BRU_FigComm]
               END)

FROM
INV1 T03
LEFT JOIN OITM T8 ON T03.ItemCode = T8.ItemCode
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry

WHERE 
T04.SlpCode = T0.[U_BRU_SalesmanCode] AND T04.CANCELED = 'N' AND (T04.DocDate >= GETDATE() - 5 AND T04.DocDate <= GETDATE()))  AS "Total Inv Commission",
(SELECT SUM(CASE
              WHEN T03.[U_BRU_FigComm] IS NULL OR T03.[U_BRU_FigComm] = 0.00
                      THEN (T8.[CommisPcnt]/100) * T03.[LineTotal]
                      ELSE T03.[U_BRU_FigComm]
               END)

FROM
RIN1 T03
LEFT JOIN OITM T8 ON T03.ItemCode = T8.ItemCode
INNER JOIN ORIN T04 ON T03.DocEntry = T04.DocEntry

WHERE 
T04.SlpCode = T0.[U_BRU_SalesmanCode] AND T04.CANCELED = 'N' AND (T04.DocDate >= GETDATE() - 5 AND T04.DocDate <= GETDATE()))  AS "Total Credit Commission"

FROM 
[dbo].[@BRU_SALESGROUPS] T0 INNER JOIN [dbo].[@BRU_SALESREPSECDEP] T2 ON T2.[U_BRU_RepCode] = T0.[U_BRU_ManagerCode]  LEFT JOIN OSLP T1 ON T0.[U_BRU_ManagerCode] = T1.[SlpName]

ORDER BY
T0.[U_BRU_SalesManRealCode]