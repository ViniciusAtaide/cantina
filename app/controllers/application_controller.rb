class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :pedido_atual

  before_filter :create_session

  def create_session

  	session[:cart] ||= {}

  	unless params[:op].blank?
      unless params[:op] != 'clean'
      	session[:cart] = {}
      end
    end

  end

  protected

  def pedido_atual
  	if @pedido_atual.nil? && !session[:pedido_id].blank?
  		@pedido_atual = Pedido.find_by_id(session[:pedido_id])
  	end
  	@pedido_atual ||= Pedido.new
  end

end
