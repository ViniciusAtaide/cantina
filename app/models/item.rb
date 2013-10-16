class Item < ActiveRecord::Base
  # attr_accessible :title, :body
  belongs_to :produto
  belongs_to :pedido

  validates_numericality_of :quantidade, :greather_than => 0, :allow_nil => true

  def incrementar_quantidade(quantidade)
  	self.quantidade += quantidade
  end

end
