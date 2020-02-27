require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tarou)
  end

  test "誤ったログイン情報でログインさせないか" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { email: "a", 
                               password: "a" }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "正常にログインした後に、ログアウトできるか" do
    get login_path
    post login_path, params: { email: @user.email,
                               password: 'password' }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete logout_path
  end

end
