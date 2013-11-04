class Venda < ActiveRecord::Base
  attr_accessible :quantidade_venda, :valor_total, :consumidor_id, :produto_id

  validates_presence_of :quantidade_venda, :valor_total, :consumidor_id, :produto_id

  belongs_to :produto
  belongs_to :estoque
  belongs_to :consumidor
  has_many :produtos
  has_one :consumidors

  def cria_txt
  	nome_arquivo = RAILS_ROOT + "/arquivo.txt"
  	arquivo = File.open(nome_arquivo, "wb")
  	arquivo.puts 'nome: Paulo'
  	arquivo.close
  end


  def get_vendas_do_dia
    Venda.where :created_at => Date.today
  end


end