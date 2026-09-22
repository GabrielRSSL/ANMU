# ================================================================
# REGRESSAO LINEAR SIMPLES E REGRESSAO MULTIPLA
# UNIDADE 6
# 
#
# COMO USAR:
# 1) Importe/abra o banco de dados no RStudio.
# 2) Coloque-o no objeto "dados" (ex.: dados <- arvore).
# 3) Troque APENAS os nomes das variaveis nos modelos.
# 4) Rode somente o bloco que a questao pedir.
# ================================================================


# ================================================================
# 0. PACOTES
# ================================================================
# Os scripts do professor usam principalmente:
# psych    -> pairs.panels()
# car      -> durbinWatsonTest() e vif()
# corrplot -> corrplot()
#
# ANTES DA PROVA, se necessario:
# install.packages(c("psych", "car", "corrplot"))
#
# Durante a prova, prefira chamar assim:
# psych::pairs.panels(dados)
# car::durbinWatsonTest(modelo)
# car::vif(modelo)
# corrplot::corrplot(matcor, method = "number")


# ================================================================
# 1. PRIMEIRO: IDENTIFICAR AS VARIAVEIS
# ================================================================
# Y = variavel DEPENDENTE / RESPOSTA / aquilo que quero prever
# X = variavel INDEPENDENTE / EXPLICATIVA / aquilo que explica Y
#
# Regressao simples:
#       Y = alfa + beta*X
#
# Regressao multipla:
#       Y = b0 + b1*X1 + b2*X2 + ... + bk*Xk


# EXTRA PRATICO PARA CONFERIR O BANCO:
# names(dados)
# str(dados)
# View(dados)


# ================================================================
# 2. CORRELACAO / LINEARIDADE
# ================================================================
# Matriz de correlacao:
# matcor <- cor(dados)
# matcor
# View(matcor)

# Graficos de correlacao (se o pacote psych estiver instalado):
# psych::pairs.panels(dados)

# Outra visualizacao usada no exemplo HBAT:
# corrplot::corrplot(matcor, method = "circle")
# corrplot::corrplot(matcor, method = "number")

# IDEIA PARA A PROVA:
# Na regressao simples, o material escolhe como X uma variavel
# com forte correlacao com Y.


# ================================================================
# 3. NORMALIDADE DAS VARIAVEIS - SHAPIRO-WILK
# ================================================================
# H0: os dados possuem distribuicao normal
#
# p-value > 0.05 -> NAO rejeito H0 -> compatível com normalidade
# p-value < 0.05 -> rejeito H0 -> nao normal
#
# Troque x1 pelo nome da variavel:
# shapiro.test(dados$x1)
# shapiro.test(dados$x2)


# ================================================================
# 4. REGRESSAO LINEAR SIMPLES
# ================================================================
# EXEMPLO DOS ARQUIVOS:
# Y = altura_m
# X = diametro_cm
#
# modelo <- lm(altura_m ~ diametro_cm, data = dados)

# MODELO GENERICO:
# TROQUE "y" e "x" pelos nomes verdadeiros:
# modelo <- lm(y ~ x, data = dados)

# Coeficientes da equacao:
# modelo$coefficients
# coef(modelo)

# Resultado completo:
# summary(modelo)


# ================================================================
# 5. COMO LER O summary(modelo) RAPIDAMENTE
# ================================================================
# summary(modelo)
#
# COEFFICIENTS:
# Estimate -> valores estimados dos coeficientes
#   (Intercept) = alfa / b0
#   x           = beta / b1
#
# Pr(>|t|) -> p-value do TESTE t de cada coeficiente
#
# H0: coeficiente = 0
# p-value < 0.05 -> rejeita H0 -> coeficiente significativo
# p-value > 0.05 -> nao rejeita H0
#
# Multiple R-squared:
# porcentagem/proporcao da variacao de Y explicada pelo modelo.
# No material: quanto mais proximo de 1, maior a variacao explicada.
#
# Adjusted R-squared:
# R² ajustado; muito importante na regressao multipla.
#
# F-statistic:
# testa a significancia GLOBAL do modelo.
# Se o p-value do teste F < 0.05, rejeita-se H0 do modelo
# somente com intercepto.


# ================================================================
# 6. EQUACAO DA RETA / INTERPRETACAO DOS COEFICIENTES
# ================================================================
# Se o R mostrar:
# (Intercept) = 10
# x           = 2
#
# Equacao:
# Y_estimado = 10 + 2*X
#
# Interpretacao do beta:
# "Para cada aumento de 1 unidade em X, Y estimado aumenta,
#  em media, 2 unidades."
#
# Se beta for negativo:
# "Para cada aumento de 1 unidade em X, Y estimado diminui,
#  em media, |beta| unidades."
#
# Intercepto:
# valor estimado de Y quando X = 0.


# ================================================================
# 7. GRAFICO DE DISPERSAO + RETA AJUSTADA
# ================================================================
# Usado/solicitado nas atividades de regressao simples:
#
# plot(dados$x, dados$y,
#      xlab = "X",
#      ylab = "Y",
#      main = "Regressao linear simples")
# abline(modelo)
#
# Exemplo adaptado para ARVORE:
# plot(dados$diametro_cm, dados$altura_m)
# abline(modelo)


# ================================================================
# 8. ANALISE DOS RESIDUOS
# ================================================================
# Graficos usados nos scripts:
# plot(modelo, which = c(1:3), pch = 20)
#
# O material pede residuos com:
# - comportamento aproximadamente linear
# - variancia constante
# - independencia
# - normalidade


# ================================================================
# 9. NORMALIDADE DOS RESIDUOS - SHAPIRO-WILK
# ================================================================
# H0: os residuos possuem distribuicao normal
#
# shapiro.test(modelo$residuals)
#
# p-value > 0.05 -> NAO rejeito H0 -> residuos compatíveis com normalidade
# p-value < 0.05 -> rejeito H0 -> residuos nao normais


# ================================================================
# 10. INDEPENDENCIA DOS RESIDUOS - DURBIN-WATSON
# ================================================================
# H0: nao ha correlacao entre os residuos
#
# car::durbinWatsonTest(modelo)
#
# p-value > 0.05 -> NAO rejeito H0 -> sem evidencia de autocorrelacao
# p-value < 0.05 -> rejeito H0 -> evidencia de autocorrelacao
#
# No script de regressao simples, o valor do teste proximo de 2
# (aprox. 1.5 a 2 no comentario do arquivo) e usado como referencia.


# ================================================================
# 11. REGRESSAO MULTIPLA
# ================================================================
# MODELO GENERICO:
# modelo <- lm(y ~ x1 + x2 + x3, data = dados)
#
# EXEMPLO DA ATIVIDADE:
# modelo <- lm(produtividade ~ treinamento + experiencia + faltas,
#              data = dados)
#
# EXEMPLO DO SCRIPT:
# modelo <- lm(y ~ x1 + x2 + x3 + x4, data = dados)

# Ver coeficientes:
# modelo$coefficients

# Ver teste t, R², R² ajustado e teste F:
# summary(modelo)


# ================================================================
# 12. INTERPRETACAO DOS COEFICIENTES NA REGRESSAO MULTIPLA
# ================================================================
# Exemplo:
# Y = b0 + b1*X1 + b2*X2 + b3*X3
#
# b1:
# efeito estimado de X1 sobre Y MANTENDO AS DEMAIS VARIAVEIS
# DO MODELO CONSTANTES.
#
# Para saber se X1 e estatisticamente significativa:
# olhe Pr(>|t|) no summary(modelo).
# p-value < 0.05 -> significativa ao nivel de 5%.


# ================================================================
# 13. MULTICOLINEARIDADE - VIF
# ================================================================
# Usado nos scripts de regressao multipla:
#
# car::vif(modelo)
#
# REGRA DO MATERIAL:
# VIF < 10 -> situacao aceitavel
# VIF > 10 -> existe problema de multicolinearidade


# ================================================================
# 14. STEPWISE - SELECAO DE VARIAVEIS
# ================================================================
# Primeiro monta o modelo com todas as variaveis:
#
# modeloStep <- lm(y ~ x1 + x2 + x3 + x4, data = dados)
#
# Depois:
# s <- step(modeloStep)
# s$coefficients
# summary(s)
#
# No material, o stepwise faz busca sequencial das variaveis
# independentes que vao compor o modelo.


# ================================================================
# 15. AVALIAR O MODELO SELECIONADO PELO STEPWISE
# ================================================================
# summary(s)                       # t, R², R² ajustado e F
# plot(s, which = c(1:3), pch=20) # residuos
# car::durbinWatsonTest(s)         # independencia
# shapiro.test(s$residuals)        # normalidade
# car::vif(s)                      # multicolinearidade


# ================================================================
# 16. COMPARACAO DE MODELOS - AIC
# ================================================================
# Usado nos scripts:
#
# AIC(modelo1, modelo2)
#
# REGRA DO MATERIAL:
# MENOR AIC = melhor entre os modelos comparados.


# ================================================================
# 17. PREVISAO DE UM NOVO VALOR
# ================================================================
# A atividade pede previsao usando predict().
#
# REGRESSAO SIMPLES:
# predict(modelo,
#         newdata = data.frame(x = NOVO_VALOR))
#
# REGRESSAO MULTIPLA:
# predict(modelo,
#         newdata = data.frame(x1 = VALOR1,
#                              x2 = VALOR2,
#                              x3 = VALOR3))
#
# EXEMPLO EXATO DA ATIVIDADE:
# predict(modelo,
#         newdata = data.frame(funcionarios = 28,
#                              publicidade = 19,
#                              area = 800))


# ================================================================
# 18. MODELO SEM INTERCEPTO
# ================================================================
# Aparece nos scripts de regressao simples:
#
# modelo_sem_intercepto <- lm(y ~ -1 + x, data = dados)
# summary(modelo_sem_intercepto)


# ================================================================
# 19. MQO MANUAL - SE PEDIREM ALFA E BETA "NA MAO"
# ================================================================
# Baseado no exemplo de cartao de credito.
#
# y <- dados$VARIAVEL_Y
# x <- dados$VARIAVEL_X
#
# ymedia <- mean(y)
# xmedia <- mean(x)
#
# Yi <- y - ymedia
# Xi <- x - xmedia
#
# beta <- sum(Yi * Xi) / sum(Xi^2)
# alfa <- ymedia - beta * xmedia
#
# c(alfa = alfa, beta = beta)
#
# Y previsto:
# yp <- alfa + beta*x
#
# Soma de quadrados da regressao:
# SQReg <- sum((yp - ymedia)^2)
#
# Soma total de quadrados:
# STQ <- sum((y - ymedia)^2)
#
# R²:
# R2 <- SQReg / STQ
# R2


# ================================================================
# 20. ROTEIRO DE RESPOSTA - REGRESSAO SIMPLES
# ================================================================
# Se a questao disser "ajuste e interprete uma regressao simples":
#
# 1) modelo <- lm(y ~ x, data=dados)
# 2) modelo$coefficients
# 3) summary(modelo)
# 4) escrever a equacao: Y = alfa + beta*X
# 5) interpretar beta
# 6) comentar R²
# 7) olhar p-value do teste t
# 8) olhar p-value do teste F
# 9) plot(modelo, which=c(1:3), pch=20)
# 10) shapiro.test(modelo$residuals)
# 11) car::durbinWatsonTest(modelo)
# 12) se pedir previsao: predict(...)


# ================================================================
# 21. ROTEIRO DE RESPOSTA - REGRESSAO MULTIPLA
# ================================================================
# Se a questao disser "ajuste e interprete uma regressao multipla":
#
# 1) modelo <- lm(y ~ x1 + x2 + x3, data=dados)
# 2) modelo$coefficients
# 3) summary(modelo)
# 4) escrever a equacao
# 5) verificar p-value de cada coeficiente (teste t)
# 6) verificar R² e R² ajustado
# 7) verificar teste F global
# 8) car::vif(modelo)
# 9) plot(modelo, which=c(1:3), pch=20)
# 10) shapiro.test(modelo$residuals)
# 11) car::durbinWatsonTest(modelo)
# 12) se pedir selecao: s <- step(modelo)
# 13) se comparar modelos: AIC(modelo1, modelo2)
# 14) se pedir previsao: predict(...)


# ================================================================
# 22. TABELA MENTAL DE DECISAO - A MAIS IMPORTANTE
# ================================================================
#
# TESTE t DO COEFICIENTE
# H0: coeficiente = 0
# p < 0.05 -> coeficiente significativo
#
# TESTE F GLOBAL
# H0: modelo somente com intercepto e suficiente
# p < 0.05 -> modelo com explicativas melhora o ajuste
#
# SHAPIRO-WILK DOS RESIDUOS
# H0: residuos normais
# p > 0.05 -> normalidade nao rejeitada
#
# DURBIN-WATSON
# H0: residuos nao correlacionados
# p > 0.05 -> independencia nao rejeitada
#
# VIF
# < 10 -> aceitavel segundo o material
# > 10 -> multicolinearidade
#
# AIC
# menor = melhor entre os modelos comparados
#
# R² / R² AJUSTADO
# quanto maior, maior a proporcao de variacao explicada
#
# ================================================================
# FIM
# ================================================================
