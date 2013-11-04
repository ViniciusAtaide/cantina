class Categoria < ActiveRecord::Base
  attr_accessible :nome

  validates_presence_of :nome

  belongs_to :produto
  has_many :produtos
end
