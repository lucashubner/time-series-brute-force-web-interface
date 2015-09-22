class TsTblsController < ApplicationController
  before_action :set_ts_tbl, only: [:show, :update, :destroy, :get_serie_array]
  before_action :authenticate_user!

  # GET /ts_tbls
  # GET /ts_tbls.json
  def index
    @ts_tbls = TsTbl.where("user_id = #{current_user.id}")
  end
####################################################################################
  # GET /ts_tbls/1
  # GET /ts_tbls/1.json
  def show
    @ts_results = TsResult.where("ts_tbl_id = #{params[:id]}")
    @Serie = get_serie_array
    @gon = gon
  end
####################################################################################
  # GET /ts_tbls/new
  def new
    @ts_tbl = TsTbl.new
  end

####################################################################################
  # POST /ts_tbls
  # POST /ts_tbls.json
  def create
      
    @ts_tbl = TsTbl.new(ts_tbl_params)
    @ts_tbl.user_id = current_user.id

    #render :text => ts_tbl_params
    
    respond_to do |format|
      if @ts_tbl.save
        format.html { redirect_to @ts_tbl, notice: 'Ts tbl was successfully created.' }

      else
        format.html { render :new }

      end
    end
  end

####################################################################################
  # DELETE /ts_tbls/1
  # DELETE /ts_tbls/1.json
  def destroy
    @ts_tbl.destroy
    respond_to do |format|
      format.html { redirect_to ts_tbls_url, notice: 'Ts tbl was successfully destroyed.' }

    end
  end

    def get_serie_array
        require 'scanf'
        
        serie = []
        File.readlines(@ts_tbl.ts.path).map do |line|
            serie << line.scanf('"%d" %f')
        end
        
        return serie

    end

####################################################################################
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ts_tbl
      @ts_tbl = TsTbl.find(params[:id])
    end
    
####################################################################################
    # Never trust parameters from the scary internet, only allow the white list through.
    def ts_tbl_params
      params.require(:ts_tbl).permit(:ts)
    end
end
