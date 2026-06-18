# 📊 Data Science & Pontos

Projeto completo de Data Science desenvolvido a partir da playlist **[Data Science & Pontos](https://www.youtube.com/playlist?list=PLvlkVRRKOYFQOkwDvfgCvKi9-I1jQXiy7)** do canal **Téo Me Why**, aplicado em ambiente local, do início ao fim — da definição do problema de negócio à entrega do modelo preditivo.

---

## 🎯 Objetivo

Construir um modelo de classificação para prever **churn de usuários** com base em dados reais do sistema de pontos da comunidade Téo Me Why — um programa de fidelidade onde participantes acumulam pontos durante lives e realizam trocas na lojinha.

---

## 🗂️ Estrutura do Projeto

```
ds-pontos/
├── data/
│   ├── raw/              # Dados brutos originais
│   └── processed/        # Dados tratados e prontos para modelagem
├── notebooks/
│   ├── 01_eda.ipynb      # Análise exploratória de dados
│   ├── 02_features.ipynb # Engenharia de features
│   └── 03_model.ipynb    # Treinamento e avaliação do modelo
├── src/
│   └── utils.py          # Funções auxiliares
├── requirements.txt
└── README.md
```

---

## 🔄 Etapas do Projeto

1. **Definição do problema de negócio** — entendimento do contexto e da métrica alvo (churn)
2. **Análise Exploratória (EDA)** — distribuições, padrões e outliers nos dados de pontos
3. **Engenharia de Features** — criação de variáveis comportamentais a partir do histórico de transações
4. **Modelagem** — treinamento e comparação de algoritmos de classificação
5. **Avaliação** — métricas de performance (AUC-ROC, F1-Score, Precision, Recall)

---

## 🛠️ Tecnologias e Bibliotecas

| Camada | Ferramentas |
|---|---|
| Linguagem | Python 3.x |
| Manipulação de dados | Pandas, NumPy |
| Visualização | Matplotlib, Seaborn |
| Machine Learning | Scikit-learn |
| Ambiente | Jupyter Notebook |
| Versionamento | Git / GitHub |

---

## ▶️ Como executar

```bash
# Clone o repositório
git clone https://github.com/FernandaMoura96/ds-pontos.git
cd ds-pontos

# Instale as dependências
pip install -r requirements.txt

# Execute os notebooks na ordem numerada dentro de /notebooks
```

---

## 📚 Referências

- Playlist original: [Data Science & Pontos — Téo Me Why](https://www.youtube.com/playlist?list=PLvlkVRRKOYFQOkwDvfgCvKi9-I1jQXiy7)
- Canal do autor: [youtube.com/@teomewhy](https://www.youtube.com/@teomewhy)
- Dataset: Sistema de Pontos da comunidade Téo Me Why (dados abertos)

---

## 👩‍💻 Autora

**Fernanda Moura**
Profissional em transição para Data Analytics | Ambev → Dados
[github.com/FernandaMoura96](https://github.com/FernandaMoura96)