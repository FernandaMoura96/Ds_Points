WITH tb_transactions AS 
(
    SELECT 
    *

    FROM transactions

    WHERE dtTransaction < '2024-06-05'
        AND dtTransaction >= DATE('2024-06-05', '-21 day')

 

),

tb_freq AS 

(
        SELECT 
        idCustomer,
        count(DISTINCT date ( dtTransaction)) AS qtDias21,
        count(DISTINCT CASE WHEN dtTransaction > DATE ('2024-06-05', '-14 day')THEN date (dtTransaction) END ) AS qtDias14,
        count(DISTINCT CASE WHEN dtTransaction > DATE ('2024-06-05','-7 day')THEN date (dtTransaction) END) AS qtDias7

    FROM tb_transactions

    GROUP BY idCustomer
),

tb_minutes AS 

(
    SELECT idCustomer,
        date(datetime(dtTransaction, '-3 hour')) AS dtTransactionDate,
        min(datetime(dtTransaction, '-3 hour')) AS dtInicio,
        max(datetime(dtTransaction, '-3 hour')) AS dtFim,
        (julianday(max(datetime(dtTransaction, '-3 hour'))) - 
        julianday(min(datetime(dtTransaction, '-3 hour')))) * 24 * 60 AS LiveMinutes


    FROM tb_transactions

    GROUP BY 1,2

),

tb_time AS
(
        SELECT
        idCustomer,
        AVG(LiveMinutes) AS AvgLive,
        max(LiveMinutes) AS MaxLive,
        Min(LiveMinutes) AS MinLive,
        sum(LiveMinutes) AS SumLive

    FROM tb_minutes

    GROUP BY idCustomer
),

tb_vida AS 

(
    SELECT 
    idCustomer,
    count(DISTINCT idTransaction) AS  TransacoesDiasVida,
    count(DISTINCT idTransaction) / (max(julianday('2024-06-05')- julianday(dtTransaction))) AS avgTransacoesDia
    FROM transactions
    WHERE dtTransaction < '2024-06-05'

    GROUP BY idCustomer
    
),

tb_join AS

(
    SELECT 
        t1.* ,
        t2.AvgLive,
        t2.MaxLive,
        t2.MinLive,
        t2.SumLive,
        t3.TransacoesDiasVida,
        t3.avgTransacoesDia


FROM tb_freq AS t1 

LEFT JOIN tb_time AS t2
 ON 
t1.idCustomer = t2.idCustomer

LEFT JOIN tb_vida AS t3 
ON
t3.idCustomer = t1.idCustomer

)

SELECT
'2024-06-05' AS dtRef,
 *
 FROM tb_join