class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include ApplicationHelper
  helper :all

  def after_sign_in_path_for(resource)
    root_path      
  end

  def verify_admin
    unless admin?
      flash[:error] = "Accesss Denied"
      redirect_to root_url
    end
  end 
end
