# %% 
import pandas as pd
import sqlalchemy

# 1. Carrega o modelo treinado (certifique-se de que o nome do arquivo bate com o do treino)
model_series = pd.read_pickle("../../models/rf_fim_curso.pkl")

# 2. Conexão com o banco de dados
engine = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")

# 3. Leitura correta do arquivo SQL (com os parênteses no .read())
with open("etl.sql", "r") as open_file:
    query = open_file.read()

# 4. Carrega os dados da base mais recente através da query
df = pd.read_sql(query, engine)

# %%
# 5. Extrai o pipeline e a lista correta de features salvas no modelo
pipeline_modelo = model_series["model"]
features_modelo = model_series["features"]

# 6. Aplica a predição de probabilidade usando apenas as colunas treinadas
pred = pipeline_modelo.predict_proba(df[features_modelo])

# Exibe o resultado das probabilidades
print(pred)


# %%