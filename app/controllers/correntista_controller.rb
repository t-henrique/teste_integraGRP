class CorrentistaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_correntista, only: [:show, :edit, :update, :destroy]

  # GET /correntista
  # GET /correntista.json
  def index
    @correntista = Correntista.all
  end

  # GET /correntista/1
  # GET /correntista/1.json
  def show
  end

  # GET /correntista/new
  def new
    @correntista = Correntista.new
  end

  # GET /correntista/1/edit
  def edit
  end

  # POST /correntista
  # POST /correntista.json
  def create
    @correntista = Correntista.new(correntista_params)
    @correntista.users_id = current_user.id
    respond_to do |format|
      if @correntista.save
        format.html { redirect_to @correntista, notice: 'Correntista was successfully created.' }
        format.json { render :show, status: :created, location: @correntista }
      else
        format.html { render :new }
        format.json { render json: @correntista.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /correntista/1
  # PATCH/PUT /correntista/1.json
  def update
    respond_to do |format|
      if @correntista.update(correntista_params)
        format.html { redirect_to @correntista, notice: 'Correntista was successfully updated.' }
        format.json { render :show, status: :ok, location: @correntista }
      else
        format.html { render :edit }
        format.json { render json: @correntista.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /correntista/1
  # DELETE /correntista/1.json
  def destroy
    @correntista.destroy
    respond_to do |format|
      format.html { redirect_to correntista_index_url, notice: 'Correntista was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_correntista
      @correntista = Correntista.find_by(:users_id => current_user.id)
      # @correntista = Correntista.where(:users_id => current_user.id)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def correntista_params
      params.require(:correntista).permit(:id, :cpf, :nome, :datanascimento, :endereco, :numero, :bairro, :cidade, :estado)
    end
end
