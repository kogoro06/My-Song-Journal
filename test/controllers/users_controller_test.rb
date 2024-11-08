require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # Deviseのヘルパーをインクルード

  setup do
    @user = users(:one)  # users.yml にあるテストユーザーのデータ
    @user.confirm  # ユーザーがconfirmableを必要とする場合に必要
    sign_in @user  # ユーザーをサインインさせる
  end

  test "should get show" do
    get user_url(@user)  # ユーザー詳細ページのURL
    assert_response :success
  end
end
