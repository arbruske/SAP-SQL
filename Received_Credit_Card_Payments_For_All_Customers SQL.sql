SELECT 
T0.[DocNum], 
T0.[DocType], 
T0.[DocDate], 
T0.[DocDueDate], 
T0.[CardCode], 
T0.[CardName], 
T0.[DocTotal], 
T1.[CreditSum],  
T1.[ConfNum] 

FROM 
[dbo].[ORCT] T0
 INNER JOIN RCT3 T1 ON T0.[DocEntry] = T1.[DocNum]