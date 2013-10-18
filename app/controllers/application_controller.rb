class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :create_session

  def create_session

  	session[:cart] ||= {}

  	unless params[:op].blank?
      unless params[:op] != 'clean'
      	session[:cart] = {}
      end
    end

  end

end
