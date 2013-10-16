class Venda < ActiveRecord::Base
  attr_accessible :quantidade_venda, :valor_total, :consumidor_id, :produto_id

  belongs_to :produto
  belongs_to :estoque
  belongs_to :consumidor
  has_many :produtos
  has_one :consumidors
  
end