# app/controllers/users_controller_test.rb
require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    user = users(:example) # テスト用のユーザーを fixtures から読み込むか、テスト用に作成
    get user_url(user) # user の詳細ページに GET リクエストを送信
    assert_response :success
  end
end
