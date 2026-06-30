WITH tb_transaction_products AS 

(
SELECT t1.* ,
        t2.NameProduct,
        t2.QuantityProduct

FROM transactions AS t1

LEFT JOIN transactions_product AS t2 
ON t1.idTransaction = t2.idTransaction

  WHERE t1.dtTransaction < '2024-06-05'
    AND t1.dtTransaction >= DATE('2024-06-05', '-21 day')
)


SELECT idCustomer,

sum(CASE 
    
    WHEN NameProduct = 'ChatMessage' 
      THEN QuantityProduct 
        ELSE 0 
    END) AS chatMessage,
sum(CASE
    
     WHEN NameProduct = 'Lista de presença' 
      THEN QuantityProduct
         ELSE 0
     END) AS ListaPresença,
sum(CASE
    
     WHEN NameProduct = 'Resgatar Ponei' 
      THEN QuantityProduct 
        ELSE 0 
    END) AS ResgatarPonei,
sum(CASE
    
    WHEN NameProduct = 'Troca de Pontos StreamElements' 
      THEN QuantityProduct 
        ELSE 0 
    END) AS TrocaStreamElements,
sum(CASE 
    
    WHEN NameProduct = 'Presença Streak' 
      THEN QuantityProduct 
        ELSE 0 
    END) AS PresençaStreak,
sum(CASE 
    
    WHEN NameProduct = 'Airflow Lover' 
      THEN QuantityProduct 
      ELSE 0 
  END) AS AirflowLover,
sum(CASE 
    
    WHEN NameProduct = 'R Lover'  
      THEN QuantityProduct 
        ELSE 0 
    END) AS RLover

FROM tb_transaction_products

    
GROUP BY idCustomer