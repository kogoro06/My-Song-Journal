require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = users(:one)  # テスト用ユーザーをfixturesやfactoryで準備
    get user_url(user)  # `user_url`でユーザーIDに基づいたURLを取得
    assert_response :success
  end
end
