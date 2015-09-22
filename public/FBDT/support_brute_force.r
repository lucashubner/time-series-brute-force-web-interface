#Faz calculo da distância euclidiana
distance<- function (vetor1,vetor2, limear){
     vet1<- normaliza(vetor1)
     vet2<- normaliza(vetor2)
     
     euclidiana <- 0
     
     for(i in 1:length(vet1)){
          euclidiana<- euclidiana + abs(vet1[i] - vet2[i])
          
          if(euclidiana > limear){
               return(euclidiana)
          }
     }
     return(euclidiana)
}

## Verifica se uma ocorrencia de padrao pertence a uma area de trivial match
##  	j : padrao encontrado
##  	tmArea : matriz com as localiza??es de trivial match na s?rie
belongs.tm.zone <- function(j, tmArea){
	i <- 1
	while(i <= length(na.omit(tmArea)[,1])){
		if( (j >= tmArea[i,1]) && ((j <= tmArea[i,2])))
			return (TRUE)
		i <- i + 1
	}
	return (FALSE)
}

## Guarda o padrao encontrado na estrutura de motifs  
##  	motifs : estrutura de padroes encontrados
##  	v_loc : vetor com as localiza??es do padrao encontrado
regroup.motifs <- function(motifs, v_loc){
	if(length(v_loc) > 1){ # se algum padrao foi encontrado, al?m da referencia	
		i <- 1
		while(i < length(motifs$loc)){ # verifica se o padrao encontrado ja pertence a algum casamento anterior
			tam1 <- length(c(motifs$loc[i][[1]], v_loc))
			tam2 <- length(unique(c(motifs$loc[i][[1]],v_loc)))
			if((tam1 - tam2) != 0){
				motifs$loc[i] <- list(sort(unique(c(v_loc, motifs$loc[i][[1]]))))
				return (motifs)
			}
			i <- i + 1
		}
		motifs$loc[length(motifs$loc)] <- list(v_loc)
		motifs <- rbind(motifs, NA)
	}
	return(motifs)
}

## Localiza e guarda todos os valores das subsequencias identificadas como motifs  
##  	motifs : estrutura de padroes encontrados
##  	serie : serie temporal
##  	tam : tamanho do motif
find.full.subsequences <- function(motifs, serie, tam){
  if(!is.na(motifs[[1]][1])){
    	for(i in 1:(length(motifs$loc)-1)){
    		v = data.frame(subseq = NA)
    		for (j in 1:(length(motifs$loc[i][[1]]))){
    			v$subseq[j] <- list(serie[
    							(motifs$loc[i][[1]][j]): 
    							(motifs$loc[i][[1]][j] + tam - 1)
    							])
    			v <- rbind(v,NA)
    		}		
    		motifs$subseqs[i] <- v
    	}
	}
	return(motifs)
}