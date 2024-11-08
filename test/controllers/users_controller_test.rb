require "test_helper"
include Devise::Test::IntegrationHelpers

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user
  end

  test "should get show" do
    get users_show_url
    assert_response :success
  end
end
