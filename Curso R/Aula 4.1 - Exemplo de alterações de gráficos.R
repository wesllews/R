                                  #Curso de verao ppgern - 30/01/19
                                  #Aula 4.1 - EXEMPLOS DE ALTERAÇÃO DE GRÁFICOS!!

library(ggplot2)
  library(tidyr)
  library(dplyr)
setwd("/home/weslley/Documents/Curso R")
amb2= read.csv(file = "amb2.csv", header=TRUE, sep = "\t", dec = ",",na.strings = "NA")

# CONTÍNUAS - Point
ggplot(amb2, mapping = aes(x = bacia,y = temp) ) +  
  
  geom_point(aes(color=bacia, size=temp, shape=bacia))+

  # Mudar nome das categorias de eixo
  scale_x_discrete(labels= c("Grande", "Paranapanema", "Serra do mar", "Tiete"))+
  
  # Mudar símbolos / pontos / shape
    #os valores de shape vão de 1-25, formando grupos de mesmo design de 5 em 5
  scale_shape_manual(values=c(1,6,10,15))+
  
  # Mudar variação de tamanho / size
  scale_size_continuous(range = c(1,10))+

  # Mudar cor / color
  scale_color_grey()+

  # Mudar Tema / Theme e Fonte 
  theme_bw(base_family = "ubuntu")



# GRAFICO ENORME DE DENSIDADE
amb2 %>% 
  gather(key = "var", value = "valor", -sites,-bacia,-trofia) %>% 
  ggplot( aes(x=valor))+
  #geom_density(aes(fill= var, alpha=0.3))+  #analise por itens/variaveis diferentes, sem considerar bacias/trofia ou especie
  geom_density(aes(fill= trofia, alpha=0.8))+ #consigo ver a diferença entre os estados tróficos para todas as variaveis da minha base de dados
  facet_wrap(var~.,  scales="free")+ # o wrap faz analise de apenas uma variavel, no caso foi por isso que transformei uma tabela horizontal em vertical, pra ele distinguir os dados por meio das "var" mas com cada um tendo seu valor corretamente mantido, ainda sim 1:1
  theme_classic()+
  theme(legend.position = "right") #none, right, left, bottom
  
    


# >>> Varios comandos


#definindo cores
ggplot(amb2, mapping = aes(x = chla, y= ph, color=bacia))+ 
  geom_point()+ theme_classic()+
scale_colour_manual(name = "Bacia Hidrografica",
                    labels= c("Grande", "Paranapanema", "Serra do mar", "Tiete"),
                    values = c("orange", "green","Cyan","red"))

# Mudando escala de preenchimento
ggplot(amb2, mapping = aes(x = bacia, y= alt, fill=bacia))+ 
  geom_boxplot()+
  #scale_fill_grey()
  scale_fill_manual(values = c("orange", "green","Cyan","red"))+
  theme_classic()+
  theme(legend.position = "bottom", #right, left, top # Muda as características das legendas
        axis.title = element_text(angle = 45, face = "bold", size= 15, color = "gray"), #muda as características do eixo, no caso os elementos de TEXTO do TÍTULO
        axis.text = element_text(size=12))


# MUDANDO TUDOOOO TUDO MESMO NESSA JOÇA

ggplot(amb2, mapping = aes(x = chla, y= ph, shape = bacia, color= trofia, size = doc))+
  #é necessário identificar os argumentos que eu quero usar/alterar ^^^
  geom_point()+
  scale_colour_manual(name = "Trofia",
                      values = c("orange", "green","Cyan"))+
  scale_shape_manual(values = c("square", "circle","triangle","cross"))+
  scale_x_log10()+ #altera a escala do grafico sem a necessidade deu alterar o valor dos dados na tabela
  scale_y_reverse()+ #muda a proporção dos dados entre x e y
  
  #scale_y_continuous(limits = c(2:15))+ >>>>>>>altera a escala dos eixos
  
  facet_grid(bacia~trofia, scales="free_x") 
# você pode "libertar" apenas um eixo "free_y" ou "free_x", e todos "free"
# "~" é a divisão de variaveis categoricas, e "~."faz por uma unica variavel só, 

