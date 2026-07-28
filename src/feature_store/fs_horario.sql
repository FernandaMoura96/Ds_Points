WITH tb_transaction_hour AS (
    SELECT 
        idCustomer,
        pointsTransaction,
        CAST(STRFTIME('%H', dtTransaction, '-3 hours') AS INTEGER) AS hora
    FROM transactions
    WHERE dtTransaction < '{date}'
      AND dtTransaction >= DATE('{date}', '-21 day')
),

tb_share_hora AS 

(SELECT 
    idCustomer,
    
    -- 1. BLOCO DE SOMA DE PONTOS 
    SUM(CASE WHEN hora >= 8 AND hora < 12 THEN ABS(pointsTransaction) ELSE 0 END) AS PontosManha,
    SUM(CASE WHEN hora >= 12 AND hora < 18 THEN ABS(pointsTransaction) ELSE 0 END) AS PontosTarde,
    SUM(CASE WHEN hora >= 18 AND hora <= 23 THEN ABS(pointsTransaction) ELSE 0 END) AS PontosNoite,

    -- 2. BLOCO DE PORCENTAGEM DE PONTOS 
    1.0 * SUM(CASE WHEN hora >= 8 AND hora < 12 THEN ABS(pointsTransaction) ELSE 0 END) / SUM(ABS(pointsTransaction)) AS pctPontosManha,
    1.0 * SUM(CASE WHEN hora >= 12 AND hora < 18 THEN ABS(pointsTransaction) ELSE 0 END) / SUM(ABS(pointsTransaction)) AS pctPontosTarde,
    1.0 * SUM(CASE WHEN hora >= 18 AND hora <= 23 THEN ABS(pointsTransaction) ELSE 0 END) / SUM(ABS(pointsTransaction)) AS pctPontosNoite,

    -- 3. BLOCO DE QUANTIDADE DE TRANSAÇÕES 
    SUM(CASE WHEN hora >= 8 AND hora < 12 THEN 1 ELSE 0 END) AS qtdTransacoesManha,
    SUM(CASE WHEN hora >= 12 AND hora < 18 THEN 1 ELSE 0 END) AS qtdTransacoesTarde,
    SUM(CASE WHEN hora >= 18 AND hora <= 23 THEN 1 ELSE 0 END) AS qtdTransacoesNoite,

    -- 4. BLOCO DE PORCENTAGEM DE TRANSAÇÕES 
    1.0 * SUM(CASE WHEN hora >= 8 AND hora < 12 THEN 1 ELSE 0 END) / COUNT(*) AS pctTransacoesManha,
    1.0 * SUM(CASE WHEN hora >= 12 AND hora < 18 THEN 1 ELSE 0 END) / COUNT(*) AS pctTransacoesTarde,
    1.0 * SUM(CASE WHEN hora >= 18 AND hora <= 23 THEN 1 ELSE 0 END) / COUNT(*) AS pctTransacoesNoite

FROM tb_transaction_hour
GROUP BY idCustomer)

SELECT '{date}' AS dt_ref,
    * 

FROM tb_share_hora