class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    if not user_signed_in?
      redirect_to :controller => 'users', :action => :sign_in
    else
      throw exception
    end
  end
end
