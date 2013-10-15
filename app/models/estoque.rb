class Estoque < ActiveRecord::Base
  attr_accessible :custo_medio, :fornecedor_id, :preco_compra, :produto_id, :quantidade_estoque, :quantidade_min

  belongs_to :produto
  belongs_to :fornecedor
  belongs_to :venda

  has_many :produtos
  has_many :consumidors

  def custo_medio
  	self.quantidade_estoque * self.produto.preco_venda
  end

end