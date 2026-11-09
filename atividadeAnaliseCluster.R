clientes <- data.frame(
  Cliente = paste0("C",1:12),
  Alimentacao = c(1200,1300,1250,4000,4200,4100,2200,2300,2400,800,850,780),
  Lazer = c(300,350,320,1500,1600,1580,700,750,720,200,180,210),
  Transporte = c(450,470,430,900,950,920,600,620,610,300,290,310))

dados <- clientes
View(dados)

dados$Cliente <- NULL

media <- colMeans(dados)
print(media)

dados.p <- scale(dados)
media.p <- colMeans(dados.p)
print(media.p)

d.eucl <- dist(dados.p, method = "euclidean")
print(d.eucl)

round(as.matrix(d.eucl)[1:4, 1:4], 2)

#3.1 Metodo hierarquico de Ward  ----
metod.ward <- hclust(d = d.eucl, method = "ward.D2")
# Calculando a matriz cofenetica
cor(d.eucl, cophenetic(metod.ward))

#3.2 Metodo da ligacao media
metod.ligMed <- hclust(d.eucl, method = "average")
cor(d.eucl, cophenetic(metod.ligMed))

#3.3 Metodo da ligacao media
metod.complete <- hclust(d.eucl, method = "complete")
cor(d.eucl, cophenetic(metod.complete))

# "average" foi mais próximo de 1

library("factoextra")
fviz_dend(metod.ligMed)

library("NbClust")

nb <- NbClust(dados.p, distance = "euclidean", min.nc = 2,
              max.nc = 10, method = "average", index = "all")

grupo <- cutree(metod.ligMed,k=4)
table(grupo)

fviz_dend(metod.ligMed, k = 4, # Dividido em 2 grupos
          cex = 0.5, 
          k_colors = c("blue4", "green", "pink", "orange"),
          color_labels_by_k = TRUE, # Colocando cada grupo de uma cor
          rect = TRUE # Adicionando um retangulo nos grupos
)

rownames(dados.p)[grupo == 1]
rownames(dados.p)[grupo == 2]
rownames(dados.p)[grupo == 3]
rownames(dados.p)[grupo == 4]

dados$Grupo <- grupo
dados 
aggregate(dados, 
          by = list(dados$Grupo), 
          mean)
