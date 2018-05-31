--Manager Employee Portal Document Look-Up 3 30 2018

SELECT
T4.SlpName AS 'Territory #', 
(SELECT CASE 
                   WHEN T0.[ObjType] = 17 THEN 'Sales Order'
                   WHEN T0.[ObjType] = 13 THEN 'Invoice'
                   WHEN T0.[ObjType] = 14 THEN 'Credit Memo'
END) AS 'Doc Type',
T3.[CardCode] AS 'New Cust Code',
T3.[CardFName] AS 'Old Cust Code', 
T3.[CardName] AS 'Customer Name',
T0.DocNum AS 'Doc Num',
 (SELECT TOP 1 T08.[DocEntry] 
  FROM RDR1 T01
  LEFT JOIN ORDR T02 ON T01.DocEntry = T02.DocEntry
  LEFT JOIN DPI1 T03 ON T03.BaseEntry = T01.DocEntry AND T03.[BaseType] = '17'
  LEFT JOIN ODPI T04 ON T03.DocEntry = T04.DocEntry
  LEFT JOIN ORCT T0B ON T04.ReceiptNum = T0B.DocEntry
  LEFT JOIN DPI1 T05 ON T04.DocEntry = T05.BaseEntry
  LEFT JOIN ODPI T06 ON T05.DocEntry = T06.DocEntry
  LEFT JOIN INV1 T07 ON T01.TrgetEntry = T07.DocEntry AND T07.BaseDocNum = T02.DocNum
  LEFT JOIN OINV T08 ON T07.DocEntry = T08.DocEntry
  WHERE T02.DocNum = T0.DocNum) AS 'DocEntry',
T0.DocEntry AS 'DocEntry2',

(SELECT CASE 
    WHEN T0.[ObjType] = 17 THEN (SELECT TOP 1 T08.[DocNum] 
            FROM RDR1 T01
            LEFT JOIN ORDR T02 ON T01.DocEntry = T02.DocEntry
            LEFT JOIN DPI1 T03 ON T03.BaseEntry = T01.DocEntry AND T03.[BaseType] = '17'
            LEFT JOIN ODPI T04 ON T03.DocEntry = T04.DocEntry
            LEFT JOIN ORCT T0B ON T04.ReceiptNum = T0B.DocEntry
            LEFT JOIN DPI1 T05 ON T04.DocEntry = T05.BaseEntry
            LEFT JOIN ODPI T06 ON T05.DocEntry = T06.DocEntry
            LEFT JOIN INV1 T07 ON T01.TrgetEntry = T07.DocEntry AND T07.BaseDocNum = T02.DocNum
            LEFT JOIN OINV T08 ON T07.DocEntry = T08.DocEntry
            WHERE T02.DocNum = T0.DocNum)
    WHEN T0.[ObjType] = 13 THEN 0
    WHEN T0.[ObjType] = 14 THEN 0
END) AS 'Link to Invoice',
(SELECT CASE 
    WHEN T0.[ObjType] = 17 THEN T0.DocNum
    WHEN T0.[ObjType] = 13 THEN 0
    WHEN T0.[ObjType] = 14 THEN 0
END) AS 'Link to Sales Order',
T0.[NumAtCard] AS 'PO #/Ref #',
T0.DocDate AS 'Doc Date',
T0.Comments

FROM 
ORDR T0 
LEFT OUTER JOIN OCRD T3 ON T0.CardCode = T3.CardCode 
LEFT OUTER JOIN OSLP T4 ON T0.SlpCode = T4.SlpCode

WHERE
T0.[CANCELED] = 'N' AND LEFT(T4.SlpName, 1) <> 1

GROUP BY
T4.SlpName,
T0.DocDate,
T3.[CardCode], 
T3.[CardFName], 
T3.[CardName],
T0.DocEntry,
T0.DocNum,
T0.[NumAtCard],
T0.[ObjType],
T0.Comments


UNION ALL 

SELECT
T4.SlpName AS 'Territory #', 
(SELECT CASE 
    WHEN T1.[ObjType] = 17 THEN 'Sales Order'
    WHEN T1.[ObjType] = 13 THEN 'Invoice'
    WHEN T1.[ObjType] = 14 THEN 'Credit Memo'
END) AS 'Doc Type',
T3.[CardCode] AS 'New Cust Code', 
T3.[CardFName] AS 'Old Cust Code', 
T3.[CardName] AS 'Customer Name',
T1.DocNum AS 'Doc Num',
T1.DocEntry,
 (SELECT TOP 1 T02.[DocEntry] 
  FROM RDR1 T01
  LEFT JOIN ORDR T02 ON T01.DocEntry = T02.DocEntry
  LEFT JOIN DPI1 T03 ON T03.BaseEntry = T01.DocEntry AND T03.[BaseType] = '17'
  LEFT JOIN ODPI T04 ON T03.DocEntry = T04.DocEntry
  LEFT JOIN ORCT T0B ON T04.ReceiptNum = T0B.DocEntry
  LEFT JOIN DPI1 T05 ON T04.DocEntry = T05.BaseEntry
  LEFT JOIN ODPI T06 ON T05.DocEntry = T06.DocEntry
  LEFT JOIN INV1 T07 ON T01.TrgetEntry = T07.DocEntry AND T07.BaseDocNum = T02.DocNum
  LEFT JOIN OINV T08 ON T07.DocEntry = T08.DocEntry
  WHERE T08.DocNum = T1.DocNum) AS 'DocEntry2',

(SELECT CASE 
    WHEN T1.[ObjType] = 17 THEN 0
    WHEN T1.[ObjType] = 13 THEN T1.DocNum
    WHEN T1.[ObjType] = 14 THEN 0
END) AS 'Link to Invoice',
(SELECT CASE 
    WHEN T1.[ObjType] = 17 THEN 0
    WHEN T1.[ObjType] = 13 THEN (SELECT TOP 1 T02.[DocNum] 
        FROM RDR1 T01
        LEFT JOIN ORDR T02 ON T01.DocEntry = T02.DocEntry
        LEFT JOIN DPI1 T03 ON T03.BaseEntry = T01.DocEntry AND T03.[BaseType] = '17'
        LEFT JOIN ODPI T04 ON T03.DocEntry = T04.DocEntry
        LEFT JOIN ORCT T0B ON T04.ReceiptNum = T0B.DocEntry
        LEFT JOIN DPI1 T05 ON T04.DocEntry = T05.BaseEntry
        LEFT JOIN ODPI T06 ON T05.DocEntry = T06.DocEntry
        LEFT JOIN INV1 T07 ON T01.TrgetEntry = T07.DocEntry AND T07.BaseDocNum = T02.DocNum
        LEFT JOIN OINV T08 ON T07.DocEntry = T08.DocEntry
        WHERE T08.DocNum = T1.DocNum)
    WHEN T1.[ObjType] = 14 THEN 0
END) AS 'Link to Sales Order',
T1.[NumAtCard] AS 'PO #/Ref #',
T1.DocDate AS 'Doc Date',
T1.Comments

FROM
OINV T1 
LEFT OUTER JOIN OCRD T3 ON T1.CardCode = T3.CardCode 
LEFT OUTER JOIN OSLP T4 ON T1.SlpCode = T4.SlpCode

WHERE
T1.[CANCELED] = 'N' AND LEFT(T4.SlpName, 1) <> 1

GROUP BY
T4.SlpName,
T1.DocDate,
T3.[CardCode], 
T3.[CardFName], 
T3.[CardName],
T1.DocEntry,
T1.DocNum,
T1.[NumAtCard],
T1.[ObjType],
T1.Comments

UNION ALL

SELECT
T4.SlpName AS 'Territory #', 
(SELECT CASE 
    WHEN T2.[ObjType] = 17 THEN 'Sales Order'
    WHEN T2.[ObjType] = 13 THEN 'Invoice'
    WHEN T2.[ObjType] = 14 THEN 'Credit Memo'
END) AS 'Doc Type',
T3.[CardCode] AS 'New Cust Code', 
T3.[CardFName] AS 'Old Cust Code', 
T3.[CardName] AS 'Customer Name',
T2.DocNum AS 'Doc Num',
T2.DocEntry,
T2.DocEntry AS 'DocEntry2',

(SELECT CASE 
    WHEN T2.[ObjType] = 17 THEN 0
    WHEN T2.[ObjType] = 13 THEN 0
    WHEN T2.[ObjType] = 14 THEN 0
END) AS 'Link to Invoice',
(SELECT CASE 
    WHEN T2.[ObjType] = 17 THEN 0
    WHEN T2.[ObjType] = 13 THEN 0
    WHEN T2.[ObjType] = 14 THEN 0
END) AS 'Link to Sales Order',
T2.[NumAtCard] AS 'PO #/Ref #',
T2.DocDate AS 'Doc Date',
T2.Comments

FROM
ORIN T2 
LEFT OUTER JOIN OCRD T3 ON T2.CardCode = T3.CardCode
LEFT OUTER JOIN OSLP T4 ON T2.SlpCode = T4.SlpCode

WHERE
T2.[CANCELED] = 'N' AND LEFT(T4.SlpName, 1) <> 1

GROUP BY
T4.SlpName,
T2.DocDate,
T3.[CardCode], 
T3.[CardFName], 
T3.[CardName],
T2.DocEntry,
T2.DocNum,
T2.[NumAtCard],
T2.[ObjType],
T2.Comments