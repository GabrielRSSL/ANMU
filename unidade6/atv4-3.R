# 3

funcionarios <- c(12,15,18,20,22,25,27,30,32,35)
publicidade <- c(8,10,12,13,15,17,18,20,22,25)
area <- c(350,420,500,550,620,700,760,820,900,980)
faturamento <- c(210,240,275,290,320,355,370,405,430,470)

dados <- data.frame(funcionarios,
                    publicidade,
                    area,
                    faturamento)

dados

modelo <- lm(faturamento ~ funcionarios +
               publicidade +
               area,
             data = dados)

summary(modelo)

coef(modelo)

# faturamento = 5.386472e+00*funcionarios 8.117333e+00*publicidade 5.679237e-05*area

# menos a area

modelo2 <- step(modelo)

summary(modelo2)

# Ajuste:
# Multiple R-squared:  0.9996,	Adjusted R-squared:  0.9995 
# F-statistic:  9107 on 2 and 7 DF,  p-value: 1.111e-12

# Comparação

AIC(modelo, modelo2)

anova(modelo2, modelo)

# Previsão

nova_loja <- data.frame(
  funcionarios = 28,
  publicidade = 19
)

predict(modelo2, newdata = nova_loja)
