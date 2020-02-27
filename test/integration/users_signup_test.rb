require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest

  test "無効なユーザ情報で登録を行わないか" do
    get new_user_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_template 'users/new'
  end

  test "有効なユーザ情報で登録を行い、ログインするか" do
    get new_user_path
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name:  "Example User",
                                         email: "user@example.com",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/index'
    assert is_logged_in?
  end
end
