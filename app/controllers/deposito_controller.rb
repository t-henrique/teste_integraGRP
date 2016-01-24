class DepositoController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deposito, only: [:show, :edit, :update, :destroy]

  # GET /deposito
  # GET /deposito.json
  def index
    @deposito = Deposito.all
  end

  # GET /deposito/1
  # GET /deposito/1.json
  def show
  end

  # GET /deposito/new
  def new
    @deposito = Deposito.new(:conta_destino_id => params[:conta_id])
  end

  # GET /deposito/transfer
  def transfer
    @deposito = Deposito.new(:conta_origem_id => params[:conta_id])
  end

  # GET /deposito/1/edit
  def edit
  end


  # POST /deposito/transfer
  # POST /deposito/transfer.json
  def create
    @deposito = Deposito.new(deposito_params)
    respond_to do |format|
      if params[:transfer]
        if @deposito.transferir
          puts 'tete'
          format.html { redirect_to correntista_conta_index_path(current_user), notice: 'Deposito was successfully created.' }
          format.json { render :show, status: :created, location: @deposito }
        else
          format.html { render :transfer }
          format.json { render json: @deposito.errors, status: :unprocessable_entity }
        end
      else
        if @deposito.save
          format.html { redirect_to @deposito, notice: 'Deposito was successfully created.' }
          format.json { render :show, status: :created, location: @deposito }
        else
          format.html { render :new }
          format.json { render json: @deposito.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /deposito/1
  # PATCH/PUT /deposito/1.json
  def update
    respond_to do |format|
      if @deposito.update(deposito_params)
        format.html { redirect_to @deposito, notice: 'Deposito was successfully updated.' }
        format.json { render :show, status: :ok, location: @deposito }
      else
        format.html { render :edit }
        format.json { render json: @deposito.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deposito/1
  # DELETE /deposito/1.json
  def destroy
    @deposito.destroy
    respond_to do |format|
      format.html { redirect_to deposito_index_url, notice: 'Deposito was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_deposito
    @deposito = Deposito.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def deposito_params
    params.require(:deposito).permit(:id, :valor, :conta_destino_id, :conta_origem_id, :valorProvisorio)
  end

end
