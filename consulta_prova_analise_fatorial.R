###############################################################################
# ANALISE FATORIAL
# Unidade 5
#
# FLUXO:
# 1) Importar/selecionar variaveis
# 2) Normalizar
# 3) Matriz de correlacao
# 4) Bartlett + KMO
# 5) Determinar numero de fatores
# 6) Extrair fatores
# 7) Rotacionar (Varimax)
# 8) Ver cargas e comunalidades
# 9) Nomear fatores
# 10) Obter escores fatoriais
###############################################################################


#==============================================================================
# 0. PACOTES
#==============================================================================

if(!require(psych)) install.packages("psych")
if(!require(corrplot)) install.packages("corrplot")
if(!require(GPArotation)) install.packages("GPArotation")

library(psych)
library(corrplot)
library(GPArotation)


#==============================================================================
# 1. IMPORTACAO DOS DADOS
#==============================================================================

# Use APENAS a opcao correspondente ao arquivo da prova.

# CSV:
# dados <- read.csv("arquivo.csv", header = TRUE, sep = ",")

# CSV separado por ponto e virgula:
# dados <- read.csv("arquivo.csv", header = TRUE, sep = ";")

# Excel:
# if(!require(readxl)) install.packages("readxl")
# library(readxl)
# dados <- read_excel("arquivo.xlsx")

# SPSS (.sav):
# if(!require(haven)) install.packages("haven")
# library(haven)
# dados <- read_sav("arquivo.sav")

# TXT:
# dados <- read.table("arquivo.txt", header = FALSE)

# Se o banco ja estiver carregado no Environment:
# dados <- nome_do_banco

# Conferir:
head(dados)
str(dados)
summary(dados)


#==============================================================================
# 2. SELECIONAR SOMENTE AS VARIAVEIS QUE ENTRARAO NA ANALISE
#==============================================================================

# Exemplo por posicao:
# dados <- dados[, 7:19]

# Exemplo removendo uma coluna que NAO deve entrar:
# dados$identidade <- NULL

# Exemplo removendo varias colunas:
# dados <- dados[, !names(dados) %in% c("ID", "Nome")]

# IMPORTANTE:
# A analise fatorial deve ser feita com as variaveis numericas de interesse.


#==============================================================================
# 3. NORMALIZACAO
#==============================================================================

# Padroniza: media = 0 e desvio-padrao = 1
dados_norm <- scale(dados)

# Conferencia:
colMeans(dados_norm)       # aproximadamente 0
apply(dados_norm, 2, sd)   # aproximadamente 1


#==============================================================================
# 4. MATRIZ DE CORRELACAO
#==============================================================================

matcor <- cor(dados_norm)
print(matcor, digits = 2)

# Visualizacao:
corrplot(matcor, method = "circle")
corrplot(matcor, method = "number")

# REGRA DA AULA:
# Deve existir um numero substancial de correlacoes |r| > 0.30.
# Se quase todas as correlacoes forem muito pequenas, a analise fatorial
# provavelmente nao e apropriada.


#==============================================================================
# 5. TESTE DE BARTLETT
#==============================================================================

bartlett <- cortest.bartlett(dados_norm)
print(bartlett)

# INTERPRETACAO:
# H0: a matriz de correlacao e uma matriz identidade
#     => nao ha correlacoes significativas entre as variaveis.
#
# p-value < 0.05  -> rejeita H0
#                 -> existem correlacoes significativas
#                 -> favorece o uso da Analise Fatorial.
#
# p-value >= 0.05 -> nao rejeita H0
#                 -> Analise Fatorial pode nao ser adequada.


#==============================================================================
# 6. TESTE KMO / MSA
#==============================================================================

kmo <- KMO(dados_norm)
print(kmo)

# Ver MSA individual de cada variavel:
kmo$MSAi

# Ordenar do menor para o maior:
sort(kmo$MSAi)

# REGRAS APRESENTADAS NOS SLIDES:
# KMO > 0.80        -> adequado
# 0.70 < KMO < 0.80 -> aceitavel, mas com cautela
# 0.60 < KMO < 0.70 -> questionavel
# KMO < 0.50        -> inadequado
#
# NOS SCRIPTS DE AULA tambem aparece a regra pratica:
# KMO total > 0.60 e MSA individual > 0.50.

# Se uma variavel tiver MSA individual muito baixo, pode ser necessario remove-la.
# Exemplo:
# dados$NomeDaVariavel <- NULL
#
# Depois de remover, REPITA:
# dados_norm <- scale(dados)
# matcor <- cor(dados_norm)
# KMO(dados_norm)


#==============================================================================
# 7. DETERMINAR O NUMERO DE FATORES
#==============================================================================

#------------------------------------------------------------------------------
# 7.1 AUTOVALORES — CRITERIO DE KAISER
#------------------------------------------------------------------------------

ev <- eigen(matcor)

print(ev$values, digits = 2)

# Quantos autovalores sao >= 1?
print(ev$values[ev$values >= 1])

# Numero sugerido pelo criterio de Kaiser:
sum(ev$values >= 1)

# REGRA:
# autovalor > 1 -> fator candidato a ser mantido.


#------------------------------------------------------------------------------
# 7.2 PCA + VARIANCIA EXPLICADA
#------------------------------------------------------------------------------

PC <- princomp(dados_norm, cor = TRUE)

print(PC, digits = 2)
summary(PC)

# REGRA DA AULA:
# escolher fatores que expliquem, em conjunto, pelo menos cerca de 60%
# da variancia total.


#------------------------------------------------------------------------------
# 7.3 SCREE PLOT
#------------------------------------------------------------------------------

screeplot(PC, type = "lines")
abline(h = 1, col = "red", lwd = 2)

# Outra forma:
plot(PC, type = "lines")
abline(h = 1, col = "red", lwd = 2)

# INTERPRETACAO:
# procurar o "cotovelo" do grafico.
# Fatores antes da estabilizacao da curva tendem a ser mantidos.


#------------------------------------------------------------------------------
# 7.4 ANALISE PARALELA
#------------------------------------------------------------------------------

# A atividade da Unidade 5 pede Scree Plot + Analise Paralela.
fa.parallel(dados_norm,
            fa = "pc",
            n.iter = 100,
            show.legend = FALSE)

# A Analise Paralela compara os autovalores observados com autovalores
# obtidos em dados aleatorios. Use a quantidade sugerida pelo resultado
# em conjunto com Scree Plot, autovalores e variancia explicada.


#==============================================================================
# 8. ESCOLHER O NUMERO DE FATORES
#==============================================================================

# >>> ALTERE ESTE NUMERO DE ACORDO COM SUA ANALISE <<<
nfatores <- 3


#==============================================================================
# 9. MATRIZ DE FATORES — SEM ROTACAO
#==============================================================================

n <- nrow(dados_norm)

PCA_sem_rot <- principal(dados_norm,
                         nfactors = nfatores,
                         n.obs = n,
                         rotate = "none",
                         scores = TRUE)

PCA_sem_rot

# Ver cargas:
PCA_sem_rot$loadings

# Mostrar somente cargas acima de um corte:
print(PCA_sem_rot$loadings, cutoff = 0.40)


#==============================================================================
# 10. MATRIZ DE FATORES — ROTACAO VARIMAX
#==============================================================================

PCA_varimax <- principal(dados_norm,
                         nfactors = nfatores,
                         n.obs = n,
                         rotate = "varimax",
                         scores = TRUE)

PCA_varimax

# Cargas fatoriais:
PCA_varimax$loadings

# Corte generico para facilitar a leitura:
print(PCA_varimax$loadings, cutoff = 0.40)

# OBSERVACAO:
# Nos exemplos da aula foram usados cortes diferentes:
# 0.40, 0.55 e 0.75.
# Portanto, use o corte solicitado pelo professor ou um valor coerente
# com o exercicio.


#==============================================================================
# 11. COMO INTERPRETAR AS CARGAS FATORIAIS
#==============================================================================

# Cada LINHA = uma variavel.
# Cada COLUNA = um fator.
#
# Quanto maior |carga|, mais associada a variavel esta ao fator.
#
# Exemplo hipotetico:
#
#                 RC1    RC2
# Preco           0.82   0.10
# Promocoes       0.77   0.15
# Qualidade       0.08   0.86
#
# Entao:
# Fator 1 -> ligado a Preco/Promocoes
# Fator 2 -> ligado a Qualidade
#
# O NOME DO FATOR NAO VEM PRONTO:
# voce interpreta as variaveis com maiores cargas e cria um nome coerente.


#==============================================================================
# 12. COMUNALIDADES
#==============================================================================

PCA_varimax$communality

# Tambem aparecem na saida completa como h2.

# REGRA USADA NOS SCRIPTS DA AULA:
# h2 > 0.50 -> variavel razoavelmente bem explicada pelos fatores.
#
# h2 baixo -> a variavel e pouco explicada pela solucao fatorial
# e pode exigir avaliacao.


#==============================================================================
# 13. CARGAS CRUZADAS
#==============================================================================

# Carga cruzada:
# uma mesma variavel apresenta carga relativamente alta em mais de um fator.
#
# No exemplo HBAT da aula, as possibilidades consideradas foram:
# 1) ignorar o cruzamento;
# 2) eliminar a variavel;
# 3) usar outra tecnica de rotacao;
# 4) diminuir o numero de fatores.


#==============================================================================
# 14. ROTACAO QUARTIMAX — ALTERNATIVA
#==============================================================================

# Use se quiser testar outra rotacao, como no exemplo HBAT.

PCA_quartimax <- principal(dados_norm,
                           nfactors = nfatores,
                           n.obs = n,
                           rotate = "quartimax",
                           scores = TRUE)

PCA_quartimax
print(PCA_quartimax$loadings, cutoff = 0.40)


#==============================================================================
# 15. ESCORES FATORIAIS
#==============================================================================

escores <- PCA_varimax$scores

head(escores)

dados_fatores <- data.frame(escores)

View(dados_fatores)


# Opcional: renomear fatores apos interpreta-los.
# EXEMPLO:
# colnames(dados_fatores) <- c("Valor_Preco",
#                              "Qualidade_Produto",
#                              "Servico_Logistica")


#==============================================================================
# 16. EXPORTAR OS ESCORES
#==============================================================================

write.csv(dados_fatores,
          "escores_fatoriais.csv",
          row.names = FALSE)


###############################################################################
# RESUMAO PARA A PROVA
###############################################################################

# 1) CORRELACAO:
#    procurar varias correlacoes |r| > 0.30.
#
# 2) BARTLETT:
#    p < 0.05 -> ha correlacao -> favorece Analise Fatorial.
#
# 3) KMO:
#    > 0.80 -> adequado
#    0.70-0.80 -> aceitavel/cautela
#    0.60-0.70 -> questionavel
#    < 0.50 -> inadequado
#    Scripts: MSA individual > 0.50.
#
# 4) NUMERO DE FATORES:
#    - autovalor > 1
#    - Scree Plot ("cotovelo")
#    - Analise Paralela
#    - variancia acumulada >= aproximadamente 60%
#
# 5) ROTACAO:
#    Varimax = principal metodo usado na aula.
#
# 6) CARGAS:
#    carga alta em um fator -> variavel ajuda a definir aquele fator.
#
# 7) COMUNALIDADE:
#    h2 > 0.50 -> variavel bem explicada pelos fatores.
#
# 8) NOME DO FATOR:
#    olhar quais variaveis possuem maiores cargas naquele fator
#    e encontrar a ideia/conceito comum entre elas.
#
# 9) OBJETIVO DA ANALISE FATORIAL:
#    resumir muitas variaveis correlacionadas em um numero menor
#    de fatores/dimensoes, com perda minima de informacao.
#
# 10) ANALISE FATORIAL:
#     tecnica de INTERDEPENDENCIA: nao existe uma variavel dependente
#     definida; as variaveis sao analisadas simultaneamente.
###############################################################################
