class TsResultsController < ApplicationController
  before_action :set_ts_result, only: [:show, :update, :destroy, :get_serie_array, :get_result_path, :get_result_array]
  before_action :authenticate_user!

####################################################################################
  # GET /ts_results/1
  # GET /ts_results/1.json
  def show
    @Serie = get_serie_array
    @Results = get_result_array
    
    #Remove o primeiro e o ultimo resultado que são ambos 0.
    @Results.delete_at(0)
    @Results.delete_at(@Results.size)
    
    @gon = gon
  end

####################################################################################
  # GET /ts_results/new
  def new
    @ts_result = TsResult.new
    @ts_tbl = TsTbl.find(params[:format])

  end
 
 ####################################################################################
  # POST /ts_results
  # POST /ts_results.json
  def create
    @ts_result = TsResult.new(ts_result_params)
    
  respond_to do |format|
     if @ts_result.save
        #chama uma thread para o força bruta.

        call_brute_force

        
        format.html {redirect_to @ts_result , notice: 'Sucesso!' }
     else
        
     end
    end
  end
#####################################################################

####################################################################################
  # DELETE /ts_results/1
  # DELETE /ts_results/1.json
  def destroy
    #salva qual é a série dos resultados.
    last_serie = @ts_result.ts_tbl
    
    @ts_result.destroy
    respond_to do |format|
      format.html {redirect_to last_serie, notice: 'Ts result was successfully destroyed.' }
    end
  end
####################################################################################
    def get_serie_array
        #Importa biblioteca para usar o scanf.
        require 'scanf'
        
        serie = []
        File.readlines(@ts_tbl.ts.path).map do |line|
            serie << line.scanf('"%d" %f')
        end
        
        return serie
    
    end
####################################################################################
    def get_result_array
        if File.exist?(get_result_path)
            File.readlines(get_result_path).map do |line|
                line.split.map(&:to_i)
            end
        else
            return []
        end
    end
    
####################################################################################
    def get_patterns_plot(serie, patterns, motif_size)
        data_plot = Array.new
        
        for i in 1..patterns.size
            data_plot.push(name: "Time Serie", data: serie[patterns[i]..(patterns[i] + motif_size)].reject {|x| x.empty?}) 
        end
        return data_plot
    end
    
####################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ts_result
      @ts_result = TsResult.find(params[:id])
      @ts_tbl = TsTbl.find(@ts_result.ts_tbl.id)
    end

####################################################################################
    # Never trust parameters from the scary internet, only allow the white list through.
    def ts_result_params
      params.require(:ts_result).permit(:ts_tbl_id, :motif_size, :limear, :normalize, :algorithm)
    end
####################################################################################
    def get_result_path
        serie_file_path = @ts_result.ts_tbl.ts.path
        tam_motif = @ts_result.motif_size
        limear = @ts_result.limear
        norm = @ts_result.normalize
        return("#{serie_file_path}.#{limear}.#{tam_motif}.#{norm}.results")
    end
####################################################################################
    def call_brute_force
        
        #Atributos
            #Série
            #Tamanho de Motif
            #Limear
            #Normalizacao
                #zero_axis
                #origi
                #offset
    
            #para Testar
                serie_file_path = @ts_result.ts_tbl.ts.path
                tam_motif = @ts_result.motif_size
                limear = @ts_result.limear
                norm = @ts_result.normalize
                pasta_base = Rails.root.to_s
            
        #Carrega a série para o R
        R.eval "serie <- read.table('#{serie_file_path}')"
        #Limpa ambiente do r

        #Carrega Funções no R
        R.eval "path <- '#{pasta_base}'"
        
        R.eval "path <- paste(path,'/public/FBDT/sources.r', sep='')"
        R.eval "source(path)"
        R.eval "add.sources('#{pasta_base}')"
        
        if @ts_result.algorithm == "FBDT" 
            #chama o FBDT
            R.eval "resultados <- new.brute.force(as.numeric(serie[,1]), #{tam_motif}, #{limear}, '#{norm}')"
        else
             #chama o FB
            R.eval "resultados <- brute.force(as.numeric(serie[,1]), #{tam_motif}, #{limear}, '#{norm}')"
        end
        
        #Faz o caminho para o arquivo
        R.eval "file_path <-'#{serie_file_path}.#{limear}.#{tam_motif}.#{norm}.results'"
           #Escreve os resultados em um arquivo
        R.eval "write.results(resultados, file_path)"
        
        
    end
    
    
    helper_method :get_patterns_plot
end
