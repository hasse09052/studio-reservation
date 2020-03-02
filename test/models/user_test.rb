require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "テスト太郎", email: "test@test.com",
                      password: "12345678", password_confirmation: "12345678")
  end

  test "ユーザが有効か確認" do
    assert @user.valid?
  end

  test "名前が空白なのを拒否" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "メールアドレスが空白なのを拒否" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "名前が長すぎるのを拒否" do
    @user.name = "a" * 31
    assert_not @user.valid?
  end

  test "メールアドレスが長すぎるのを拒否" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "メールアドレスのフォーマットが正しいか確認(正しいメールアドレスを通すか)" do
    valid_addresses = %w[user@test.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "メールアドレスのフォーマットが正しいか確認(無効なメールアドレスを拒否するか)" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. oo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "メールアドレスの重複が無効になるか" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "パスワードが空白の時に拒否" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "パスワードが短すぎるのを拒否" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "データベース上のトークンが無い時、authenticated?メソッドが false を返すか" do
    assert_not @user.authenticated?('')
  end

  test "ユーザーが削除された時に予約も消えるか" do
    @user.save
    @user.reservations.create!(name: "xxxBand", start_date: Time.current)
    assert_difference 'Reservation.count', -1 do
      @user.destroy
    end
  end

end
