module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :spotify

    def spotify
      # 環境変数のデバッグログ
      Rails.logger.debug "CLIENT_ID: #{ENV['CLIENT_ID']}"
      Rails.logger.debug "CLIENT_SECRET: #{ENV['CLIENT_SECRET']}"

      # ユーザー情報を取得
      @user = User.from_omniauth(request.env["omniauth.auth"])

      if @user.persisted?
        # ユーザーが存在する場合、サインインしてリダイレクト
        sign_in_and_redirect @user, event: :authentication

        # 成功メッセージをフラッシュに設定
        flash[:notice] = I18n.t("devise.omniauth_callbacks.success", kind: "Spotify")
      else
        # ユーザーが保存されていない場合
        session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra)
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
