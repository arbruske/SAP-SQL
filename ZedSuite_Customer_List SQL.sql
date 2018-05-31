--Customer List per Sales Employee Ship To 01 11 2018

SELECT DISTINCT
T0.[CardCode] AS 'Cust Code',
T0.[CardFName] AS 'Old Cust Code',
T0.CardName AS 'Cust Name',
T0.[CntctPrsn] AS 'Contact',
T0.[Phone1] AS 'Phone', 
T0.[Fax], 
T0.[E_Mail] AS 'Email',
(SELECT TOP 1 a.docDate FROM
(SELECT
T01.[DocDate] as docDate

FROM 
OINV T01 

WHERE
T01.[CardCode] = T0.[CardCode] AND  T01.Canceled = 'N' 

UNION ALL

SELECT
T02.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T02

WHERE
 T02.[U_BRU_CardCode] = T0.[CardCode] AND T02.[U_BRU_ObjTypeLG] = 13) 
AS a ORDER BY a.docDate DESC) AS "Last Invoice Date",

(SELECT TOP 1 a.docNum FROM
(SELECT
T01.[DocNum] as docNum,
T01.[DocDate] as docDate

FROM 
OINV T01 

WHERE
T01.[CardCode] = T0.[CardCode] AND  T01.Canceled = 'N' 

UNION ALL

SELECT
T02.[U_BRU_DocNumLG] as docNum,
T02.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T02

WHERE
 T02.[U_BRU_CardCode] = T0.[CardCode] AND  T02.[U_BRU_ObjTypeLG] = 13) 

AS a ORDER BY a.docDate DESC, a.docNum DESC) AS "Last Invoice #",

(SELECT TOP 1 a.docKey FROM
(SELECT
T01.[DocEntry] as docKey,
T01.[DocNum] as docNum,
T01.[DocDate] as docDate

FROM 
OINV T01 

WHERE
T01.[CardCode] = T0.[CardCode] AND  T01.Canceled = 'N') 

AS a ORDER BY a.docDate DESC, a.docNum DESC) AS "Last Invoice DocKey",

(SELECT TOP 1 a.docNum FROM
(SELECT
T01.[DocNum] as docNum,
T01.[DocDate] as docDate

FROM 
OINV T01 

WHERE
T01.[CardCode] = T0.[CardCode] AND  T01.Canceled = 'N' 

UNION ALL

SELECT
T02.[U_BRU_DocNumLG] as docNum,
T02.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T02

WHERE
 T02.[U_BRU_CardCode] = T0.[CardCode] AND T02.[U_BRU_ObjTypeLG] = 13) 

AS a ORDER BY a.docDate DESC, a.docNum DESC) AS "Link to Last Invoice",

(SELECT 
SUM(T01.[DocTotal] - T01.[TotalExpns] - T01.[VatSum])

FROM 
OINV T01

WHERE 
T01.[DocDate] >= Convert(datetime, '2017-10-01') AND T01.CANCELED = 'N' AND T01.CardCode = T0.[CardCode]) AS 'YTD Sales',

(SELECT 
SUM(T05.[U_BRU_LineTotalLG]) 

FROM 
[dbo].[@BRU_SALESHISTORY]  T05

WHERE 
T05.[U_BRU_CardCode] = T0.CardCode AND (T05.[U_BRU_DocDateLG] >= Convert(datetime, '2016-09-25') AND T05.[U_BRU_DocDateLG] <= Convert(datetime, '2017-09-30'))) AS 'Last Year Sales'

FROM
OCRD T0 INNER JOIN CRD1 T1 ON T0.CardCode = T1.CardCode
INNER JOIN OSLP T2 ON T2.SlpName = T1.[U_BRU_ShipTo_SlsPerson]
--LEFT JOIN OINV T2 ON T0.CardCode = T2.CardCode

WHERE

T2.SlpCode = [%SlpCode]

ORDER BY
T0.CardName
