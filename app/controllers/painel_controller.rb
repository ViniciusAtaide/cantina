class PainelController < ApplicationController
	def index
    @vendas_do_mes = Venda.all :conditions => ["created_at >= ?", Date.today.at_beginning_of_month]
	end
end
