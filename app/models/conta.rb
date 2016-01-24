class Conta < ActiveRecord::Base
  belongs_to :correntista
  has_many :saque
  has_many :deposito, foreign_key: "conta_destino_id"
  before_destroy :inativate
  before_create :corrigeValor
  # after_validation :corrigeVa/lor

  # validates_numericality_of :saldoProvisorio, message: ("Deve ser número ou o valor ou 0") unless nil
  validates_format_of :saldoProvisorio, :allow_blank => true, :with => /(?:\d*.+,)?\d+/i, :message => "Não pode ficar em branco nem ser letras. Aceita (,) ou (.)"


  attr_accessor :saldoProvisorio

  scope :ativa, ->{
    where(flag_ativo: "S")
  }

  scope :qtdAtiva, ->{
    where(flag_ativo: "S").count
  }

  def before_destroy
    if saldo == 0
      self.saldoProvisorio = 0
      self.flag_ativo = 'N'
      return true
    end
    errors.add :base, "thiago thiago"
    # or errors.add_to_base in Rails 2
    false
  end

  def corrigeValor
    self.saldo = self.saldoProvisorio.gsub(/,/){'.'}.to_d
  end

  def self.retornaContasAtivas
    ativa.each{ |x| p x.id }
  end

  def self.retornaContasAtivasSemContaOrigem(conta)
    retorno = []
    ativa.where.not(:id => conta).order(:id).each do |x|
      retorno << x.id
    end
    retorno
  end

  def extratoSaque
    self.saque
  end

  def extratoDeposito
    self.deposito.deposito
  end

  def extratoTransferenciaRecebidas
    self.deposito.transferenciaRecebidas
  end

  def extratoTransferenciaOriginadas
    Deposito.where("conta_origem_id = ?", self.id)
  end

end
