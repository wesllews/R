


                          #Curso de verao ppgern - 29/01/19
                          #Aula 2 - Metodo TIDYR

setwd("/home/weslley/Documents/Curso R")

install.packages("dplyr", dependencies = TRUE)
install.packages("tidyr", dependencies = TRUE)
install.packages("gapminder", dependencies = TRUE)



#importando bibliotecas
library(tidyr)
library(dplyr)
library(gapminder)



# >>> gather()

amb= read.table(file ="amb.txt", header=TRUE, row.names = 1, sep = "\t", dec = ".",na.strings = "NA")

#quando se coloca o row.names=1, eu posso criar uma tabela que perca a identificação da especie que estou usando, para tanto é melhor colocar sem, segue ambos os testes
amb= read.table(file ="amb.txt", header=TRUE, sep = "\t", dec = ".",na.strings = "NA")


amb_long = gather(amb, key = "teste", value="valores",(1:24),-(1:2))

  #A coluna teste, será formada por todos os nomes de colunas entre 1:24, 
  #a Coluna valores, será formada por cada valor contido nas linhas das colunas do TESTE
  #(1:24) é o intervalo inteiro da tabela
  #-(1:2) é o intervalo das duas primeiras culunas, nome e data da coleta que vão ser "excluidas" do agrupamento!!




# >>> unite()

geo= read.table(file ="geo.txt", header=TRUE, sep = "\t", dec = ".",na.strings = "NA")

geo_unite= unite(geo,col="NovaColuna_Cordenadas", into= 1,3, sep="_")

  #A coluna "NovaColuna_Cordenadas", será formada pelas colunas contidas no intervalo "c"
  #into= c("long","lat") pode ser feito também com into= c("3","2"), ou seja, NÚMEROS E PODEM SER EM ORDEM INVERSAS!!
  #into = 2:3, que é um intervalo, ooou  into = 1,3, que são as colunas especificadas
  #sep = "", define o caracter que eu desejo fazer a concatenação, posso utilizar "\t" também




# >>> separate()

geo_separate= separate(geo_unite,col="NovaColuna_Cordenadas", into= c("Sample","lat"), sep="_", remove=FALSE)
  #remove=TRUE, É o default, e apaga a antiga coluna que foi separada, ou criando novas, e mantendo a antiga unida
  #separar coisas com "." podem gerar erros na disjunção dos dados
  #uma função util é seprar dia/mês/ano de datas por exemplo



# >>> spread()                       Não fiz!!!!

#testar [,1,2] cortador de linhas no spread

geo= read.table(file ="geo.txt", header=TRUE, sep = "\t", dec = ".",na.strings = "NA")

#quando se coloca o row.names=1, eu posso criar uma tabela que perca a identificação da especie que estou usando, para tanto é melhor colocar sem, segue ambos os testes
amb= read.table(file ="amb.txt", header=TRUE, sep = "\t", dec = ".",na.strings = "NA")


amb_long = gather(amb, key = "teste", value="valores",(1:24),-(1:2))

  #A coluna teste, será formada por todos os nomes de colunas entre 1:24, 
  #A Coluna valores, será formada por cada valor contido nas linhas das colunas do TESTE
  # (1:24) é o intervalo inteiro da tabela
  # -(1:2) é o intervalo das duas primeiras culunas, nome e data da coleta que vão ser "excluidas" do agrupamento!!

