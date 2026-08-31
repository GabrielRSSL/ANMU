#banco de dados
dados <- data.frame(
  Metodo = c("A","A","A","A","A","B","B","B","B","B","C","C","C","C","C"),
  Nota = c(7.5, 8.0, NA, 6.5, 7.0, 8.5, 9.0, 8.7, NA, 9.2, 6.0, 6.5, 7.0, 6.8,
           NA),
  Horas = c(10, 12, 11, NA, 9, 14, 15, 13, 14, NA, 8, 9, 10, 9, 8),
  Frequencia = c(80, 85, 78, 82, NA, 90, 92, 88, 91, 93, 75, 78, NA, 77,
                 76)
)

View(dados)

# 1)

is.na(dados) # valores faltantes no data frame
any(is.na(dados)) # verifica se tem algum valor faltante

colSums(is.na(dados)) # número de valores faltantes por coluna/variável

#trocando os dados faltantes pela média da coluna
dados$Nota[is.na(dados$Nota)] <- mean(dados$Nota, na.rm = TRUE)
dados$Horas[is.na(dados$Horas)] <- mean(dados$Horas, na.rm = TRUE)
dados$Frequencia[is.na(dados$Frequencia)] <- mean(dados$Frequencia, na.rm = TRUE)

dados #conferindo

# 2)

# a)

#médias
mean(dados$Nota)
mean(dados$Horas)
mean(dados$Frequencia)

# b)

#variâncias
var(dados$Nota)
var(dados$Horas)

#covariância
cov(dados$Nota, dados$Horas)

# 3)

# a)

cor(dados$Nota, dados$Horas)

cor(dados$Nota, dados$Frequencia)

cor(dados[, c("Nota", "Horas", "Frequencia")])

# b)
# O coeficiente de correlação entre Nota e Horas foi de 0,7011, ou seja, uma relação positiva e forte.
# Entre Nota e Frequência, o coeficiente foi de 0,7900, indicando também uma relação positiva e forte, ligeiramente maior. 
# Em ambos os casos, as notas tendem a aumentar conforme as horas de estudo ou a frequência aumentam.

# 4)

# a)

boxplot(Nota ~ Metodo, 
        data = dados,
        main = "Notas por Método",
        xlab = "Método",
        ylab = "Nota")
# b)

boxplot.stats(dados$Nota)$out
# o resultado é numeric(0), logo não existem outliers

# 5)

# a)

shapiro.test(dados$Nota)

# b)

shapiro.test(dados$Nota[dados$Metodo == "A"])
shapiro.test(dados$Nota[dados$Metodo == "B"])
shapiro.test(dados$Nota[dados$Metodo == "C"])

# 6)

# a)

modelo <- aov(Nota ~ Metodo, data = dados)

summary(modelo)

# A ANOVA apresentou p = 0,00128, menor que 0,05.
# Portanto, existe diferença entre as médias das notas dos três métodos.

# b)

TukeyHSD(modelo)

# Os métodos A e B diferem significativamente, assim como B e C. Já os métodos A e C não apresentam diferença significativa.
