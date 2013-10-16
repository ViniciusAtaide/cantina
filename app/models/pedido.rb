class Pedido < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :items
  has_many :produtos, :through => :items

  def adicionar_produto(produto,quantidade)
  	if item = self.items.detect { |elemento| elemento.produto == produto }
  		item.incrementar_quantidade(quantidade)
  		item.save
  	else
  		self.items.create(:produto => produto, :quantidade => quantidade)
  	end
  end

end
