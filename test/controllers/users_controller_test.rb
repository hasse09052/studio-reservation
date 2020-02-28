require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:tarou)
    @other_user = users(:hanako)
  end

  test "ユーザ作成画面にアクセスできるか" do
    get new_user_path
    assert_response :success
  end

  test "ログインしていなければ編集ページにアクセスした際リダイレクト" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインしていなければ更新データ送った際リダイレクト" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "ログインユーザーが別ユーザーの編集ページにアクセスした際リダイレクト" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "ログインユーザーが別ユーザーに更新データ送った際リダイレクト" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

end
