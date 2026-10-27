# Gabriel Pereira de Oliveira

# ----- Atividade MANOVA -----

# Banco de dados
# Definir semente para reprodutibilidade
set.seed(123)
# Criar os dados simulados
n <- 30 # número de participantes por grupo
metodo_A <- data.frame(
  Treino = "Metodo_A",
  Produtividade = rnorm(n, mean = 75, sd = 8),
  Satisfacao = rnorm(n, mean = 80, sd = 7)
)
metodo_B <- data.frame(
  Treino = "Metodo_B",
  Produtividade = rnorm(n, mean = 70, sd = 9),
  Satisfacao = rnorm(n, mean = 68, sd = 8)
)
controlo <- data.frame(
  Treino = "Controlo",
  Produtividade = rnorm(n, mean = 60, sd = 10),
  Satisfacao = rnorm(n, mean = 62, sd = 9)
)
# Unir os dados num único dataframe
dados_treino <- rbind(metodo_A, metodo_B, controlo)
dados_treino$Treino <- as.factor(dados_treino$Treino)
# Visualizar as primeiras linhas
head(dados_treino)

# (1) Análise Descritiva. A média:
aggregate(cbind(Produtividade, Satisfacao) ~ Treino,
          data = dados_treino,
          FUN = mean)

# (1) Análise Descritiva. O desvio padrão:
aggregate(cbind(Produtividade, Satisfacao) ~ Treino,
          data = dados_treino,
          FUN = sd)

# (2) testes de shapiro (para as duas variáveis)
shapiro.test(dados_treino$Produtividade) #não normal
shapiro.test(dados_treino$Satisfacao) #normal

# (3) MANOVA

#modelo
modelo <- manova(cbind(Produtividade, Satisfacao) ~ Treino, data=dados_treino)

summary(modelo)  #Teste Pillai

#existe diferença significativa
#ou seja, o tipo de treino influenciou as respostas

summary.aov(modelo)

#em ambas as variáveis, houve diferença significativa, indicados pelo valor de p < 0,05
#ou seja, as duas foram influenciadas pelo tipo de treino

# ----- Atividade 2 -----

# (1)
dados <- data.frame(
  Ensino = factor(c(rep("Tradicional",10), rep("Hibrida",10), rep("Projetos",10))),
  Matematica = c(
    68,70,72,69,71,73,74,70,72,71,
    75,77,78,80,79,81,82,76,78,79,
    82,84,85,87,86,88,89,83,85,86),
  Estatistica = c(
    66,68,71,65,69,72,70,67,70,69,
    73,76,75,79,77,80,81,74,77,78,
    79,83,82,86,84,87,88,81,84,85),
  Programacao = c(
    71,74,73,72,75,77,76,73,75,74,
    78,81,80,83,82,84,85,79,81,82,
    86,88,87,91,89,92,93,87,89,90))

# (a) médias de cada grupo
aggregate(cbind(Matematica, Estatistica, Programacao) ~ Ensino,
          data = dados,
          FUN = mean)

# (b) Pressupostos manova: normalidade multivariada
shapiro.test(dados$Matematica) #normal
shapiro.test(dados$Estatistica) #normal
shapiro.test(dados$Programacao) #normal

# (c)
modelo <- manova(cbind(Matematica, Estatistica, Programacao) ~ Ensino, data=dados)

# (d) testes de Wilks e Pillai
summary(modelo, test="Wilks")  #Teste lambda de Wilks
summary(modelo)  #Teste Pillai

#ambos resultaram em p < 0,05, o que significa que há diferença significativa entre as variáveis
#o que também significa que o tipo de ensino influenciou

# (e)

summary.aov(modelo)

# (f)

#Os grupos diferem nas três disciplinas (p < 0,05 nas ANOVAs univariadas)

# (g)

# Analisando as médias, a metodologia com melhores resultados foi a "Projetos"

# (2)
dados <- data.frame(
  Treinamento = factor(c(
    rep("Musculacao",10),
    rep("Funcional",10),
    rep("Cross",10)
  )),
  Forca = c(
    80,82,84,83,81,85,86,82,84,83,
    79,81,80,82,83,81,80,82,81,79,
    92,94,93,95,91,96,94,93,95,92),
  Resistencia = c(
    75,77,74,76,75,78,76,74,77,75,
    76,75,77,74,76,75,78,76,74,77,
    75,76,74,77,75,76,75,77,74,76),
  Flexibilidade = c(
    70,72,71,69,73,70,71,72,69,71,
    71,70,72,71,69,72,70,71,72,70,
    70,71,69,72,70,71,70,72,69,71))

# (a)
aggregate(cbind(Forca, Resistencia, Flexibilidade) ~ Treinamento,
          data = dados,
          FUN = mean)

# (b)

shapiro.test(dados$Forca) # não normal
shapiro.test(dados$Resistencia) # não normal
shapiro.test(dados$Flexibilidade) #não normal

# (c)

modelo <- manova(cbind(Forca, Resistencia, Flexibilidade) ~ Treinamento, data = dados)

# (d)

summary(modelo, test="Wilks")
summary(modelo)

#ambos os testes mostram que há diferença significativa

# (e)

summary.aov(modelo)

# (f)

# os grupos diferem significativamente apenas no treinamento força

# (g)

# analisando as médias, o Cross mostrou maior força que os outros treinamentos
