


                      #Curso de verao ppgern - 29/01/19
                      #Aula 3 - Introdução ao Dplyr, funções de seleção e filtro (famoso SQL)

setwd("/home/weslley/Documents/Curso R")


#importando bibliotecas
library(tidyr)
library(dplyr)
library(gapminder) #biblioteca de base de dados, ou seja, não preciso ter uma tabela pronta pra poder usar os comandos!!

dados = gapminder
amb2= read.csv(file = "amb2.csv", header=TRUE, sep = "\t", dec = ",",na.strings = "NA")



# >>> Operadores lógicos
  # ==, >, <, !=, |(ou) e &(e)
  # crtl + shift + M >>>> pipe >>>>> %>% 
  #between() e near()
  #desc() e asc()




# >>> Mutate()
mutados = mutate(amb2, log_ph = -log(ph),somaTemp_ph = temp+ph )
#efetua calculos matematicos, criando novas colunas, mantendo as colunas originais intactas



# >>> Arrange() e Group_by
organizados = arrange(amb2, bacia) %>% group_by(trofia,bacia)
  #organiza a tabela, conforme as variaveis selecionadas
  #forma crescente é o padrão, desc() o coloca como decrescente



# >>> Filter()
filtrados = filter(amb2, trofia =="eutrofico" & bacia=="grande")
  #retorna as linhas em que os dados correpondem as condições exigidas
  #pesquisas as coisas por conteúdo de cédula
  


# >>> Select()
selecionados = select(amb2, sites, bacia,temp)
  #retorna as colunas em que os dados correpondem as condições exigidas
  #trabalha apenas com o nome das colunas



# >>> Summarise()

  #media
  sumarizado = summarise(amb2, media = median(temp), qtde_observada = n())
  
  #mediana
  sumarizado = summarise(amb2, temp_mediana = mean(temp), ph_mediana = mean(ph))
  
  #minimo e máximo 
  sumarizado = summarise(amb2, temp_mim = min(temp), temp_max = max(temp))
  
  #Countadores
  sumarizado = summarise(amb2, ph_distintos = n_distinct(ph), ph = n())
     #O contador n(), dispensa argumentos, ele conta a quantidade de linhas totais da tabela ou dados analisados


  
# >>> Calculando média, mediana e n amostral, da base gapminder, por continente  - Utilizando Pipe
  sumarizado = dados %>% group_by(continent,country) %>% 
    summarise(media_ExpecVida = mean(lifeExp), DesvPadrao = sd(lifeExp), n())
  