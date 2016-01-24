class Saque < ActiveRecord::Base

  has_many :conta
  after_validation :corrigeValor
  validate :iniciaSaque
  validates_format_of :valorProvisorio, presence: true, :with => /(?:\d*.+,)?\d+/i, :message => "Não pode ficar em branco nem ser letras. Aceita (,) ou (.)"
  # validates_presence_of :valorProvisorio, :allow_blank => false, :message => "não pode ficar em branco"

  attr_accessor :valorProvisorio
  # scope :saques, ->{order(:created_at)}

  def corrigeValor
    self.valor = self.valorProvisorio.gsub(/,/){'.'}.to_d
  end

  def iniciaSaque
    corrigeValor
    conta = Conta.find(conta_id)
    if validaSaldo(conta)
      criaSaque(conta)
    end
    # corrigeValor
    # conta = Conta.find(conta_id)
    # if (conta.saldo == 0)
    #   errors.add(:conta, "Conta está com saldo R$ 0,00." )
    # elsif (conta.saldo < self.valor)
    #   errors.add(:valor, "Valor não pode ser maior que saldo R$ em conta." )
    # end
    # conta.saldo = conta.saldo - valor
    # conta.save
  end

private
  def validaSaldo(conta)
    if (conta.saldo == 0)
      errors.add(:conta, "Conta está com saldo R$ 0,00." )
    elsif (conta.saldo < self.valor)
      errors.add(:valor, "Valor não pode ser maior que saldo R$ em conta." )
    end
    return true
  end


  def criaSaque(conta)
    conta.saldo = conta.saldo - self.valor
    conta.save!
  end
end
