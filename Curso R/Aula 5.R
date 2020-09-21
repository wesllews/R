

                                #Curso de verao ppgern - 31/01/19
                                #Aula 5 - Pacotes estatíticos

install.packages("vegan", dependencies = TRUE)
install.packages("fields", dependencies = TRUE) #complemento do vegan, funções extras
install.packages("stats", dependencies = TRUE)
install.packages("BiodiversityR", dependencies = TRUE)
install.packages("betapart", dependencies = TRUE)



#importando bibliotecas
library(vegan)
library(fields)
library(stats)
library(BiodiversityR)
library(betapart)
library(dplyr) #select, gather, separate, etc


setwd("/home/weslley/Documents/Curso R")
amb= read.csv(file = "amb2.csv", header=TRUE, sep = "\t", row.names = 1, dec = ",",na.strings = "NA")



# >>> Vegan

# Fazendo analise de tabela de distância - EXEMPLO DA DOCUMENTAÇÃO

data(varespec)
vare.dist <- vegdist(varespec)
vare.dist <- vegdist(decostand(varespec,"norm"),"euclidean") #cria uma base de dados meio que inacessível, que necessita de transformação para ser visualizado como tabela
matriz = as.matrix(vare.dist) # "as" faz a converção pro tipo que eu desejo 



#DESCRIÇÃO SONBRE VETORES, MATRIZES ETC
X = 1 #VARIAVEL
Y = c("a","b","c") # Vetor com 3 indices
#Z = [L , C]  Matriz LinhaXColuna



# Oque é uma matriz de distância?? Uma matriz que compara a "diferença" de valores de uma célula pra outra de uma mesma coluna!

#Fazendo uma matriz de distância entre os valores "célula a célula" de cada coluna, para tanto  eu preciso remover as variaveis categoricas, pois elas não apresenção distância




 #retirando as categoricas - exemplos
amb2 = select(amb, -bacia,-trofia) #utilizando os comandos de dplyr
amb3 = amb[,-1:2] #retirando as catergoricas por meio de seleção de matriz, ou seja, deixando vazio as linhas(primeiro argumento do cochete) eu seleciono todoas,e -"1:2" eu removo bacia e trofia ou quais eu quisesse
#poderia remover colunas sem ser por intervalo utilizando "amb[, - c(1,5,7,9)] " criando um vetor no local





#FAZENDO MATRIZ DE DISTÂNCIA PARA UMA COLUNA, exemplo 3/alt

dist.matrix = vegdist(amb[,3], "euclidean") 
    #methodo de euclidean, mas tem outros
    #analise feita só pra coluna de Alturas
dist.matrix = vegdist(amb$alt, "euclidean") # O "$" me ajuda a olhar por nome todas as variaveis contidas na tabela
dist.matrix = as.matrix(dist.matrix) #transformandoo a "matriz" não visual, arquivo "dist", nela mesmo porém visual
  #quando uso os comandos o "dist" ele cria um objeto USUAL ṔRO R, MAS NÃO VIZUALIZAVEL





# Fazendo distâncias geograficas com a biblioteca FIELDS

geo= read.table(file = "geo.txt", header=TRUE, sep = "\t", row.names = 1, dec = ",",na.strings = "NA")
dist_geo = rdist.earth(geo,geo, miles = FALSE) #objetocomum, "dist" não é uma fuin"ção
rownames(dist_geo) = rownames(geo) #atribui a identificação de "sites" da taberla "geo", pra tabela de "dist_geo" 
colnames(dist_geo) = rownames(geo)# nomeando as colunas com nome das linhas pq ele tá comparando l:l

    # OBS:
      # GEO, GEO - Pq eu to comparando as coisas na mesma tabela e não em diferentes como "geo1,geo2"
      # miles, é o padrão da biblioteca, mas o padrão internacional é Metros, portanto quando coloco 'miles = false' ele usa metros como padrão
      # Diferente do vegan, o fields, cria um arquivo vizualizavel, porém não usual, vai precisar converter


  #preciso remover os valores espelhados dos indices [l,l], pra baixo formando um  "triangulo", ou seja, [1,1],[2,2], que tem distância de valores ZERO

dist_geo[upper.tri(dist_geo, diag = TRUE)]<-""
      # O UPPER.TRI, seleciona o triangulo superior da matriz de distância, diferenciando ele pela diagonal repleta de zeros, mantendo o triangulo de baixo
      # O parametro DIAG, define se a diagonal será selecionada junto ou não
      # Após valores selecionados, o comando "<-" atribui a região selecionada o por vazio ou qualquer caracter selecionado por mim
        #segue exemplo:
          dist_geo[1,]<-"taokei" # selecionando todas as colunas da linha 1
          
dist_geo = as.dist(dist_geo) #convertendo a tabela dist_geo, de versão visual, pra arquivo "dist" que é usual
        
  




# Comaprando significancia com o MANTEL --- VEGAN

# Comparando Fatores ambientais com os fatores biologicos
otu= read.table(file = "otu_table.txt", header=TRUE, sep = "\t", row.names = 1, dec = ",",na.strings = "NA")
otu = t(otu) #transposição de matriz, pq minha tabela amb, usa na linhas os "sites" e a otu tá usando na coluna
abundancia_dist<-vegdist(otu,method = "bray")


# Comparando relação entre a abundância das espécies(biologicos) e a variavel ambiental, ou seja, abundanciaXalturas
#ele apresenta a significância entre elas
#faz analise se a comparação se deu por acaso ou não, valor de significância deveria ser >0,05, ou seja %5
mantel(abundancia_dist,dist.matrix,method = "spear") 
#nesse explo altura e abundância não tem relação entre elas, relação se dá ao acaso!


mantel(abundancia_dist,dist_geo,method = "spear") 
#nesse explo distância geografica e abundância tem relação!!

  # OBS: O "ESTATISTIC R" é auela relação que quanto mais próximo de 1, ela de fato corresponde a um valor de "acerto" ou de maior ocorrência
    #como exemplo, se eu analisar distância geografica e variação de ph, o r de ph é maior, portanto, a influência do ph é maior do que a influência da distância geografica!!!

































