WITH tb_transaction_products AS (
    SELECT 
        t1.*,
        t2.NameProduct,
        t2.QuantityProduct
    FROM transactions AS t1
    LEFT JOIN transactions_product AS t2 
        ON t1.idTransaction = t2.idTransaction
    WHERE t1.dtTransaction < '2024-06-05'
      AND t1.dtTransaction >= DATE('2024-06-05', '-21 day')
)

SELECT 
    idCustomer,

    -- Agrupamento por Quantidade de Produtos
    SUM(CASE WHEN NameProduct = 'ChatMessage' THEN QuantityProduct ELSE 0 END) AS chatMessage,
    SUM(CASE WHEN NameProduct = 'Lista de presença' THEN QuantityProduct ELSE 0 END) AS ListaPresença,
    SUM(CASE WHEN NameProduct = 'Resgatar Ponei' THEN QuantityProduct ELSE 0 END) AS ResgatarPonei,
    SUM(CASE WHEN NameProduct = 'Troca de Pontos StreamElements' THEN QuantityProduct ELSE 0 END) AS TrocaStreamElements,
    SUM(CASE WHEN NameProduct = 'Presença Streak' THEN QuantityProduct ELSE 0 END) AS PresençaStreak,
    SUM(CASE WHEN NameProduct = 'Airflow Lover' THEN QuantityProduct ELSE 0 END) AS AirflowLover,
    SUM(CASE WHEN NameProduct = 'R Lover' THEN QuantityProduct ELSE 0 END) AS RLover,

    -- Agrupamento por Pontos da Transação
    SUM(CASE WHEN NameProduct = 'ChatMessage' THEN pointsTransaction ELSE 0 END) AS PTSChatMessage,
    SUM(CASE WHEN NameProduct = 'Lista de presença' THEN pointsTransaction ELSE 0 END) AS PTSListapresença,
    SUM(CASE WHEN NameProduct = 'Resgatar Ponei' THEN pointsTransaction ELSE 0 END) AS PTSResgatarPonei,
    SUM(CASE WHEN NameProduct = 'Troca de Pontos StreamElements' THEN pointsTransaction ELSE 0 END) AS PTSTrocaStreamElements,
    SUM(CASE WHEN NameProduct = 'Presença Streak' THEN pointsTransaction ELSE 0 END) AS PTSPresençaStreak,
    SUM(CASE WHEN NameProduct = 'Airflow Lover' THEN pointsTransaction ELSE 0 END) AS PTSAirflowLover,
    SUM(CASE WHEN NameProduct = 'R Lover' THEN pointsTransaction ELSE 0 END) AS PTSRLover
,
  --Agrupamento de share
    1.0 * SUM(CASE WHEN NameProduct = 'ChatMessage' THEN pointsTransaction ELSE 0 END) / SUM(QuantityProduct)  AS pctChatMessage,
    1.0 * SUM(CASE WHEN NameProduct = 'Lista de presença' THEN pointsTransaction ELSE 0 END)/ SUM(QuantityProduct)  AS pctListapresença,
    1.0 * SUM(CASE WHEN NameProduct = 'Resgatar Ponei' THEN pointsTransaction ELSE 0 END) / SUM(QuantityProduct) AS pctResgatarPonei,
    1.0 * SUM(CASE WHEN NameProduct = 'Troca de Pontos StreamElements' THEN pointsTransaction ELSE 0 END) / SUM(QuantityProduct) AS pctTrocaStreamElements,
    1.0 * SUM(CASE WHEN NameProduct = 'Presença Streak' THEN pointsTransaction ELSE 0 END)/ SUM(QuantityProduct)  AS pctPresençaStreak,
    1.0 * SUM(CASE WHEN NameProduct = 'Airflow Lover' THEN pointsTransaction ELSE 0 END)/ SUM(QuantityProduct)  AS pctAirflowLover,
    1.0 * SUM(CASE WHEN NameProduct = 'R Lover' THEN pointsTransaction ELSE 0 END)/ SUM(QuantityProduct)  AS pctRLover ,

    1.0 * SUM(CASE WHEN NameProduct = 'ChatMessage' THEN QuantityProduct ELSE 0 END) / COUNT (DISTINCT DATE(dtTransaction)) AS AVGChatLive 

FROM tb_transaction_products
GROUP BY idCustomer