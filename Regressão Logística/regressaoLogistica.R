# Regressão Logística - uma introdução

# Exemplo 1: Regressão Logística Simples ----

# Vamos utilizar o conjunto de dados mtcars com o objetivo de:
# O peso do automóvel influencia a probabilidade de ele possuir transmissão manual?
# Em resumo: Dado um peso do automóvel, qual a probabilidade dele possuir transmissão manual.

# Variáveis: am: 0 - automático e 1 - manual
# wt: peso em milhares de libras

### 1) Carregando conjunto de dados ----

dados <- mtcars
View(dados)

dados <- data.frame(dados$am, dados$wt)
View(dados)

names(dados) <- c("transmissao", "peso")
View(dados)

### 2) Verificar qual a frequência da distribuição dos dados ----
table(dados$transmissao)

### 3) Ajustando o modelo ----
modelo <- glm(transmissao ~ peso,
              data = dados,
              family = binomial(link = "logit"))

summary(modelo)

### 4) Prevendo a probabilidade ----

# Suponha que um carro com 3 mil libras. Qual a probabilidade de ter transmissão manual?

# E de ter transmissão automática?

novo <- data.frame(peso = 3)

predict(modelo,
        newdata = novo,
        type = "response") # para retornar a probabilidade estimada

# 49,21% de ter transmissão manual
# 100% - 49,21% = 50,79% de ter transmissão automática


# Exemplo 2: Regressão Logística Múltipla ----

# Vamos acrescentar a variável hp (potência) no conjunto de dados

# Queremos saber qual a probabilidade de um automóvel ter transmissão manual 
# tendo as variáveis peso e potência.

### 1) Carregando o conjunto de dados ----

dados$potencia <- mtcars$hp
View(dados)

### 2) Ajustando o modelo ----

modelo2 <- glm(transmissao ~ peso + potencia,
               data = dados,
               family = binomial(link = "logit"))

summary(modelo2)

# Aumentar peso diminui a probabilidade
# Aumentar potencia aumenta a probabilidade

### 3) Comparando os modelos ----
# Analisa-se o AIC, quanto menor, é melhor

AIC(modelo, modelo2)

### 4) Calculando a probabilidade ----
# Automóvel A: peso = 2,5 e potencia = 100
# Automóvel B: peso = 3,5 e potencia = 180

novo <- data.frame(
  peso = c(2.5, 3.5),
  potencia = c(100, 180))

predict(modelo2,
        newdata = novo,
        type = "response")

# Atividade de fixação ----
# Banco de dados no Moodle (Banco de Dados.csv)

# Qual a probabilidade de desenvolver câncer no indivíduo que fuma e tem alto índice de estresse.

### 1) Carregando os dados ----

dados <- Banco.de.Dados
View(dados)

### 2) Ajustando o modelo ----

modelo3 <- glm(Cancer ~ Hab_Fumar + Estresse,
               data = dados,
               family = binomial(link = "logit"))

summary(modelo3)

# Quanto maior o estresse maior a chance, mas o hábito de fumar tem ainda maior relação com a chance
# de desenvolver câncer

### 3) Prevendo a probabilidade ----
# Supondo a probabilidade com quatro indivíduos

mean(dados$Estresse)

# (A) Tem o índice médio (48) de estresse e fuma  de estresse desenvolver câncer
# (B) Tem o índice médio (48) de estresse e não fuma
# (C) Tem um índice maior (70) de estresse e não fuma.
# (D) Tem um índice maior (70) e fuma


novo <- data.frame(
  Estresse = c(48, 48, 70, 70),
  Hab_Fumar = c(1, 0, 0, 1))

predict(modelo3,
        newdata = novo,
        type = "response")

### 4) Conclusão ----

# 76,87% de A desenvolver câncer
# 27,6% de B desenvolver câncer
# 43,48% de C desenvolver câncer
# 87,02% de D desenvolver câncer

# Conclusão: o hábito de fumar tem maior relação com o desenvolvimento de câncer do que o estresse,
# embora esse último também tenha relação.
