## Algoritmo de for?a bruta para procura de padroes em s?ries temporais
## 		serie : s?rie temporal
## 		tam : tamanho do motif
## 		r : limiar e/ou range 

brute.force <- function(serie, tam, r, metric){
  define.norm(metric)
     
	x_length <- length(serie) - tam + 1
	motifs <- data.frame(loc = NA)      
	tmArea <- na.omit(matrix(ncol = 2)) #regioes de Trivial Matches
	tmInc <- 1 #indexar a estrutura de trivial matches
	i <- 1 #deslocamento da janela principal
  
  #Instancia Progress Bar
  #algPB<-winProgressBar(min = 0, max = x_length,title = "Algorithm Progress")
  
	while(i <= x_length){#janela principal
    
          j <- i + tam
          v_loc <- vector() # vetor de localiza??es dos padroes encontrados
          while(j < x_length){#janela secundaria
               d <- distance(serie[i:(i + tam - 1)], serie[j:(j + tam - 1)], r)
               if(d <= r && !belongs.tm.zone(j, tmArea)){ #verifica se n?o pertence a area de um Trivial Match
                    tmArea <- rbind(tmArea, NA)
                    minD <- d
                    tmArea[tmInc, 1] <- j #Se teve MATCH entao guarda a posiciao do primeiro MATCH
                    while((j < x_length) && (d <= r)){#determinar todo o intervalor do Trivial Match
                         if((d <= minD)){#melhor casamento dentro da area trivial match
                              minD <- d
                              best_match <- j #guarda o melhor casamento
                         }
                         j <- j + 1
                         d <- distance(serie[i:(i+tam-1)], serie[j:(j+tam-1)], r)
                    }
                    j <- j - 1 #compensar o incrmento de saida do while anterior
                    tmArea[tmInc, 2] <- j
                    tmInc <- tmInc + 1
                    v_loc <- c(v_loc, best_match) #junta o melhor casamento encontrado com vetor de padroes
               }
               j <- j + 1
          }
          #possibilidade do motif (padroes encontrados + janela principal) pertencer a um grupo j? existente
          motifs <- regroup.motifs(motifs, c(i,v_loc))
          
          i <- i + 1
          #setWinProgressBar(algPB, i,title = paste("Progresso algoritmo:", round(i/x_length*100,0),"%"))   
 }
	#return(find.full.subsequences(motifs,serie,tam))
	return(motifs)
}