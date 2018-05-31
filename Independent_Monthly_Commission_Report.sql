SELECT

T3.[SlpName],

T3.[Memo],

T0.[DocEntry],

T0.[DocNum],

T0.[ObjType],

T0.[DocDate],

T0.[CardCode],

T0.[CardName],

SUM(T4.[LineTotal]) "Total SALES", 

SUM(CASE
              WHEN T4.[U_BRU_FigComm] IS NULL OR T4.[U_BRU_FigComm] = 0.00
                      THEN (T7.[CommisPcnt]/100) * T4.[LineTotal]
                      ELSE T4.[U_BRU_FigComm]
        END) AS "Total Commission",

(DATEDIFF(DD,T0.[DocDate],GetDate())) [Age],

(DATEDIFF(DD,T0.[DocDate],T2.[DocDate])) [Aging Paid Date],

(T0.Doctotal - T0.[VatSum] - T0.[TotalExpns]) [Total to be Commissioned],

(T0.DocTotal + T0.DpmAmnt) [Total Invoiced],

(T0.DpmAmnt + T0.PaidToDate)[Paid],

(T0.DocTotal - T0.PaidToDate)[Unpaid],

CASE WHEN T0.DocTotal - T0.PaidToDate = 0 THEN 'Paid' ELSE 'Unpaid' END AS 'Paid/Unpaid',

MAX(T2.[DocNum]) 'Payment#',

T2.[DocDate] 'Payment Date'

FROM

OINV T0 WITH (NOLOCK)

INNER JOIN INV1 T4 WITH (NOLOCK) ON T0.DocEntry = T4.DocEntry

INNER JOIN OITM T7 WITH (NOLOCK) ON T4.ItemCode = T7.ItemCode

LEFT OUTER JOIN RCT2 T1 WITH (NOLOCK) ON T0.DocEntry = T1.DocEntry AND T1.InvType = '13'

LEFT OUTER JOIN ORCT T2 WITH (NOLOCK) ON T1.DocNum = T2.DocNum

INNER JOIN OSLP T3 WITH (NOLOCK) ON T0.SlpCode = T3.SlpCode

-- (DateDiff(MM,T2.DocDate,Getdate()) = 0) for fully paid invoices within the month, replace with one below

WHERE 

 (T3.[SlpName] = '605' OR T3.[SlpName] = '604' OR T3.[SlpName] = '608' OR T3.[SlpName] = '607' OR T3.[SlpName] = '610' OR T3.[SlpName] = '721') AND T0.Canceled = 'N'

GROUP BY 

T3.[SlpName], 
T3.[Memo],
T0.[DocEntry],
T0.[DocNum], 
T0.[ObjType],
T0.[DocDate], 
T0.[CardCode], 
T0.[CardName], 
T0.DocTotal, 
T0.DpmAmnt, 
T0.PaidToDate, 
T2.[DocDate], 
T0.[VatSum], 
T0.[TotalExpns]

UNION ALL

SELECT

T3.[SlpName],

T3.[Memo],

T5.[DocEntry],

T5.[DocNum],

T5.[ObjType],

T5.[DocDate],

T5.[CardCode],

T5.[CardName],

SUM(-(T6.[LineTotal])) "Total SALES", 

SUM(CASE
              WHEN T6.[U_BRU_FigComm] IS NULL OR T6.[U_BRU_FigComm] = 0.00
                      THEN -(T7.[CommisPcnt]/100) * T6.[LineTotal]
                      ELSE -T6.[U_BRU_FigComm]
        END) AS "Total Commission",

(DATEDIFF(DD,T5.[DocDate],GetDate())) [Age],

(DATEDIFF(DD,T5.[DocDate],GetDate())) [Age],

-(T5.Doctotal - T5.[VatSum] - T5.[TotalExpns]) [Total to be Commissioned],

-(T5.DocTotal + T5.DpmAmnt) [Total Invoiced],

(T5.DpmAmnt + T5.PaidToDate)[Paid],

-(T5.DocTotal - T5.PaidToDate)[Unpaid],

CASE WHEN T5.DocTotal - T5.PaidToDate = 0 THEN 'Paid' ELSE 'Unpaid' END AS 'Paid/Unpaid',

MAX(T5.[DocNum]) 'Payment#',

T5.[DocDate] 'Payment Date'

FROM

ORIN T5 WITH (NOLOCK)

INNER JOIN RIN1 T6 WITH (NOLOCK) ON T5.DocEntry = T6.DocEntry

INNER JOIN OITM T7 WITH (NOLOCK) ON T6.ItemCode = T7.ItemCode

INNER JOIN OSLP T3 WITH (NOLOCK) ON T5.SlpCode = T3.SlpCode

-- (DateDiff(MM,T2.DocDate,Getdate()) = 0) for fully paid invoices within the month, replace with one below

WHERE 

(T3.[SlpName] = '605' OR T3.[SlpName] = '604' OR T3.[SlpName] = '608' OR T3.[SlpName] = '607' OR T3.[SlpName] = '610' OR T3.[SlpName] = '721') AND T5.Canceled = 'N'

GROUP BY 

T3.[SlpName], 
T3.[Memo],
T5.[DocEntry],
T5.[DocNum], 
T5.[ObjType],
T5.[DocDate], 
T5.[CardCode], 
T5.[CardName], 
T5.[DocTotal], 
T5.[DpmAmnt], 
T5.[PaidToDate], 
T5.[DocDate], 
T5.[VatSum], 
T5.[TotalExpns]