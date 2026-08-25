#%%
import pandas as pd
import sqlalchemy



model_series = pd.read_pickle("../../models/rf_fim_curso.pkl")
model_series

#%%

engine = sqlalchemy.create_engine("sqlite:///../../data/feature_store.db")

# ATENÇÃO AQUI: Adicionado o encoding='utf-8'
with open("etl.sql", 'r', encoding='utf-8') as open_file:
    query = open_file.read()

# Carrega os dados
df = pd.read_sql(query, engine)
#%%
# Faz a predição
pred = model_series['model'].predict_proba(df[model_series['features']])
proba_churn = pred[:, 1]

df_predict = df[['idCustomer']].copy()
df_predict['prob_churn'] = proba_churn
df_predict = (df_predict.sort_values("prob_churn", ascending=False))
# %%
df_predict
# %%
