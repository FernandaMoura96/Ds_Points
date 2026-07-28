
# %% 
import sqlalchemy
import pandas as pd

# 1. Função para ler o arquivo SQL
def import_query(path):
    with open(path, 'r', encoding='utf-8') as open_file:
        return open_file.read()

# 2. Configuração das engines dos bancos de dados
origin_engine = sqlalchemy.create_engine("sqlite:///../../data/database.db")
target_engine = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")

# 3. Importando a query 
query = import_query("fs_general.sql")

# 4. Substituição dinâmica da data '{date}'
query_fmt = query.format(date='2024-06-06')

# 5. Executando a query e visualizando o resultado
df = pd.read_sql(query_fmt, origin_engine)
df.head()
# 6.  Enviando os dados para o novo database
df.to_sql('fs_general', target_engine , index = False)


# %%
