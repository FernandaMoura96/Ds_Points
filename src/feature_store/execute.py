

import sqlalchemy
import pandas as pd

# 1. Função para ler o arquivo SQL
def import_query(path):
    with open(path, 'r') as open_file:
        return open_file.read()

# 2. Configuração das engines (subindo duas pastas a partir de src/feature_store/ para achar a pasta data/)
origin_engine = sqlalchemy.create_engine("sqlite:///../../data/database.db")
target_engine = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")

# 3. Importando a query (como execute.py e fs_general.sql estão na mesma pasta, basta o nome)
query = import_query("fs_general.sql")

# 4. Substituição dinâmica da data '{date}'
query_fmt = query.format(date='2024-06-07')

# 5. Executando a query e trazendo para o DataFrame
df = pd.read_sql(query_fmt, origin_engine)

# 6. Garantindo integridade e enviando para o banco de destino
with target_engine.connect() as con:
    state = "DELETE FROM fs_general WHERE dtRef = '2024-06-07';"
    con.execute(sqlalchemy.text(state))
    con.commit()

df.to_sql('fs_general', target_engine, index=False, if_exists='append')