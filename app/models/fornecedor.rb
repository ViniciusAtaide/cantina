class Fornecedor < ActiveRecord::Base
  attr_accessible :nome

  belongs_to :estoque
end
