class Produto < ActiveRecord::Base
  attr_accessible :descricao, :nome, :preco_venda, :unidade_medida, :foto, :categoria_id
  
  has_one :estoque
  belongs_to :categoria
  belongs_to :venda

  has_attached_file :foto, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  def self.mostrar_produtos
  	find(:all, :order => "categoria_id")
  end

end