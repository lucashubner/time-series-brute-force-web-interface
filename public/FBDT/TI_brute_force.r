## Algoritmo de for?a bruta para procura de padroes em s?ries temporais
## 		serie : s?rie temporal
## 		tam : tamanho do motif
## 		r : limear e/ou range 

new.brute.force <- function(serie, tam, limear, metric){  
	define.norm(metric) #Define a normalização a ser usada para não escolher toda vez que necessita calcular.
     
     distances <- pre.processa(serie,tam) # Faz pre calculo das distancias
 
	x_length <- length(serie) - tam + 1
	motifs <- data.frame(loc = NA)      
	tmArea <- na.omit(matrix(ncol = 2)) #regioes de Trivial Matches
	tmInc <- 1 #indexar a estrutura de trivial matches
	i <- 1 #deslocamento da janela principal
  
	while(i <= x_length){#janela principal 
          j <- i + tam 
          d1 <- distances[i] # Pega distancia pre calculada da janela primaria
          
          v_loc <- vector() # vetor de localiza??es dos padroes encontrados
          
          while(j < x_length){ # Janela secundaria
               d2 <- distances[j] # Pega a distancia pre calculada da janela secundaria
               
               if(abs(d1-d2) <= limear){ # Se a diferença entre as distancias pre calculadas for menor que o limear
                    # então calcula a distancia real entre as duas janelas
                    d <- distance(serie[i:(i + tam - 1)], serie[j:(j + tam - 1)], limear)
                    
                    if(d <= limear && !belongs.tm.zone(j, tmArea)){ #verifica se n?o pertence a area de um Trivial Match
                         tmArea <- rbind(tmArea, NA)
                         minD <- d
                         tmArea[tmInc, 1] <- j #Se teve MATCH entao guarda a posiciao do primeiro MATCH
                         
                         while((j < x_length) && (d <= limear)){#determinar todo o intervalor do Trivial Match
                              if((d <= minD)){#melhor casamento dentro da area trivial match
                                   minD <- d
                                   best_match <- j #guarda o melhor casamento
                              }
                              
                              j <- j + 1
                              d <- distance(serie[i:(i+tam-1)], serie[j:(j+tam-1)], limear)
                         }
                         j <- j - 1 #compensar o incrmento de saida do while anterior
                         tmArea[tmInc, 2] <- j
                         tmInc <- tmInc + 1
                         v_loc <- c(v_loc, best_match) #junta o melhor casamento encontrado com vetor de padroes
                    }
               }
               
               j <- j + 1
          }
          
          #possibilidade do motif (padroes encontrados + janela principal) pertencer a um grupo já existente
          motifs <- regroup.motifs(motifs, c(i,v_loc))
          
          i <- i + 1

 }
	return(motifs)
}