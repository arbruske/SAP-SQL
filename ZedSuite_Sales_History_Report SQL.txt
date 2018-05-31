--BRUSKE SALES HISTORY REPORT 03 22 2018

SELECT 
T0.[U_BRU_SlpCodeLG] AS 'Territory #',
T0.[U_BRU_CardCode] AS 'New Cust #', 
T0.[U_BRU_CardCodeLG] AS 'Old Cust #', 
T0.[U_BRU_CardNameLG] AS 'Cust Name', 
T0.[U_BRU_DocNumLG] AS 'Doc #', 
T0.[U_BRU_DocDateLG] AS 'Doc Date', 
T0.[U_BRU_AdresNameLG] AS 'Attention', 
T0.[U_BRU_StreetLG] AS 'Street', 
T0.[U_BRU_CitySLG] AS 'City', 
T0.[U_BRU_StateLG] AS 'State', 
T0.[U_BRU_ZipCodeLG] AS 'ZipCode', 
T0.[U_BRU_ItemCodeLG] AS 'Item Code', 
T0.[U_BRU_ItemNameLG] AS 'Item Desc.', 
T1.[ItmsGrpNam] AS 'Item Group',
T0.[U_BRU_ChemSpiffType] AS 'Chem Spiff Type',
T0.[U_BRU_QuantityLG] AS 'Qty Sold', 
T0.[U_BRU_ItemCostLG] AS 'Item Price'

FROM 
[dbo].[@BRU_SALESHISTORY]  T0 LEFT OUTER JOIN OITB T1 ON T1.[ItmsGrpCod] = T0.[U_BRU_ItemGroup]

WHERE 

T0.[U_BRU_ObjTypeLG] = '13'

GROUP BY 
T0.[U_BRU_SlpCodeLG],
T0.[U_BRU_CardCode], 
T0.[U_BRU_CardCodeLG], 
T0.[U_BRU_CardNameLG], 
T0.[U_BRU_DocSourceLG], 
T0.[U_BRU_DocNumLG], 
T0.[U_BRU_DocDateLG], 
T0.[U_BRU_AdresNameLG], 
T0.[U_BRU_StreetLG], 
T0.[U_BRU_CitySLG], 
T0.[U_BRU_StateLG], 
T0.[U_BRU_ZipCodeLG], 
T0.[U_BRU_ItemCodeLG], 
T0.[U_BRU_ItemNameLG], 
T1.[ItmsGrpNam],
T0.[U_BRU_ChemSpiffType],
T0.[U_BRU_QuantityLG], 
T0.[U_BRU_ItemCostLG] 

UNION ALL

SELECT
T5.[SlpName] AS 'Territory #',
T3.[CardCode] AS 'New Cust #',
T3.[U_BRU_CardCodeLG] AS 'Old Cust #',
T3.[CardName] AS 'Cust Name',
T3.[DocNum] AS 'Doc #',
T3.[DocDate] AS 'Doc Date',
(SELECT T01.Block FROM OINV T02 INNER JOIN CRD1 T01 ON T01.[CardCode] = T02.[CardCode] WHERE T01.[AdresType] = 'S' AND T02.[DocNum] = T3.[DocNum] AND T01.Address = T3.ShipToCode) AS 'Attention',
(SELECT T01.Street FROM OINV T02 INNER JOIN CRD1 T01 ON T01.[CardCode] = T02.[CardCode] WHERE T01.[AdresType] = 'S' AND T02.[DocNum] = T3.[DocNum] AND T01.Address = T3.ShipToCode) AS 'Street',
(SELECT T01.City FROM OINV T02 INNER JOIN CRD1 T01 ON T01.[CardCode] = T02.[CardCode] WHERE T01.[AdresType] = 'S' AND T02.[DocNum] = T3.[DocNum] AND T01.Address = T3.ShipToCode) AS 'City',
(SELECT T01.State FROM OINV T02 INNER JOIN CRD1 T01 ON T01.[CardCode] = T02.[CardCode] WHERE T01.[AdresType] = 'S' AND T02.[DocNum] = T3.[DocNum] AND T01.Address = T3.ShipToCode) AS 'State',
(SELECT T01.Zipcode FROM OINV T02 INNER JOIN CRD1 T01 ON T01.[CardCode] = T02.[CardCode] WHERE T01.[AdresType] = 'S' AND T02.[DocNum] = T3.[DocNum] AND T01.Address = T3.ShipToCode) AS 'ZipCode',
T4.[ItemCode] AS 'Item Code',
T4.[Dscription] AS 'Item Desc.',
(SELECT T03.[ItmsGrpNam] FROM OITM T02 LEFT OUTER JOIN OITB T03 ON T02.[ItmsGrpCod] = T03.[ItmsGrpCod] WHERE T02.[ItemCode] = T4.[ItemCode]) AS 'Item Group',
(SELECT T02.[U_BRU_ChemSpiffType] FROM OITM T02 WHERE T02.[ItemCode] = T4.[ItemCode]) AS 'Chem Spiff Type',
T4.[Quantity] AS 'Qty Sold',
T4.[PriceBefDi] AS 'Item Price'

FROM
OINV T3 INNER JOIN INV1 T4 ON T3.DocEntry = T4.DocEntry INNER JOIN OSLP T5 ON T5.SlpCode = T3.SlpCode

WHERE
T3.Canceled = 'N' AND T3.[DocType] = 'I'

GROUP BY
T5.[SlpName],
T3.[CardCode],
T3.[U_BRU_CardCodeLG],
T3.ShipToCode,
T3.[CardName],
T3.[DocNum],
T3.[DocDate],
T4.[ItemCode],
T4.[Dscription],
T4.[Quantity],
T4.[PriceBefDi]