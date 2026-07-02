WITH tb_transaction_products AS (
    SELECT 
        t1.*,
        t2.NameProduct,
        t2.QuantityProduct
    FROM transactions AS t1
    LEFT JOIN transactions_product AS t2 
        ON t1.idTransaction = t2.idTransaction
    WHERE t1.dtTransaction < '{date}'
      AND t1.dtTransaction >= DATE('{date}', '-21 day')
),

tb_share AS (


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
    SUM(CASE WHEN NameProduct = 'R Lover' THEN pointsTransaction ELSE 0 END) AS PTSRLover,


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
),

-- Agrupando produtos

tb_group AS 
(

    SELECT
        idCustomer,
        NameProduct,
        SUM(QuantityProduct) AS QtD ,
        SUM(pointsTransaction) AS points

    FROM tb_transaction_products

    GROUP BY idCustomer,NameProduct
),

-- window function (rankeando os produtos mais usados por cada entidade)
tb_rn AS (

SELECT * ,
ROW_NUMBER () OVER (PARTITION BY idCustomer ORDER BY QtD DESC , points DESC) AS rn

FROM tb_group 
),

--selecionando o produto mais comprado por cada um, ordendo 1 por entidade, e join com o share de cada.
tb_produto_max AS
(
SELECT * 

FROM  tb_rn

WHERE rn =1)

SELECT  t1.*,
        t2.NameProduct

FROM tb_share AS t1

LEFT JOIN 
tb_produto_max AS t2

ON t1.idCustomer = t2.idCustomer