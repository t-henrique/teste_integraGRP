class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_one :correntista, foreign_key: "users_id"

  attr_accessor :correntista_id

  after_find :preencheCorrentistaID

  def preencheCorrentistaID
    self.correntista_id = self.correntista.id if !self.correntista.nil?
  end

end
