class Consumidor < ActiveRecord::Base
  attr_accessible :cpf, :email, :nome, :observacao, :operacao, :telefone, :tipo, :saldo

  belongs_to :venda
  has_one :venda
  
  validates_presence_of :cpf, :email, :nome, :telefone, :tipo
end
