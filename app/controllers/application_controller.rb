class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_decorator

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def after_sign_in_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :email, :password, :password_confirmation, :name ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :password, :password_confirmation, :current_password, :name, :profile ])
  end

  def set_decorator
    @current_user_decorated = current_user.decorate if user_signed_in?
  end
end
