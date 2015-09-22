#-------------------------NORMARLIZAÇÃO--------------------------

#Para evitar uma comparação a mais para saber qual o tipo de normalização utilizar 
#toda a vez em que for feita a verificação de igualdade de Janela->Padroes,
#define-se a função normaliza a partir da função define_normalizacao
#onde tipo_normalizacao é definido na chamada de função Verifica.Padroes

define.norm<-function(tipo_normalizacao){
     if(tipo_normalizacao == "offset"){
          normaliza <<- function(serie){
               mean_s <- mean(serie)
               for(i in 1:length(serie)){
                    serie[i] <- (serie[i] - mean_s)
               }
               return(serie)
          }
     }
     #Normaliza a ST no intervalor [0:1]
     #serie: serie temporal a ser normalizada
     else if(tipo_normalizacao == "zero_axis"){
          normaliza <<- function(serie){
               
               serie <- na.omit(serie)
               if(min(serie) <= 0)
                    f <- abs(min(serie))
               else
                    f <- min(serie)*-1
               if(max(max(serie+f))!= 0)
                    st <- (serie+f)/max(serie+f)
               else
                    st <- rep(0, length(serie))
               return(st)
          }
     }
     
     #Normaliza a ST em funcao de seu valor minimo (traz para o eixo zero de y)
     #serie: serie temporal a ser normalizada
     else if(tipo_normalizacao == "origin"){
          normaliza <<- function(serie){
               Min <- min(serie)
               se <- serie - Min
               return(se)
          }
     }
     else{
          normaliza<<- function(serie){
               return(serie)
          }
     }
}