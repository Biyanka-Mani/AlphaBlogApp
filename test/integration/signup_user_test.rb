require "test_helper"

class SignupUserTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should be able to signup a user" do
    get "/users/new"
    assert_response :success
    assert_difference("User.count",1) do
      post users_path,params: { user: { username:"Riya" ,email: "Riya@gamil.com",password:"12345678"}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Riya",response.body
  end
end
