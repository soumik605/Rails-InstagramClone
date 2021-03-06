class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protect_from_forgery with: :exception

    rescue_from CanCan::AccessDenied do
      flash[:error] = 'Access denied!'
      redirect_to root_url
    end
    

  protected

  def configure_permitted_parameters
    added_attrs = [:first_name, :last_name, :phone, :gender, :username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

end
