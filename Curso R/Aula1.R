                 


                  #Curso de verao ppgern - 28/01/19
                  #Aula 1 - CONHECIMENTOS GERAIS


#executar: dar ENTER no prompt OU CRTL + ENTER para executar script!

# Para informacoe/ ajuda: 
  #TAB:
  #??NomeDaFuncao ex. ??read.table

#Operador logico TRUE = T ou FALSE = F

# >>> instalando biblioteca

#   linha de codigo:
#install.packages("NOME DO PACOTE", dependencies = TRUE)
    # dependencies faz ele instalar junto todos os arquivos relacionados ao pacote, ou seja os complementos!

#   Tools:
#install pacakges, escolher o servidor(Repository), selecionar "install depencies"


# >>> Comandos <<<

# setwd("caminho/do/arquivo") : serve para determinar diretorio de determinado arquivo, usar barra nomal

setwd("/home/weslley/Documents/Curso R")


# >>>Criando um objeto e ja abrir uma tabela

amb= read.table(file ="amb.txt", header=TRUE, row.names = 1, sep = "\t", dec = ".",na.strings = "NA") 
#argumentos do read:
  #header=true, define que a primeira linha são titulos
  #row.names =1,  a primeira coluna é nome das linhas
  #sep = "\t", set os diferentes tipos de separação de colunas em uma tabela
  #dec = "." ou ",", indica o separador de decimais usados
  #na.strings = "NA", define que as colinhas com NA não serão utilizadas 

amb #ele vai localizar a tabela e disponibilizar ele em "environment" um duplo click abre a tabela




# >>> LOCAIS PARA CONSEGUIR AJUDA

# MANUAIS DAS BIBLIOTECAS: documentação de cada comando e forma de utiliza-lo

# F1: aba de help, dentro do Rstudio

# STACK OVERFLOW: Blog para ajuda com erros e dificuldades, forum!!

# TIDYVERSE: Pacotes facilitadores e usuais para diferentes analises

# RStudio.com: contém todos os pacotes desenvolvidos e em desenvolvimento por eles, além de em "resources" possuir um pdf sobre como usar todos os pacotes contidos no Rstudio
    #Cheat Sheet

# GITHUB:  base de códigos disponibilizados pelos usuário!!

# RPUBS: blog de R, de uso de R em estatística e outras funções!!

# http://curso-r.github.io/posts/aula05.html
