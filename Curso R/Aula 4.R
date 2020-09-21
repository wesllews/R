


                                  #Curso de verao ppgern - 30/01/19
                                  #Aula 4 - Visualização de dados - ggplot2
                                    # https://ggplot2.tidyverse.org/reference/

install.packages("ggplot2", dependencies = TRUE)

#importando bibliotecas
library(ggplot2)

setwd("/home/weslley/Documents/Curso R")
amb2= read.csv(file = "amb2.csv", header=TRUE, sep = "\t", dec = ",",na.strings = "NA")


# >>> Estrutura do comando GGPLOT

ggplot(data, mapping = aes(x,y)) +  geom_histogram()
  #data é o arquivo de dados que você está usando pra analisar
  #aes,define qual coluna é X e Y
      #Palavra vem de aesthetic, ou seja, estética, então é dentro dessa função que são utilizados os argumentos de detalhes visuais
  #geom_, define que tipo de geometria eu desejo plotar

# >>> Variaveis categoricas e contínuas

  # CONTÍNUAS   -    numéricas ou não categorizantes 
        #Essas variaveis são valores diferentes para a mesma coisa, por exeplo, diferentes valores de temperatura, esses dados serão trabalhados por cores em gradiente, de forma a possibilitar uma visualização de intensidade
  #ex:
        ggplot(amb2, mapping = aes(x = bacia,y = temp, color = temp,size = 5) ) +  geom_point()
        
  
  # CATEGÓRICAS / discretas
        #São variaveis de categorização exemplo, macho e femea, ou coisas do tipo e que nesse caso são identificados por cores diferentes nos gráficos
  #ex:
        ggplot(amb2, mapping = aes(x = temp,y = bacia, color = bacia,size = 5) ) +  geom_point()


  #Aesthetic Local e Global    
        # Global: dentro do aes geral do ggplot
        ggplot(amb2, mapping = aes(x = temp,y = bacia, color = bacia) ) +  geom_point()
        
        # Local: dentro do comando de tipo de gráfico 
        ggplot(amb2, mapping = aes(x = temp,y = bacia) ) +  geom_point(aes(color = bacia))
        
        
  
# >>> EXEMPLO DE GRÁFICOS
        
# HISTOGRAMA - Uma variável contínua
  ggplot(amb2, mapping = aes(x = ph))+ 
  geom_histogram(fill = "#454632") + theme_classic()
  
  
  
  # BARRAS - Uma variável categorica
  ggplot(amb2, mapping = aes(x = trofia))+ 
    geom_bar(color = "Gray", fill = "#454666", linetype= 1, size = 1, width = 0.2) + theme_bw()
    #linetype, são valores de 0-6 que compreendem a características diferentes
    #size, nesse caso define a largura da linha
    #color define a cor do contorno doas graficos
  
  # BARRAS - Uma variável categorica
  ggplot(amb2, mapping = aes(x = trofia))+ 
    geom_bar(color = "Gray", fill = "#454666", linetype= 1, size = 1, width = 0.2) + theme_bw()
      
  
  # DISPERSÃO - Duas numérias, mais de um Y por x
  ggplot(amb2, mapping = aes(x = ic, y= tc))+ 
    geom_point(aes(color = ic, size=5, alpha = 0.4)) +
    theme_classic() + 
    scale_color_continuous(low = "blue", high = "green") #scala de cores para dados continuo
    #scale_color_gradient(low="Blue", high="yellow") +
    
    #alpha é a transparência dos pontos
  
  
  # LINHAS - Duas numérias, proporção 1:1
  ggplot(amb2, mapping = aes(x = ic, y= tc))+ 
    geom_line(aes(color="#66664c")) + theme_classic() 
  
  
  # BOXPLOT- Uma categorica e uma numérica
    # Esse gráfico dá uma analise bem detalhada das amostras, contendo médias, mediana e limites superiores e inferiores
  ggplot(amb2, mapping = aes(x = trofia, y= tc))+ 
    geom_boxplot()
  
  
  # VIOLIN - Duas numérias, proporção 1:1
  ggplot(amb2, mapping = aes(x = bacia, y= ph))+ 
    geom_violin(aes(color= bacia)) +
    theme_classic() 
  
  # JITTER : serve para quando vc tem muitos dados que coincidem e ele tenta fazer um afastamento entre os pontos para que o máximo seja vizualidado e não fiquem todos sobrepostos
  
  
  # LINHAS COM PONTOS - Duas numérias, proporção 1:1
  ggplot(amb2, mapping = aes(x = ic, y= tc))+ 
    geom_line(aes(color="#66664c")) +
    geom_point(aes(color="Black")) +
    theme_classic() 
      # >>> Utilizando dois tipos de gráfico em um
      # A prioridade de visualização vai ser conforme a sequencia que os tipos de graficos(funcoes) foram chamados
    
      
      
  # >>> Varios comandos
  
  
  #definindo cores
  ggplot(amb2, mapping = aes(x = chla, y= ph, color=bacia))+ 
    geom_point()+ theme_classic()
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
    
    
    
    

