# app/controllers/users/omniauth_callbacks_controller.rb
class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def spotify
    auth_hash = request.env["omniauth.auth"]
    user = User.find_or_create_from_omniauth!(auth_hash)

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = "Spotifyでログインしました！" if is_navigational_format?
    else
      redirect_to new_user_registration_url, alert: "Spotifyでのログインに失敗しました。"
    end
  end
  def failure
    Rails.logger.error("OmniAuth authentication failed: #{failure_message}")
    super
  end

  private

  def failure_message
    request.env["omniauth.error.type"]
  end
end
