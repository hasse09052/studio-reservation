require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "ユーザ作成画面にアクセスできるか" do
    get new_user_path
    assert_response :success
  end

end
