require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers  # Deviseのヘルパーをインクルード

  setup do
    @user = users(:one)
    sign_in @user  # ユーザーをサインイン
  end

  test "should get show" do
    get user_url(@user)  # 適切なユーザーのURLにアクセス
    assert_response :success
  end
end
