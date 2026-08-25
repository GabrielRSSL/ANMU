dados <- data.frame(
  Metodo = c("A","A","A","A","A","B","B","B","B","B","C","C","C","C","C"),
  Nota = c(7.5, 8.0, NA, 6.5, 7.0, 8.5, 9.0, 8.7, NA, 9.2, 6.0, 6.5, 7.0, 6.8,
           NA),
  Horas = c(10, 12, 11, NA, 9, 14, 15, 13, 14, NA, 8, 9, 10, 9, 8),
  Frequencia = c(80, 85, 78, 82, NA, 90, 92, 88, 91, 93, 75, 78, NA, 77,
                 76)
)

View(dados)

is.na(dados) # valores faltantes no data frame
any(is.na(dados)) # verifica se tem algum valor faltante

colSums(is.na(dados)) # número de valores faltantes por coluna/variável
NAS <- round(colSums(is.na(dados))*100/nrow(dados), 2) # porcentagem de valores faltantes por variável
NAS

df_1 <- dados[!is.na(dados$Nota),] # removendo linhas com valores faltantes da variável nota
View(df_1)

grupo1 <- df_1[!is.na(df_1$Frequencia),] # variável Frequência com dados
grupo2 <- df_1[is.na(df_1$Frequencia),] # variável Frequência sem dados

t.test(grupo1$Horas, grupo2$Horas) # testando aleatoriedade da variável Horas
