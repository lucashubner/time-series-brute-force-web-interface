add.sources <- function (rails.path){

    print("------------")
    print("------------")
    print("------------")
    print("------------")
    print("------------")
    
    source.path = paste(rails.path,"/public/FBDT/", sep="")
    metricas_source = paste(source.path,"metricas.r", sep ="");
    pre_processa_source = paste(source.path,"pre_processa.r", sep ="")
    support_source = paste(source.path,"support_brute_force.r", sep="")
    ti_source = paste(source.path,"TI_brute_force.r", sep ="");
    write_results_source = paste(source.path,"write_results.r", sep ="")
    brute_force_source = paste(source.path,"brute_force.r", sep ="")
    print(source.path)

    print("------------")
    print("------------")
    print("------------")
    print("------------")
    print("------------")
    
    source(metricas_source)
    source(pre_processa_source)
    source(support_source)
    source(ti_source)
    source(write_results_source)
    source(brute_force_source)

}
