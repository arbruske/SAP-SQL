--Power Sweeper Sales Analysis SQL


SELECT 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T2.[CardName], 
T7.[CardFName],
T2.[DocNum], 
T2.DocEntry,
T2.[U_BRU_Class], 
T2.[DocDate],
T1.[ItemCode], 
T8.[ItmsGrpCod],
T3.[U_BRU_SlsPrsnType], 
T2.[ObjType],
SUM(T1.[LineTotal]) "Total SALES",
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocEntry = T2.DocEntry AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128)) AS 'Inv Doc Total Sales',

(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
(T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 128) AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Sales',

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128) AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND (T0.[U_BRU_ItemGroup] = 122 OR T0.[U_BRU_ItemGroup] = 106 OR T0.[U_BRU_ItemGroup] = 128))
AS a ORDER BY a.docDate DESC) AS "Last Power Sweeper Purchase Date",

(SELECT TOP 1 * FROM 
(SELECT DISTINCT TOP 20 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry] 
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128) 
AND  (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL) AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128) AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND (T0.[U_BRU_ItemGroup] = 122 OR T0.[U_BRU_ItemGroup] = 106 OR T0.[U_BRU_ItemGroup] = 128))
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND (T0.[U_BRU_ItemGroup] = 122 OR T0.[U_BRU_ItemGroup] = 106 OR T0.[U_BRU_ItemGroup] = 128) AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128) AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND (T0.[U_BRU_ItemGroup] = 122 OR T0.[U_BRU_ItemGroup] = 106 OR T0.[U_BRU_ItemGroup] = 128))
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Power Sweeper Purchase Date"

FROM 

INV1 T1 INNER JOIN OINV T2 ON T2.[DocEntry] = T1.[DocEntry] 
AND T2.Canceled = 'N'
INNER JOIN OSLP T3 ON T2.[SlpCode] = T3.[SlpCode] 
LEFT OUTER JOIN [@BRU_SALESREPSECDEP] T4 ON T4.[U_BRU_RepCode] = T3.[SlpName] 
INNER JOIN OCRD T7 ON T2.[CardCode] = T7.[CardCode]
LEFT JOIN OITM T8 ON T8.[ItemCode] = T1.[ItemCode]
--LEFT JOIN RDR1 T9 ON T9.TrgetEntry = T1.DocEntry	

WHERE 
T2.[DocDate] >= GETDATE() - 7 AND T2.[DocDate] <= GETDATE() AND (T8.[ItmsGrpCod] = 122 OR T8.[ItmsGrpCod] = 106 OR T8.[ItmsGrpCod] = 128)

GROUP BY 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T2.[CardName], 
T7.[CardFName],
T2.[DocNum], 
T2.DocEntry,
T1.DocEntry,
T2.[U_BRU_Class], 
T2.[DocDate], 
T1.[ItemCode],
T8.[ItmsGrpCod],
T3.[U_BRU_SlsPrsnType], 
T2.[ObjType]

UNION ALL

SELECT
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T6.[CardName], 
T7.[CardFName],
T6.[DocNum],
T6.DocEntry, 
T6.[U_BRU_Class], 
T6.[DocDate], 
T5.[ItemCode],
T8.[ItmsGrpCod],
T3.[U_BRU_SlsPrsnType], 
SUM(-(T5.[LineTotal])) "Total SALES", 
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocEntry = T6.DocEntry AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128)) AS 'Doc Total Sales',

SUM(-(T5.[LineTotal])) AS 'Sales Doc Total Sales',

T6.[ObjType],
(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128) AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND  (T0.[U_BRU_ItemGroup] = 122 OR T0.[U_BRU_ItemGroup] = 106 OR T0.[U_BRU_ItemGroup] = 128))
AS a ORDER BY a.docDate DESC) AS "Last Power Sweeper Purchase Date",

(SELECT TOP 1 * FROM 
(SELECT DISTINCT TOP 2 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry] 
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND (T03.[ItmsGrpCod] = 122 OR T03.[ItmsGrpCod] = 106 OR T03.[ItmsGrpCod] = 128) AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND (T0.[U_BRU_ItemGroup] = 122 OR T0.[U_BRU_ItemGroup] = 106 OR T0.[U_BRU_ItemGroup] = 128))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Power Sweeper Purchase Date"

FROM 
RIN1 T5 INNER JOIN ORIN T6 ON T6.[DocEntry] = T5.[DocEntry] 
AND T6.Canceled = 'N'
INNER JOIN OSLP T3 ON T6.[SlpCode] = T3.[SlpCode] 
LEFT OUTER JOIN [@BRU_SALESREPSECDEP] T4 ON T4.[U_BRU_RepCode] = T3.[SlpName] 
INNER JOIN OCRD T7 ON T6.[CardCode] = T7.[CardCode]
LEFT JOIN OITM T8 ON T8.[ItemCode] = T5.[ItemCode]	

WHERE 
T6.[DocDate] >= GETDATE() - 7 AND T6.[DocDate] <= GETDATE() AND (T8.[ItmsGrpCod] = 122 OR T8.[ItmsGrpCod] = 106 OR T8.[ItmsGrpCod] = 128)

GROUP BY 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T6.[ObjType],
T7.[CardCode],
T6.[CardName], 
T7.[CardFName],
T6.[DocNum],
T6.DocEntry, 
T6.[U_BRU_Class], 
T6.[DocDate],
T5.[ItemCode],
T8.[ItmsGrpCod], 
T3.[U_BRU_SlsPrsnType];

--Year-To-Date Power Sweeper Sub-Report

SELECT 
T1.SlpCode,
T1.SlpName,
T1.Memo,
(SELECT SUM(T02.[DocTotal] - T02.[VatSum] - T02.[TotalExpns])

FROM OINV T02

WHERE
T02.DocDate >= GETDATE() - 7 AND T02.DocDate <= GETDATE() AND T02.CANCELED = 'N' AND T02.SlpCode = T1.SlpCode) AS 'Total Weekly Sales',

(SELECT SUM(T02.[DocTotal] - T02.[VatSum] - T02.[TotalExpns])

FROM OINV T02 INNER JOIN OSLP T08 ON T02.SlpCode = T08.SlpCode

WHERE
T02.DocDate >= GETDATE() - 7 AND T02.DocDate <= GETDATE() and T02.CANCELED = 'N' AND (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800')) AS 'Total Weekly UNASSIGNED Sales',

(SELECT SUM(T01.[DocTotal] - T01.[VatSum] - T01.[TotalExpns])

FROM ORIN T01

WHERE
T01.DocDate >= GETDATE() - 7 AND T01.DocDate <= GETDATE() and T01.CANCELED = 'N' AND T01.SlpCode = T1.SlpCode) AS 'Total Weekly Credits',

(SELECT SUM(T01.[DocTotal] - T01.[VatSum] - T01.[TotalExpns])

FROM ORIN T01 INNER JOIN OSLP T08 ON T01.SlpCode = T08.SlpCode

WHERE
T01.DocDate >= GETDATE() - 7 AND T01.DocDate <= GETDATE() and T01.CANCELED = 'N' AND (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800')) AS 'Total Weekly UNASSIGNED Credits',

(SELECT SUM(T03.[LineTotal])

FROM INV1 T03 INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE 
T04.DocDate >= GETDATE() - 7 AND T04.DocDate <= GETDATE() and T04.CANCELED = 'N' AND T04.SlpCode = T1.SlpCode AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total Weekly Power Sweeper Sales',

(SELECT SUM(T03.[LineTotal])

FROM INV1 T03 INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode INNER JOIN OSLP T08 ON T04.SlpCode = T08.SlpCode

WHERE 
T04.DocDate >= GETDATE() - 7 AND T04.DocDate <= GETDATE() and T04.CANCELED = 'N' AND (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800') AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total Weekly UNASSIGNED Power Sweeper Sales',

(SELECT SUM(T06.[LineTotal])

FROM RIN1 T06 INNER JOIN ORIN T07 ON T06.DocEntry = T07.DocEntry INNER JOIN OITM T05 ON T06.ItemCode = T05.ItemCode

WHERE 
T07.DocDate >= GETDATE() - 7 AND T07.DocDate <= GETDATE() and T07.CANCELED = 'N' AND T07.SlpCode = T1.SlpCode AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total Weekly Power Sweeper Credits',

(SELECT SUM(T06.[LineTotal])

FROM RIN1 T06 INNER JOIN ORIN T07 ON T06.DocEntry = T07.DocEntry INNER JOIN OITM T05 ON T06.ItemCode = T05.ItemCode INNER JOIN OSLP T08 ON T07.SlpCode = T08.SlpCode

WHERE 
T07.DocDate >= GETDATE() - 7 AND T07.DocDate <= GETDATE() and T07.CANCELED = 'N' AND (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800') AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total Weekly UNASSIGNED Power Sweeper Credits',


(SELECT SUM(T02.[DocTotal] - T02.[VatSum] - T02.[TotalExpns])

FROM OINV T02

WHERE
T02.DocDate >=  '2017-10-01' and T02.CANCELED = 'N' AND T02.SlpCode = T1.SlpCode) AS 'Total Sales',

(SELECT SUM(T02.[DocTotal] - T02.[VatSum] - T02.[TotalExpns])

FROM OINV T02 INNER JOIN OSLP T08 ON T02.SlpCode = T08.SlpCode

WHERE
T02.DocDate >=  '2017-10-01' and T02.CANCELED = 'N' AND  (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800')) AS 'Total UNASSIGNED Sales',

(SELECT SUM(T01.[DocTotal] - T01.[VatSum] - T01.[TotalExpns])

FROM ORIN T01

WHERE
T01.DocDate >=  '2017-10-01' and T01.CANCELED = 'N' AND T01.SlpCode = T1.SlpCode) AS 'Total Credits',

(SELECT SUM(T01.[DocTotal] - T01.[VatSum] - T01.[TotalExpns])

FROM ORIN T01 INNER JOIN OSLP T08 ON T01.SlpCode = T08.SlpCode

WHERE
T01.DocDate >=  '2017-10-01' and T01.CANCELED = 'N' AND  (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800')) AS 'Total UNASSIGNED Credits',

(SELECT SUM(T03.[LineTotal])

FROM INV1 T03 INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE 
T04.DocDate >=  '2017-10-01' and T04.CANCELED = 'N' AND T04.SlpCode = T1.SlpCode AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total Power Sweeper Sales',

(SELECT SUM(T03.[LineTotal])

FROM INV1 T03 INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode INNER JOIN OSLP T08 ON T04.SlpCode = T08.SlpCode

WHERE 
T04.DocDate >=  '2017-10-01' and T04.CANCELED = 'N' AND  (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800')  AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total UNASSIGNED Power Sweeper Sales',

(SELECT SUM(T06.[LineTotal])

FROM RIN1 T06 INNER JOIN ORIN T07 ON T06.DocEntry = T07.DocEntry INNER JOIN OITM T05 ON T06.ItemCode = T05.ItemCode

WHERE 
T07.DocDate >=  '2017-10-01' and T07.CANCELED = 'N' AND T07.SlpCode = T1.SlpCode AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total Power Sweeper Credits',

(SELECT SUM(T06.[LineTotal])

FROM RIN1 T06 INNER JOIN ORIN T07 ON T06.DocEntry = T07.DocEntry INNER JOIN OITM T05 ON T06.ItemCode = T05.ItemCode INNER JOIN OSLP T08 ON T07.SlpCode = T08.SlpCode

WHERE 
T07.DocDate >=  '2017-10-01' and T07.CANCELED = 'N' AND (T08.Memo = 'UNASSIGNED' OR T08.SlpName = '149' OR T08.SlpName = '999'  OR T08.SlpName = '607'  OR T08.SlpName = '708' OR T08.SlpName = '800')  AND (T05.[ItmsGrpCod] = 106 OR T05.[ItmsGrpCod] = 122 OR T05.[ItmsGrpCod] = 128)) AS 'Total UNASSIGNED Power Sweeper Credits'


FROM OINV T0 INNER JOIN OSLP T1 ON T0.SlpCode = T1.SlpCode INNER JOIN INV1 T2 ON T0.[DocEntry] = T2.[DocEntry]

WHERE 
T0.DocDate >=  '2017-10-01' and T0.CANCELED = 'N' AND (T1.[U_BRU_SlsPrsnType] <> 'Retail Rep' AND T1.[U_BRU_SlsPrsnType] <> 'Retail Sales Manager' AND T1.Memo <> 'UNASSIGNED' AND T1.SlpName <> '149' AND T1.SlpName <> '999' AND T1.SlpName <> '607' AND T1.SlpName <> '708' AND T1.SlpName <> '800')

GROUP BY 
T1.SlpCode,
T1.SlpName,
T1.Memo

ORDER BY
T1.SlpName