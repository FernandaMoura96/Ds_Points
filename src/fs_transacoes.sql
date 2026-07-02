WITH tb_transactions AS 
(
SELECT 
 *

FROM transactions

WHERE dtTransaction < '2024-06-05'
     AND dtTransaction >= DATE('2024-06-05', '-21 day')

 GROUP BY idCustomer

),

tb_freq AS 

(SELECT 
    idCustomer,
    count(DISTINCT date ( dtTransaction)) AS qtDias21,
    count(DISTINCT CASE WHEN dtTransaction > DATE ('2024-06-05', '-14 day')THEN date (dtTransaction) END ) AS qtDias14,
    count(DISTINCT CASE WHEN dtTransaction > DATE ('2024-06-05','-7 day')THEN date (dtTransaction) END) AS qtDias7

FROM tb_transactions

GROUP BY idCustomer
),

tb_minutes AS (

SELECT idCustomer,
    date(datetime(dtTransaction, '-3 hour')) AS dtTransactionDate,
    min(datetime(dtTransaction, '-3 hour')) AS dtInicio,
    max(datetime(dtTransaction, '-3 hour')) AS dtFim,
    (julianday(max(datetime(dtTransaction, '-3 hour'))) - 
    julianday(min(datetime(dtTransaction, '-3 hour')))) * 24 * 60 AS LiveMinutes


FROM tb_transactions

GROUP BY 1,2

)

SELECT
    idCustomer,
    AVG(LiveMinutes) AS AvgLive,
    max(LiveMinutes) AS MaxLive,
    Min(LiveMinutes) AS MinLive,
    sum(LiveMinutes) AS SumLive

FROM tb_minutes

GROUP BY idCustomer