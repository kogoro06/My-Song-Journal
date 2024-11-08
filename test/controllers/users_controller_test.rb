test "should get show" do
  user = User.create!(email: "unique_email_#{SecureRandom.hex(4)}@example.com", password: "password")
  get user_url(user)
  assert_response :success
end