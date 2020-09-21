#####CURSO VER?O R
#####Apresenta??o final

#instalando pacotes
install.packages("vegan", dependencies = TRUE) 
install.packages("tidyr", dependencies = TRUE)
install.packages("dplyr", dependencies = TRUE)
install.packages("gapminder", dependencies = TRUE)
install.packages("stats", dependencies = TRUE)
install.packages("fields", dependencies = TRUE)
install.packages("BiodiversityR", dependencies = TRUE)
install.packages("betapart", dependencies = TRUE)

#ativando pacotes
library(vegan) # Estatística
library(tidyr) # Funções úteis para deixar os seus dados no formato que você precisa para a análise
library(dplyr) # manipulação e transformação de base de dados
library(ggplot2) # Visualização de dados
library(stats) # Estatísticas
library(fields) # Matriz de distância

#Local dos arquivos
setwd("/home/weslley/Documents/Curso R")

# Abrindo Tabela de dados
cervical = read.table(file = "cervical.txt", header=TRUE, sep = "\t", dec = ",",na.strings = "NA")

# Retirando colunas de X16:X25, utilizando SELECT da biblioteca DPLYR 
cervical_menor = cervical %>% 
  select(-c(X16:X25))




# Transformando cervical_menor em fomato LONG - TIDYR
cervical_menor_long = cervical_menor %>% 
  gather(key = "medidas", value = "valores", -c(ccc:ontogenia))


# Organizando as medidas de cervical_menor_long em ordem crescente
cervical_menor_long$medidas = factor(cervical_menor_long$medidas, levels = c("X1","X2","X3","X4","X5","X6","X7","X8","X9","X10","X11","X12","X13","X14","X15"))


# Tranformando valores das medidas em LOG10, coluna ADICIONANDO NOVA COLUNA
cervical_menor_long$valores_log = log10((cervical_menor_long$valores))

          # Tranformando valores das medidas em LOG10, coluna ORIGINAL
          cervical_menor_long$valores = log10((cervical_menor_long$valores))



# DENSIDADES
          
# Plotando gráfico de densidade Cervical X Sexo
cervical_menor_long %>% 
  ggplot(aes(x= valores_log))+
    geom_density(aes(fill= sexo),alpha=0.6)+ #Colocando o o alpha fora do elemento aesthetic ele não aparece na legenda
    facet_wrap(medidas~.,  scales="free")+ 
    theme_bw()+
    theme(legend.position = "bottom")+
    labs(title = "Medidas de cervicais por sexo", fill= "Sexo: ", x = "Valores", y = "Densidade")

# Plotando gráfico de densidade Cervical X Ontogenia
cervical_menor_long %>% 
  ggplot(aes(x= valores_log))+
  geom_density(aes(fill= ontogenia),alpha=0.6)+ #Colocando o o alpha fora do elemento aesthetic ele não aparece na legenda
  facet_wrap(medidas~.,  scales="free")+ 
  theme_bw()+
  theme(legend.position = "bottom")+
  labs(title = "Medidas de cervicais por ontogenia", fill= "Ontogenia: ", x = "Valores", y = "Densidade")




# TESTE DE NORMALIDADE

#Shapiro.wilk - stats

#normalidade de X1
shapiro.test(cervical_menor$X1)

#Teste de Mann-Whitney - 2 grupos 
wilcox.test(X1~sexo, cervical_menor, paired=FALSE)


#BOXPLOT dos resultados de Mann-Whitney para sexo
ggplot(cervical_menor, aes(x=sexo, y=X1, fill=sexo))+
  geom_boxplot(aes(color = sexo), alpha = 0.3)+
  annotate("text", x = 0.60, y=26, label="w = 99", size = 3.5)+
  annotate("text", x = 0.68, y=25, label="p = 0,6833", size = 3.5)+
  theme_classic()+
  labs(color = "Sexo", fill = "Sexo", x = "Sexo", y = "Medida 1 (mm)")
  


#Teste de Kruskal-Wallis - 3 grupos 
kruskal.test(X1~ontogenia, cervical_menor)

#BOXPLOT dos resultados de Kruskal-Wallis para ontogenia
#identificado por ONTOGENIA
ggplot(cervical_menor, aes(x=ontogenia, y=X1, color=ontogenia))+
  geom_boxplot(aes(fill = ontogenia), alpha = 0.3)+
  annotate("text", x=2.8, y=27, label="chi-squared = 20,079", size = 3.5)+
  annotate("text", x=2.655, y=26, label="p = 4,363 x 10^-5", size = 3.5)+
  theme_classic()+
  labs(color = "Ontogenia", fill = "Ontogenia", x = "Ontogenia", y = "")

#BOXPLOT dos resultados de Kruskal-Wallis para ontogenia
#identificado por SEXO
ggplot(cervical_menor, aes(x=ontogenia, y=X1, color=sexo))+
  geom_boxplot(aes(fill = sexo), alpha = 0.3)+
  annotate("text", x=2.77, y=27, label="chi-squared = 20,079", size = 3.5)+
  annotate("text", x=2.65, y=26, label="p = 4,363 x 10-5", size = 3.5)+
  theme_classic()+
  labs(color = "Sexo", fill = "Sexo", x = "Ontogenia", y = "")+
  geom_hline(yintercept = 15,linetype="dashed")+
  scale_y_continuous(breaks = seq(0,150, by=10))

#JITTER dos resultados de Kruskal-Wallis para ontogenia
#identificado por ONTOGENIA
ggplot(cervical_menor, aes(x=ontogenia, y=X1, color=ontogenia))+
  geom_jitter()+
  annotate("text", x=2.8, y=27, label="chi-squared = 20,079", size = 3.5)+
  annotate("text", x=2.655, y=26, label="p = 4,363 x 10-5", size = 3.5)+
  theme_classic()+
  labs(color="Ontogenia", y= "", x = "Ontogenia")

