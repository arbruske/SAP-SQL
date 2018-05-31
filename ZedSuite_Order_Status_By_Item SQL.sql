--Order Status By Item Ver 1 12 08 2017

SELECT TOP 500
T1.DocEntry as 'Link', 
T1.[DocNum] as 'SO No.', 
T1.[DocDate] as 'SO Date', 
CASE WHEN T1.DocStatus = 'O' THEN 'Open' ELSE 'Invoiced' END AS 'SO Status', 
T1.[CardName] as 'Customer Name', 
T0.[ItemCode] as 'Item Code',
T0.[Dscription] as 'Item Description', 
T0.[Quantity] as 'SO Qty',
T0.[OpenQty], 
T0.[Price] as 'Sales Price', 
T0.[OpenSum], 
T5.DocEntry, 
T5.DocNum as 'Invoice No',
T5.DocDate as 'Invoice Date', 
CASE 
    WHEN T5.DocStatus = 'C' THEN 'Paid' 
    WHEN T5.DocStatus = 'O' THEN 'Unpaid' 
END AS 'Invoice Status', 
T4.Quantity as 'Invoice Qty', 
T5.DocTotal,
T5.PaidToDate as 'Applied Amt',
(T5.DocTotal - T5.PaidToDate) as 'Amount Due'

FROM 
RDR1 T0  
INNER JOIN ORDR T1 ON T0.DocEntry = T1.DocEntry  
left outer join DLN1 T2 on T2.BaseEntry = T0.DocEntry and T2.BaseLine = T0.Linenum   
left outer join ODLN T3 on T2.DocEntry = T3.DocEntry  
left Outer join INV1 T4 on T4.BaseEntry = T3.DocEntry and T4.BaseLine = T2.Linenum  and T4.BaseType = 15 OR (T4.Basetype=17 and T4.BaseEntry=T0.DocEntry and T4.BaseLine=T0.LineNum)  
LEFT outer join RDN1 T11 on T11.BaseEntry = T2.DocEntry and T11.BaseLine = T2.LineNum  
LEFT outer join ORDN T12 on T11.DocEntry = T12.DocEntry  
left outer join OINV T5 on T5.DocEntry = T4.DocEntry  
left Outer join RIN1 T6 on T6.BaseEntry = T5.DocEntry and T6.BaseLine = T4.Linenum   
left outer join ORIN T7 on T6.DocEntry = T7.DocEntry  
left outer join OITM T8 on T0.ItemCode = T8.ItemCode  
left outer join OSLP T9 on T9.SlpCode = T1.SlpCode  
left outer join OHEM T10 on T10.empID = T1.OwnerCode

WHERE
(T5.CANCELED <> 'Y' OR T5.CANCELED IS NULL) AND (T1.CANCELED ='N' AND (T3.CANCELED <> 'Y' OR T3.CANCELED IS NULL)) AND T9.SlpCode = [%SlpCode]
  
GROUP BY
T1.DocStatus,
T1.DocEntry, 
T1.DocNum,
T1.CANCELED,
T1.DocDate,
T1.DocStatus,
T1.CardName, 
T9.SlpName,
T10.firstName,
T8.FrgnName,
T0.[ItemCode],
T0.[Dscription], 
T0.[Quantity],
T0.[Price],
T0.[OpenQty],
T0.[OpenSum],
T3.DocNum, 
T3.CANCELED,
T2.[Quantity],  
T5.DocEntry, 
T5.DocNum,
T5.CANCELED,  
T5.DocDate, 
T5.DocStatus, 
T4.Quantity, 
T5.DocTotal,
T5.PaidToDate,  
T7.DocNum, 
T7.DocDate,
T6.Quantity,
T11.Quantity

ORDER BY
T1.DocStatus DESC,
T1.DocDate DESC