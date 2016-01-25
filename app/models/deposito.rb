require 'forwardable'
class Deposito < ActiveRecord::Base
  self.table_name = "deposito"
  has_many :conta

  scope :deposito, ->{where(conta_origem_id: nil).order(:created_at)}
  scope :transferenciaRecebidas, ->{where.not(conta_origem_id: nil).order(:created_at)}
  before_save :corrigeValor
  validates_format_of :valorProvisorio, presence: true, :with => /(?:\d*.+,)?\d+/i, :message => "Não pode ficar em branco nem ser letras. Aceita (,) ou (.)"
  after_create :depositar #entra depois de salvar

  extend Forwardable
  attr_accessor :valorProvisorio

  def corrigeValor
    self.valor = valorProvisorio.gsub(/,/){'.'}.to_d
  end
  # def corrigeValor
  #   self.valor = valorProvisorio.gsub(/,/){'.'}.to_d
  # end

  def carregaContasAivas(contaid)
    Conta.retornaContasAtivasSemContaOrigem(contaid)
  end
  #
  # def carregaContasAivas(contaid)
  #   Conta.retornaContasAtivasSemContaOrigem(contaid)
  # end
 
  def transferir
    corrigeValor
    self.taxa = acrescentaTaxa
    contaOrigem = Conta.find(self.conta_origem_id)
    contaDestino = Conta.find(self.conta_destino_id)
    valorTaxado = self.valor + self.taxa
    if consultaSaldoSuficienteContaOrigem(contaOrigem, valorTaxado)
      descontaContaOrigem(contaOrigem, valorTaxado)
      # creditaContaDestimo(contaDestino, self.valor)
    else
      errors.add(:valor, "Saldo da conta Origem é inferior ao valor a ser transferido + o valor de R$ das taxas. ")
      return false
    end
    self.save
  end

  private
  def depositar
    conta = Conta.find(self.conta_destino_id)
    conta.saldo = conta.saldo + self.valor
    conta.save
  end
  def validaValor
    if self.valor.nil?
      errors.add(:valor, "valida valor")
    end
  end


  def acrescentaTaxa
    taxa = Taxa.new
    resultado = taxa.defineTaxa(self.valor, Time.now)
    return resultado
  end

  def consultaSaldoSuficienteContaOrigem(conta, taxa)
    if (conta.saldo > taxa)
      return true
    else
      return false
    end

  end

  def descontaContaOrigem(contaOrigem, valorTaxado )
    contaOrigem.saldo -= valorTaxado
    contaOrigem.save
  end

  def creditaContaDestimo(contaDestino, valor)
    contaDestino.saldo = contaDestino.saldo + valor
    contaDestino.save
  end

  #
  # def transferir
  #   if (validaValorPorvisorio)
  #     corrigeValor
  #     self.taxa = acrescentaTaxa
  #     contaOrigem = Conta.find(self.conta_origem_id)
  #     contaDestino = Conta.find(self.conta_destino_id)
  #     valorTaxado = self.valor + self.taxa
  #     if consultaSaldoSuficienteContaOrigem(contaOrigem, valorTaxado)
  #       descontaContaOrigem(contaOrigem, valorTaxado)
  #       creditaContaDestimo(contaDestino, self.valor)
  #     else
  #       errors.add(:valor, "Saldo da conta Origem é inferior ao valor a ser transferido + o valor de R$ das taxas. ")
  #       return false
  #     end
  #   else
  #     errors.add(:valor, "O valor a ser transferido não pode ser nulo ou 0 ")
  #     return false
  #   end
  #   self.save
  #
  # end
  #
  #
  # def validaValorPorvisorio
  #   if self.valorProvisorio.blank?
  #     return false
  #   end
  #   if valorProvisorio.to_i == 0
  #     return false
  #   else
  #     return true
  #   end
  # end
  #
  # private
  # def depositar
  #
  #   conta = Conta.find(self.conta_destino_id)
  #   conta.saldo = conta.saldo + self.valor
  #   conta.save
  # end
  # def validaValor
  #   if self.valor.nil?
  #     errors.add(:valor, "valida valor")
  #   end
  # end
  #
  # private
  #
  # def acrescentaTaxa
  #   taxa = Taxa.new
  #   resultado = taxa.defineTaxa(self.valor, Time.now)
  #   return resultado
  # end
  #
  # def consultaSaldoSuficienteContaOrigem(conta, taxa)
  #   if (conta.saldo > taxa)
  #     return true
  #   else
  #     return false
  #   end
  #
  # end
  #
  # def descontaContaOrigem(contaOrigem, valorTaxado )
  #   contaOrigem.saldo -= valorTaxado
  #   contaOrigem.save!
  # end
  #
  # def creditaContaDestimo(contaDestino, valor)
  #   contaDestino.saldo = contaDestino.saldo + valor
  #   contaDestino.save!
  # end
  #

end
