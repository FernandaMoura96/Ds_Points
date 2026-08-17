# %% 

import pandas as pd

model_series = pd.read_pickle("../../models/rf_fim_de_curso.pkl")
# %%

engine =  sqlalke
with open ("etl.sql",'r')  as open_file:
    query = open_file.read()
