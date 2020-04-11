require 'test_helper'

class MylistTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @reservation = reservations(:one)
    @mylist = Mylist.new(user_id: @user.id, reservation_id: @reservation.id)
  end

  test "有効性の確認" do
    assert @mylist.valid?
  end

  test "ユーザーIDがnilの時に無効にする" do
    @mylist.user_id = nil
    assert_not @mylist.valid?
  end

  test "予約IDがnilの時に無効にする" do
    @mylist.reservation_id = nil
    assert_not @mylist.valid?
  end
end
