class ContaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conta, only: [:show, :edit, :update, :destroy ]
  before_action :set_extrato, only: [:extrato]
  before_action :set_contas, only: [:index]

  # GET /conta
  # GET /conta.json
  def index
  end

  def show
    # GET /conta/1
    # GET /conta/1.json
  end

  # GET /conta/extrato/1
  # GET /conta/extrato/1.json
  def extrato

  end


  # GET /conta/new
  def new
    @correntista = Correntista.find(params[:correntista_id])
    @conta = @correntista.contas.new
  end

  # GET /conta/1/edit
  def edit
  end

  # POST /conta
  # POST /conta.json
  def create
    @conta = Conta.new(conta_params)

    # @conta.correntista = Correntista.find(params[:id])
    respond_to do |format|
      if @conta.save
        format.html { redirect_to correntista_conta_index_path, notice: 'Conta was successfully created.' }
        format.json { render :show, status: :created, location: @conta }
      else
        format.html { render :new }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conta/1
  # PATCH/PUT /conta/1.json
  def update
    respond_to do |format|
      if @conta.update(conta_params)
        format.html { redirect_to @conta, notice: 'Conta was successfully updated.' }
        format.json { render :show, status: :ok, location: @conta }
      else
        format.html { render :edit }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conta/1
  # DELETE /conta/1.json
  def destroy
    @correntista = Correntista.find([current_user.correntista_id])
    @conta = Conta.find(params[:id])
    if @conta.before_destroy
      @conta.save
        respond_to do |format|
          format.html { redirect_to correntista_conta_index_path(current_user), notice: 'Conta desativada corretamente.'  }
          format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { redirect_to correntista_path(@correntista, @conta.errors) }
        format.json { render json: @conta.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conta
    if User.find(current_user.id).correntista.contas.where(:id => params[:id]).present?
      @conta = Conta.find(params[:id])
    else
      flash[:alert] = "A conta digitada na url não existe ou não te pertence, por favor não digite na url."
      redirect_to correntista_url
    end
  end

  def set_contas
    @conta = User.find(current_user.id).correntista.contas
  end

  def set_extrato
    @conta = Conta.find(params[:conta_id])
    # conta = @conta./
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conta_params
    params.require(:conta).permit(:correntista_id, :flag_ativo, :created_at, :updated_at, :saldo, :saldoProvisorio)
  end
end
