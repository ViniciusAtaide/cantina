class Categoria < ActiveRecord::Base
  attr_accessible :nome

  belongs_to :produto
end
