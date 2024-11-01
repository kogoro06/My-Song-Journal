class SessionsController < ApplicationController
  def create
    user = User.find_or_create_from_omniauth!(request.env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path, notice: "Spotifyでログインしました！"
  end
end
