write.results <- function(results, file_path){
    write(file = file_path, "Pattern \t Localization")
    
    for(i in 1:length(results$loc)){
        #Escreve no arquivo o "Numero do padrão" -> i
        write(file = file_path, paste(i , "\t", paste(results$loc[[i]], sep ="", collapse=", " )), append = TRUE)
    }
}