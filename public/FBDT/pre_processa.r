#--------------------------------------------------------------------------------#
distancia.pontual<-function(janela,janela2){
     distancia<- 0
     novaJanela <- normaliza(janela)
     novaJanela2<- normaliza(janela2)
     
     for(i in 1:(length(novaJanela))){
          distancia<- distancia + (novaJanela[i] - novaJanela2[i]) * (novaJanela[i] - novaJanela2[i])
     }
     return(sqrt(distancia))
}

#-------------------------------------------------------------------------------#-
pre.processa<-function(serie, tamanhoJanela){
     distancias<- c()
     janela<- serie[1:tamanhoJanela]
     
     for(i in 1:(length(serie)-tamanhoJanela)){ # Para cada janela primaria, calcula distancia entre
     								   # a primeira janela e a janela a ser comparada.
        janela2 <- serie[i:(i+tamanhoJanela-1)]
        distancia <- distancia.pontual(janela, janela2)
        distancias<- c(distancias, distancia)
     }
     return(distancias)
}
#-------------------------------------------------------------------------------#
