require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  def setup
    test_time = Time.local(2020, 2, 15 , 9, 00, 00)
    @user = users(:one)
    @reservation = @user.reservations.build(name: "xxxBand", start_date: test_time)
  end

  test "有効性の確認" do
    assert @reservation.valid?
  end

  test "nameがnilであれば無効" do
    @reservation.name = nil
    assert_not @reservation.valid?
  end

  test "start_dateがnilであれば無効" do
    @reservation.start_date = nil
    assert_not @reservation.valid?
  end

  test "user_idがnilであれば無効" do
    @reservation.user_id = nil
    assert_not @reservation.valid?
  end

  test "nameが空白であれば無効" do
    @reservation.name = "   "
    assert_not @reservation.valid?
  end

end
