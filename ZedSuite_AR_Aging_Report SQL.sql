--F-BP ZedSuite Manager AR Aging Report Detail 
 
--DESCRIPTION:  SQL uses General Ledger Detail to create an Aging Report which shows 
--actual invoices, credit memos, and payments by reference date in the JDT1 table.
 
--AUTHOR(s):
--Aleksander Bruske
 
SELECT
T4.SlpName AS 'Sales Rep',
T1.CardCode AS 'Cust Num',
T1.CardName AS 'Cust Name',
T3.DocEntry,
T3.DocNum,
 T0.RefDate 'Posting Date',
T0.DueDate 'Due Date',
DATEDIFF(DD, T0.RefDate, GETDATE()) 'Aging',
( SELECT (SUM(DateDiff(DD, T9.DocDate, T7.DocDate))/COUNT(T9.DocNum))
 FROM OCRD T6
 INNER JOIN ORCT T7 ON T6.CardCode = T7.CardCode
 INNER JOIN RCT2 T8 ON T8.DocNum = T7.DocNum
 INNER JOIN OINV T9 ON T9.DocEntry = T8.DocENtry 
 AND T8.InvType = '13'
 
 WHERE
 T6.CardCode = T1.CardCode) AS 'Average Days to Pay',
CASE
    WHEN (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 <  31 THEN
      CASE
          WHEN balduecred < > 0 THEN balduecred * -1
          ELSE balduedeb
      END
END AS '0-30 Days',
CASE
    WHEN (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 > 30 
    AND (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 < 61 THEN
      CASE
          WHEN balduecred < > 0 THEN balduecred * -1
          ELSE balduedeb
      END
END AS '31 to 60 Days',
CASE
    WHEN (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 > 60 
    AND (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 < 91 THEN
    CASE
        WHEN balduecred < > 0 THEN balduecred * -1
        ELSE balduedeb
    END
END AS '61 to 90 days',
CASE
    WHEN (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 > 90 
    AND (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 < 121 THEN
       CASE
           WHEN balduecred < > 0 THEN balduecred * -1
           ELSE balduedeb
       END
END AS '90 to 120 Days',
CASE
    WHEN (DATEDIFF(DD,T0.RefDate,Current_Timestamp)) +1 > 120 THEN
        CASE
            WHEN balduecred <> 0 THEN balduecred * -1
            ELSE balduedeb
        END
END AS '120 Plus Days'

FROM JDT1 T0 
INNER JOIN OCRD T1 ON T0.ShortName = T1.CardCode 
INNER JOIN OJDT T2 ON T2.TransId = T0.TransId
INNER JOIN OINV T3 ON T3.TransId = T2.TransId
LEFT JOIN OSLP T4 ON T3.SlpCode = T4.SlpCode
AND T1.CardType = 'C' 

 
WHERE 

T3.[DocStatus] = 'O' AND
(T0.TransType = 13 OR T0.TransType = 24) AND
T0.IntrnMatch = '0' 
AND T0.BalDueDeb != T0.BalDueCred

 
ORDER BY 

T4.SlpName,
T1.CardCode,
T0.TaxDate