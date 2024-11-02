module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token, only: :spotify

    def spotify
      # 環境変数のデバッグログ
      Rails.logger.debug "CLIENT_ID: #{ENV['CLIENT_ID']}"
      Rails.logger.debug "CLIENT_SECRET: #{ENV['CLIENT_SECRET']}"

      # ユーザー情報を取得
      @user = User.from_omniauth(request.env["omniauth.auth"])

      # @userがデータベースに保存されているかどうか
      if @user.persisted?
        # 既存のユーザーがデータベースに保存されている場合、そのユーザーをサインイン状態にしておく
        sign_in_and_redirect @user, event: :authentication
        # サインインが成功した場合、成功メッセージを設定する
        set_flash_message(:notice, :success, kind: "spotify") if is_navigational_format?
      else # 保存されていない場合
        # 一時的にセッションに認証情報を保存する
        session["devise.spotify_data"] = request.env["omniauth.auth"].except(:extra)
        # 新しいユーザーの登録ページにリダイレクト
        redirect_to new_user_registration_url
      end
    end

    def failure
      redirect_to root_path
    end
  end
end
