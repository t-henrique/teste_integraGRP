class CorrentistaController < ApplicationController
  before_action :authenticate_user!
  before_action :set_extrato, only: [:show]


  def show

  end



  private
  def set_correntista
    @saque = Conta.find(params[:id])
    @deposito = Conta.find(params[:id])
  end

end
