class Produto < ActiveRecord::Base
  attr_accessible :descricao, :nome, :preco_venda, :unidade_medida, :categoria_id
  
  has_one :estoque
  belongs_to :categoria
  belongs_to :venda

  def self.mostrar_produtos
  	find(:all, :order => "categoria_id")
  end

end