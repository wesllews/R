#Instalando e abrindo o pacote para Phylogenia no R
#install.packages("ape")
library(ape)

lista <- read.table(file="/home/weslley/Documents/Fagos/NCs.txt", header=FALSE)

x = lista$V1 #Pegando somente a coluna 1 e passandop ela pra lista

for(i in seq(from=0, to=1800, by=200)){
  
}
nc <-read.GenBank(x[1601:1800],as.character=TRUE)
getwd()
write.dna(nc, "nc9.fas", format = "fasta")
