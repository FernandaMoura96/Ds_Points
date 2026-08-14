# %%


import pandas as pd
import sqlalchemy


# %%

# Aqui eu tenho a conexão com o banco de dados
engine = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")

# Aqui eu tenho a query
with open('abt.sql', 'r') as open_file:
    query = open_file.read()

# Aqui processa e tras os dados
df = pd.read_sql(query, engine)

df.head()
# %%
## Separação de bases entrei treino e oot

df_oot = df[df['dtRef']==df['dtRef'].max()]
df_train = df[df['dtRef']<df['dtRef'].max()]

# %%

target = 'flChurn'
features = df_train.columns[3:].tolist()

# %%

[]