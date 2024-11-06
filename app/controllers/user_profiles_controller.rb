class UserProfilesController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update ]

  def show
    # @userはset_userで設定されている
  end

  def edit
    # @userはset_userで設定されている
  end

  def update
    if @user.update(user_profile_params)
      redirect_to user_profile_path(@user), notice: "プロフィールが更新されました。"
    else
      render :edit
    end
  end

  private

  def set_user
    # showアクション用にはparams[:id]を使う
    @user = User.find(params[:id])
  end

  def user_profile_params
    params.require(:user).permit(:name, :profile, :profile_image) # 必要なパラメータを追加
  end
end
