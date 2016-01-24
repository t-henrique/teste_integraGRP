class Correntista < ActiveRecord::Base
  # has_one :user
  has_many :contas, :class_name => "Conta"
  validates_associated :contas

  validates_presence_of :cpf, message: ("não pode ficar em branco")
  with_options :allow_blank => false do |v|
    v.validates_presence_of :nome, message: ("não pode ficar em branco")
    v.validates_presence_of :endereco, message: ("não pode ficar em branco")
    v.validates_presence_of :bairro, message: ("Não pode ficar em branco")
    v.validates_presence_of :cidade, message: ("Não pode ficar em branco")
    v.validates_presence_of :estado, message: ("Não pode ficar em branco")
    v.validates_length_of :cpf, :is => 11, message: ("Deve ter 11 dígitos")
    v.validates_numericality_of :cpf, message:("deve conter apenas números, favor não digitar (.) e (-)"), :allow_blank => true
    v.validates_uniqueness_of :cpf, message:("já foi cadastrado anteriormente, favor verificar."), :allow_blank => true
  end

  validate :validates_as_cpf
  before_save :trataNome
  #
  # validate do |correntista|
  #   correntista.contas.each do |contas|
  #     next if contas.isvalid?
  #     contas.errors.full_messages.each do |msg|
  #       # you can customize the error message here:
  #       errors.add_to_base("Erros na Conta: #{msg}")
  #     end
  #   end
  # end


  def validates_as_cpf
    # errors.add if cpf.blank?
    # return false if cpf.nil?

    winvalidos = %w{12345678909 11111111111 22222222222 33333333333 44444444444 55555555555 66666666666 77777777777 88888888888 99999999999 00000000000}
    wvalor = cpf.scan /[0-9]/
    if wvalor.length == 11
      unless winvalidos.member?(wvalor.join)
        wvalor = wvalor.collect{|x| x.to_i}
        wsoma = 10*wvalor[0]+9*wvalor[1]+8*wvalor[2]+7*wvalor[3]+6*wvalor[4]+5*wvalor[5]+4*wvalor[6]+3*wvalor[7]+2*wvalor[8]
        wsoma = wsoma - (11 * (wsoma/11))
        wresult1 = (wsoma == 0 or wsoma == 1) ? 0 : 11 - wsoma
        if wresult1 == wvalor[9]
          wsoma = wvalor[0]*11+wvalor[1]*10+wvalor[2]*9+wvalor[3]*8+wvalor[4]*7+wvalor[5]*6+wvalor[6]*5+wvalor[7]*4+wvalor[8]*3+wvalor[9]*2
          wsoma = wsoma - (11 * (wsoma/11))
          wresult2 = (wsoma == 0 or wsoma == 1) ? 0 : 11 - wsoma
          return true if wresult2 == wvalor[10] # CPF validado
        end
      end
    end
    errors.add(:cpf, " - O CPF informado não é válido")
    # return false # CPF invalidado
  end
  def self.carregaEstados
    estado = {
      "AC" => "Acre",
      "AL" => "Alagoas",
      "AP" => "Amapá",
      "AM" => "Amazonas",
      "BA" => "Bahia",
      "CE" => "Ceará",
      "DF" => "Distrito Federal",
      "ES" => "Espírito Santo",
      "GO" => "Goiás",
      "MA" => "Maranhão",
      "MT" => "Mato Grosso",
      "MS" => "Mato Grosso do Sul",
      "MG" => "Minas Gerais",
      "PA" => "Pará",
      "PB" => "Paraíba",
      "PR" => "Paraná",
      "PE" => "Pernambuco",
      "PI" => "Piauí",
      "RJ" => "Rio de Janeiro",
      "RN" => "Rio Grande do Norte",
      "RS" => "Rio Grande do Sul",
      "RO" => "Rondônia",
      "RR" => "Roraima",
      "SC" => "Santa Catarina",
      "SP" => "São Paulo",
      "SE" => "Sergipe",
      "TO" => "Tocantins",
    }
  end

  def trataNome
    self.nome = nome.titleize
    self.nome = nome.squish
  end

end
