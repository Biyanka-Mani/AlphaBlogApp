require "test_helper"

class RemoteControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get remote_home_url
    assert_response :success
  end
end
