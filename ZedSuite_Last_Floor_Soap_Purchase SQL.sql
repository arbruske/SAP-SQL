--Manager Last Floor Soap Purchase 3 27 2018

SELECT DISTINCT
T7.[CardCode] AS 'New Cust Code',
T7.CardName AS 'Cust Name',
T7.[CardFName] AS 'Old Cust Code',

(SELECT CASE 
	       WHEN (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC) IS NULL THEN 'Yes'
             WHEN ((SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC) IS NOT NULL) AND ((SELECT TOP 1 * FROM 
(SELECT DISTINCT TOP 20 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry] 
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) IS NULL) AND DATEDIFF("D", (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC), GETDATE()) < 183 THEN 'Yes'
		WHEN DATEDIFF("D", (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC), GETDATE()) > 548 THEN 'Yes'
		WHEN DATEDIFF("D", (SELECT TOP 1 * FROM 
(SELECT DISTINCT TOP 20 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry] 
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC), (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)) > 548 AND DATEDIFF("D", (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC), GETDATE()) < 183 THEN 'Yes'
		ELSE 'No'    
END) AS "Spiff Eligible?",

(SELECT DATEDIFF("D", (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC), GETDATE())) AS 'Days Since Last Floor Soap Purchase',

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC) AS "Last Floor Soap Purchase Date",

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
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Floor Soap Purchase Date",

(SELECT TOP 1 a.docNum FROM
(SELECT
T0.[DocNum] as docNum

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL) AND T0.DocDate = (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocNumLG] as docNum

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND T0.U_BRU_DocDateLG = (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docNum DESC) AS "Last Floor Soap Inv Doc #",

(SELECT TOP 1 a.docEntry FROM
(SELECT
T0.[DocEntry] as docEntry

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL) AND T0.DocNum = ((SELECT TOP 1 a.docNum FROM
(SELECT
T0.[DocNum] as docNum

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL) AND T0.DocDate = (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocNumLG] as docNum

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND T0.U_BRU_DocDateLG = (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docNum DESC)))
AS a ORDER BY a.docEntry DESC) AS "Last Floor Soap Inv DocEntry",

(SELECT TOP 1 a.docNum FROM
(SELECT
T0.[DocNum] as docNum

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL) AND T0.DocDate = (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocNumLG] as docNum

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND T0.U_BRU_DocDateLG = (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docNum DESC) AS "Link to Last Floor Soap Inv"

FROM
OCRD T7 INNER JOIN CRD1 T8 ON T7.CardCode = T8.CardCode
INNER JOIN OSLP T2 ON T2.SlpName = T8.[U_BRU_ShipTo_SlsPerson]
--LEFT JOIN OINV T2 ON T0.CardCode = T2.CardCode

ORDER BY
T7.CardName