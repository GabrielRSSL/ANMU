treinamento <- c(2,3,4,5,6,7,8,9,10,11)
vendas <- c(18,20,23,25,27,30,32,35,36,40)
dados <- data.frame(treinamento, vendas)
dados

# Variável resposta = y, variável explicativa = x

correlacao <- cor(dados)
print(correlacao, digits = 3) # existe correlação forte
View(correlacao)

modelo <- lm(dados, formula = vendas ~ treinamento) # vendas = y, treinamento = x
modelo$coefficients
print(modelo$coefficients, digits = 4)

# vendas = 13.079 + 2.388

summary(modelo)

# ambos r² quase 100%; valor de p menor que 0 -> modelo ajustado; teste t

# análise gráfica
plot(modelo, which = c(1:3), pch = 20)

# p < 0.05 quer dizer que residuos não são normais
shapiro.test(modelo$residuals)

# p < 0.05 significa que residuos são autocorrelacionados
if(!require(car)) install.packages("car")
library(car)
durbinWatsonTest(modelo)

# gráfico de dispersão
plot(dados$treinamento, dados$vendas)
abline(modelo, col='blue')
plot(dados$treinamento, dados$vendas)
abline(modelo, col='red', lwd = 2)
