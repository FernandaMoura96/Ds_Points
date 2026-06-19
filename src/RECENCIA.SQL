SELECT
   idCustomer,
  CAST( min(julianday('now') - julianday(dtTransaction)) AS INTEGER ) 
  AS 'Rec_Dias',

 COUNT (DISTINCT DATE (dtTransaction )) AS 'freq_Dias '
 /*Contando as datas distinttas onde houveram transações*/

FROM transactions

WHERE dtTransaction < '2024-07-04'
  AND dtTransaction >= DATE('2024-07-04', '-21 day')

GROUP BY idCustomer