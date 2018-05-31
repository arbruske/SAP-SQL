USE [BRU_PROD]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery3.sql|7|0|C:\Users\ADMINI~1.BRU\AppData\Local\Temp\1\~vs51ED.sql
-- Batch submitted through debugger: SQLQuery2.sql|7|0|C:\Users\ADMINI~1.BRU\AppData\Local\Temp\2\~vsE6B.sql
-- Batch submitted through debugger: chemical spiff and sales report sql code 3 8 2018.sql|7|0|C:\Users\administrator.bruskeproducts\Desktop\chemical spiff and sales report sql code 3 8 2018.sql
-- Batch submitted through debugger: SQLQuery1.sql|7|0|C:\Users\ADMINI~1.BRU\AppData\Local\Temp\2\~vs11A3.sql
-- Batch submitted through debugger: SQLQuery1.sql|0|0|C:\Users\ADMINI~1.BRU\AppData\Local\Temp\2\~vs196A.sql
-- ================================================
-- =============================================
-- Author:		Aleksander Bruske
-- Create date: 4/25/2018
-- Description:	This stored procedure is used to calculate weekly and year-to-date sales figures for 
--              "Chemical" products. It is imported as a command in Crystal Reports in order to
--              create the Weekly Chemical Report. This report lists each sales representative
--              with all the chemical products they sold in the last week and to which customer and 
--              for how much the product was sold for. The report also shows whether the sales representative
--              earned a spiff bonus on selling the product. A spiff bonus amount is determined by how much
--              the item was sold for as well as if the customer that was sold the product is a new or re-activated
--              customer.                 
-- =============================================
ALTER PROCEDURE [dbo].[ChemSpiffProgram]
AS
BEGIN
SELECT 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T2.[CardName], 
T7.[CardFName],
T2.[DocNum], 
T2.[U_BRU_Class],
T2.[U_BRU_BackOrder], 
T2.[DocDate],
T1.[ItemCode], 
T8.[ItmsGrpCod],
T8.[U_BRU_ChemSpiffType],
T3.[U_BRU_SlsPrsnType], 
T2.[ObjType],
SUM(T1.[LineTotal]) "Total SALES",
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap') AS 'Doc Total Floor Soap Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'FloorSoap' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Floor Soap Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint') AS 'Doc Total Mighty Mint Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'MightyMint' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Mighty Mint Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray') AS 'Doc Total RDG Spray Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'RdgSpray' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total RDG Spray Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway') AS 'Doc Total Scent Away Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'ScentAway' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Scent Away Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner') AS 'Doc Total Fleet Cleaner Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Fleet Cleaner Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito') AS 'Doc Total Brito Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'Brito' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Brito Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax') AS 'Doc Total Splash Wax Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'SplashWax' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Splash Wax Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass') AS 'Doc Total Glimmer Glass Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'GlimGlass' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Glimmer Glass Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling') AS 'Doc Total Cling Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'Cling' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Cling Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich') AS 'Doc Total Lotion Rich Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'LotionRich' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Lotion Rich Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum') AS 'Doc Total Spectrum Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'Spectrum' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Spectrum Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray') AS 'Doc Total Micro Q Spray Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'MicroSpray' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Micro Q Spray Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade') AS 'Doc Total PDQ TradeWinds Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'PdqTrade' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total PDQ TradeWinds Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent') AS 'Doc Total Misty Solvent Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'MistySolvent' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Misty Solvent Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture') AS 'Doc Total Misty Moisture Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Misty Moisture Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak') AS 'Doc Total Variety Pak 6 Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'VarPak' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Variety Pak 6 Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance') AS 'Doc Total Brilliance Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'Brilliance' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Brilliance Sales',
(SELECT SUM(T02.LineTotal)

FROM OINV T01 INNER JOIN INV1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T2.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand') AS 'Doc Total Misty Vandalism Sales',
(SELECT
SUM(T01.LineTotal)

FROM 
RDR1 T01 
INNER JOIN ORDR T02 ON T02.DocEntry = T01.DocEntry 
INNER JOIN INV1 T03 ON T01.LineNum = T03.BaseLine AND T01.DocEntry = T03.BaseEntry 
INNER JOIN OINV T04 ON T03.DocEntry = T04.DocEntry 
INNER JOIN OITM T05 ON T03.ItemCode = T05.ItemCode

WHERE
T05.[ItmsGrpCod] = 104 AND T05.[U_BRU_ChemSpiffType] = 'MistyVand' AND T04.DocNum = T2.DocNum) AS 'Sales Doc Total Misty Vandalism Sales',

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand')
AS a ORDER BY a.docDate DESC) AS "Last Misty Vandalism Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Misty Vandalism Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance')
AS a ORDER BY a.docDate DESC) AS "Last Brilliance Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Brilliance Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'VarPak')
AS a ORDER BY a.docDate DESC) AS "Last VarPak Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'VarPak')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'VarPak' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'VarPak')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last VarPak Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture')
AS a ORDER BY a.docDate DESC) AS "Last MistyMoisture Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MistyMoisture Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent')
AS a ORDER BY a.docDate DESC) AS "Last MistySolvent Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MistySolvent Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade')
AS a ORDER BY a.docDate DESC) AS "Last PdqTrade Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last PdqTrade Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray')
AS a ORDER BY a.docDate DESC) AS "Last MicroSpray Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MicroSpray Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum')
AS a ORDER BY a.docDate DESC) AS "Last Spectrum Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Spectrum Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich')
AS a ORDER BY a.docDate DESC) AS "Last LotionRich Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last LotionRich Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Cling')
AS a ORDER BY a.docDate DESC) AS "Last Cling Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Cling')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Cling' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Cling')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Cling Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass')
AS a ORDER BY a.docDate DESC) AS "Last GlimGlass Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last GlimGlass Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax')
AS a ORDER BY a.docDate DESC) AS "Last SplashWax Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last SplashWax Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brito')
AS a ORDER BY a.docDate DESC) AS "Last Brito Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brito')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brito' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brito')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Brito Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner')
AS a ORDER BY a.docDate DESC) AS "Last FleetCleaner Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last FleetCleaner Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway')
AS a ORDER BY a.docDate DESC) AS "Last ScentAway Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last ScentAway Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray')
AS a ORDER BY a.docDate DESC) AS "Last RdgSpray Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last RdgSpray Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint')
AS a ORDER BY a.docDate DESC) AS "Last MightyMint Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MightyMint Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC) AS "Last FloorSoap Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap' AND (T0.[U_BRU_BackOrder] <> 'Y' OR T0.[U_BRU_BackOrder] IS NULL)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last FloorSoap Purchase Date"

FROM 

INV1 T1 INNER JOIN OINV T2 ON T2.[DocEntry] = T1.[DocEntry] 
AND T2.Canceled = 'N'
INNER JOIN OSLP T3 ON T2.[SlpCode] = T3.[SlpCode] 
LEFT OUTER JOIN [@BRU_SALESREPSECDEP] T4 ON T4.[U_BRU_RepCode] = T3.[SlpName] 
INNER JOIN OCRD T7 ON T2.[CardCode] = T7.[CardCode]
LEFT JOIN OITM T8 ON T8.[ItemCode] = T1.[ItemCode]	

WHERE 
T2.[DocDate] >= GETDATE() - 7 AND T2.[DocDate] <= GETDATE() AND T8.[ItmsGrpCod] = 104

GROUP BY 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T7.[CardCode],
T2.[CardName], 
T7.[CardFName],
T2.[DocNum],
T2.[U_BRU_BackOrder],  
T2.[U_BRU_Class], 
T2.[DocDate], 
T1.[ItemCode],
T8.[ItmsGrpCod],
T8.[U_BRU_ChemSpiffType],
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
T6.[U_BRU_BackOrder], 
T6.[U_BRU_Class], 
T6.[DocDate], 
T5.[ItemCode],
T8.[ItmsGrpCod],
T8.[U_BRU_ChemSpiffType],
T3.[U_BRU_SlsPrsnType], 
SUM(-(T5.[LineTotal])) "Total SALES", 
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap') AS 'Doc Total Floor Soap Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint') AS 'Doc Total Mighty Mint Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray') AS 'Doc Total RDG Spray Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway') AS 'Doc Total Scent Away Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner') AS 'Doc Total Fleet Cleaner Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito') AS 'Doc Total Brito Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax') AS 'Doc Total Splash Wax Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass') AS 'Doc Total Glimmer Glass Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling') AS 'Doc Total Cling Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich') AS 'Doc Total Lotion Rich Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum') AS 'Doc Total Spectrum Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray') AS 'Doc Total Micro Q Spray Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade') AS 'Doc Total PDQ TradeWinds Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent') AS 'Doc Total Misty Solvent Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture') AS 'Doc Total Misty Moisture Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak') AS 'Doc Total Variety Pak 6 Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance') AS 'Doc Total Brilliance Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand') AS 'Doc Total Misty Vandalism Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap') AS 'Sales Doc Total Floor Soap Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint') AS 'Sales Doc Total Mighty Mint Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray') AS 'Sales Doc Total RDG Spray Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway') AS 'Sales Doc Total Scent Away Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner') AS 'Sales Doc Total Fleet Cleaner Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito') AS 'Sales Doc Total Brito Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax') AS 'Sales Doc Total Splash Wax Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass') AS 'Sales Doc Total Glimmer Glass Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling') AS 'Sales Doc Total Cling Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich') AS 'Sales Doc Total Lotion Rich Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum') AS 'Sales Doc Total Spectrum Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray') AS 'Sales Doc Total Micro Q Spray Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade') AS 'Sales Doc Total PDQ TradeWinds Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent') AS 'Sales Doc Total Misty Solvent Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture') AS 'Sales Doc Total Misty Moisture Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak') AS 'Sales Doc Total Variety Pak 6 Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance') AS 'Sales Doc Total Brilliance Sales',
(SELECT SUM(-(T02.LineTotal))

FROM ORIN T01 INNER JOIN RIN1 T02 ON T01.DocEntry = T02.DocEntry INNER JOIN OITM T03 ON T02.ItemCode = T03.ItemCode

WHERE
T01.DocNum = T6.DocNum AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand') AS 'Sales Doc Total Misty Vandalism Sales',
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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand')
AS a ORDER BY a.docDate DESC) AS "Last Misty Vandalism Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyVand'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyVand')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Misty Vandalism Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance')
AS a ORDER BY a.docDate DESC) AS "Last Brilliance Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brilliance'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brilliance')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Brilliance Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'VarPak')
AS a ORDER BY a.docDate DESC) AS "Last VarPak Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'VarPak')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'VarPak' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'VarPak'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'VarPak')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last VarPak Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture')
AS a ORDER BY a.docDate DESC) AS "Last Brilliance Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistyMoisture'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistyMoisture')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MistyMoisture Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent')
AS a ORDER BY a.docDate DESC) AS "Last MistySolvent Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MistySolvent'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MistySolvent')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MistySolvent Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade')
AS a ORDER BY a.docDate DESC) AS "Last PdqTrade Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'PdqTrade'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'PdqTrade')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last PdqTrade Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray')
AS a ORDER BY a.docDate DESC) AS "Last MicroSpray Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MicroSpray'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MicroSpray')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MicroSpray Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum')
AS a ORDER BY a.docDate DESC) AS "Last Spectrum Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Spectrum'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Spectrum')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Spectrum Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich')
AS a ORDER BY a.docDate DESC) AS "Last LotionRich Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'LotionRich'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'LotionRich')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last LotionRich Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Cling')
AS a ORDER BY a.docDate DESC) AS "Last Cling Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Cling')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Cling' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Cling'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Cling')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Cling Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass')
AS a ORDER BY a.docDate DESC) AS "Last GlimGlass Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'GlimGlass'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'GlimGlass')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last GlimGlass Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax')
AS a ORDER BY a.docDate DESC) AS "Last SplashWax Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'SplashWax'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'SplashWax')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last SplashWax Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brito')
AS a ORDER BY a.docDate DESC) AS "Last Brito Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'Brito')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brito' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'Brito'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'Brito')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last Brito Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner')
AS a ORDER BY a.docDate DESC) AS "Last FleetCleaner Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FleetCleaner'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FleetCleaner')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last FleetCleaner Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway')
AS a ORDER BY a.docDate DESC) AS "Last ScentAway Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'ScentAway'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'ScentAway')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last ScentAway Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray')
AS a ORDER BY a.docDate DESC) AS "Last RdgSpray Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'RdgSpray'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'RdgSpray')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last RdgSpray Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint')
AS a ORDER BY a.docDate DESC) AS "Last MightyMint Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'MightyMint'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'MightyMint')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last MightyMint Purchase Date",

(SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC) AS "Last FloorSoap Purchase Date",

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
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap'
AND T0.[DocDate] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ItemGroup] = 104 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC)

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 5 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap' AND 
T0.[U_BRU_DocDateLG] <> (SELECT TOP 1 a.docDate FROM
(SELECT
T0.[DocDate] as docDate

FROM 
OINV T0 INNER JOIN INV1 T02 ON T0.[DocEntry] = T02.[DocEntry]
AND T0.Canceled = 'N' 
INNER JOIN OCRD T01 ON T0.[CardCode] = T01.[CardCode] 
INNER JOIN OITM T03 ON T03.[ItemCode] = T02.[ItemCode]

WHERE
T0.[DocDate]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T03.[ItmsGrpCod] = 104 AND T03.[U_BRU_ChemSpiffType] = 'FloorSoap'

UNION ALL

SELECT
T0.[U_BRU_DocDateLG] as docDate

FROM 
[dbo].[@BRU_SALESHISTORY] T0 
INNER JOIN OCRD T01 ON T0.[U_BRU_CardCode] = T01.[CardCode]

WHERE
T0.[U_BRU_DocDateLG]  < GETDATE() - 7 AND T01.[CardCode] = T7.[CardCode] AND T0.[U_BRU_ObjTypeLG] = 13 AND T0.[U_BRU_ChemSpiffType] = 'FloorSoap')
AS a ORDER BY a.docDate DESC))
AS a ORDER BY a.docDate DESC) AS b ORDER BY docDate DESC) AS "Second to Last FloorSoap Purchase Date"

FROM 
RIN1 T5 INNER JOIN ORIN T6 ON T6.[DocEntry] = T5.[DocEntry] 
AND T6.Canceled = 'N'
INNER JOIN OSLP T3 ON T6.[SlpCode] = T3.[SlpCode] 
LEFT OUTER JOIN [@BRU_SALESREPSECDEP] T4 ON T4.[U_BRU_RepCode] = T3.[SlpName] 
INNER JOIN OCRD T7 ON T6.[CardCode] = T7.[CardCode]
LEFT JOIN OITM T8 ON T8.[ItemCode] = T5.[ItemCode]	

WHERE 
T6.[DocDate] >= GETDATE() - 7 AND T6.[DocDate] <= GETDATE() AND T8.[ItmsGrpCod] = 104

GROUP BY 
T3.[SlpName], 
T3.[SlpCode],
T3.[Memo], 
T6.[ObjType],
T7.[CardCode],
T6.[CardName], 
T7.[CardFName],
T6.[DocNum], 
T6.[U_BRU_BackOrder],
T6.[U_BRU_Class], 
T6.[DocDate],
T5.[ItemCode],
T8.[ItmsGrpCod], 
T8.[U_BRU_ChemSpiffType],
T3.[U_BRU_SlsPrsnType]
END
