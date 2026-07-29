import argparse
import sqlalchemy
import pandas as pd
import datetime
from tqdm import tqdm 


# Função para ler o arquivo SQL

def import_query(path):
    with open(path, 'r') as open_file:
        return open_file.read()

    
#funçao para ler as datas automaticamente 

def date_range(start,stop):
    dt_start = datetime.datetime.strptime(start , '%Y-%m-%d')
    dt_stop = datetime.datetime.strptime(stop , '%Y-%m-%d')
    dates = []
    while dt_start <= dt_stop:
        dates.append(dt_start.strftime('%Y-%m-%d'))
        dt_start += datetime.timedelta(days =1)
    return dates 

def ingest_date(query,table,dt):

    #  Substituição dinâmica da data '{date}'
    query_fmt = query.format(date=dt)

    #  Executando a query e trazendo para o DataFrame
    df = pd.read_sql(query_fmt, origin_engine)

    #  Garantindo integridade e enviando para o banco de destino
    with target_engine.connect() as con:
        state = f"DELETE FROM {table} WHERE dtRef = '{dt}';"
        con.execute(sqlalchemy.text(state))
        con.commit()

    df.to_sql(table, target_engine, index=False, if_exists='append')

# Configuração das engines (subindo duas pastas a partir de src/feature_store/ para achar a pasta data/)
origin_engine = sqlalchemy.create_engine("sqlite:///../../data/database.db")
target_engine = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")

# Importando a query (como execute.py e fs_general.sql estão na mesma pasta, basta o nome)

query = import_query("fs_general.sql")
dates = date_range('2024-03-01', '2024-06-01')

for i in tqdm(dates) : 
    ingest_date (query , 'fs_general', i)
