class Venda < ActiveRecord::Base
  attr_accessible :quantidade_venda, :valor_total, :consumidor_id, :produto_id

  belongs_to :produto
  belongs_to :estoque
  belongs_to :consumidor
  has_many :produtos
  has_one :consumidors

  def self.for_produto(produto) 
   produto = self.produto_id
   item = self.new 
   item.quantidade_venda = 1; 
   item.produto = produto 
   item.preco = produto.preco_venda
   item 
  end
  
end