# %%

import pandas as pd
import sqlalchemy

from sklearn import model_selection 
from sklearn import ensemble
from sklearn import pipeline

from feature_engine import encoding

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
X_train, X_test, y_train, y_test = model_selection.train_test_split(df_train[features],
                                                                    df_train[target],
                                                                    random_state= 42,
                                                                    train_size= 0.8)

print('Taxa de resposta na base train', y_train.mean())
print('Taxa de resposta na base test', y_test.mean())
# %%
cat_features = X_train.dtypes[X_train.dtypes == 'object'].index.tolist()
num_features = list(set(features) - set(cat_features))
num_features

# %%
X_train[cat_features].describe()

X_train[cat_features].drop_duplicates()
# %%
X_train[num_features].describe().T
# %%
X_train[num_features].isna().sum().max()
# %%
onehot = encoding.OneHotEncoder(variables =cat_features,
                                drop_last=True)
model = ensemble.RandomForestClassifier(random_state=42)

model_pipeline = pipeline.Pipeline([("One Hot Encode", onehot),
                                    ("Modelo",model)])
# %%
model_pipeline.fit(X_train, y_train)
# %%
