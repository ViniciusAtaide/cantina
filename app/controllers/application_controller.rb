class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :create_session

  def create_session

    if session[:cart] == {}
      File.open("public/tmp_lista.txt", "a+") do |f|
        arquivo = IO.readlines("public/tmp_lista.txt")
        cabecalho = "Produto" + "    " + "Preço" + "    " + "Qtd" + "\n"
        if arquivo[0] == cabecalho
          return false
        else
          f << cabecalho
        end
      end
    end

    #session[:cart] = {}
  	session[:cart] ||= {}

  	unless params[:op].blank?
      unless params[:op] != 'clean'
      	session[:cart] = {}
      end
    end

  end

end