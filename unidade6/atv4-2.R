#a)
treinamento <- c(2,3,4,5,6,7,8,9,10,11)
experiencia <- c(1,2,2,3,4,5,5,6,7,8)
faltas <- c(5,4,4,3,3,2,2,1,1,0)
produtividade <- c(52,55,58,62,66,70,73,77,81,85)
dados <- data.frame(treinamento,
                    experiencia,
                    faltas,
                    produtividade)

#b
matcor <- dados
matcor

modelo <- lm(produtividade ~ treinamento +
               experiencia +
               faltas,
             data = dados)

summary(modelo)

#c
coef(modelo)

#d
# todas menos "faltas"

#e
# Multiple R-squared:  0.9995,	Adjusted R-squared:  0.9993 
# F-statistic:  4246 on 3 and 6 DF,  p-value: 2.282e-10

#f

library(car)
vif(modelo)

#g

residuos <- residuals(modelo)
residuos

plot(modelo, which = 1)
plot(modelo, which = 2)

#h

novo_funcionario <- data.frame(
  treinamento = 12,
  experiencia = 6,
  faltas = 1
)

predict(modelo, newdata = novo_funcionario)
