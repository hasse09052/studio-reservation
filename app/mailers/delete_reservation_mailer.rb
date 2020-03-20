class DeleteReservationMailer < ApplicationMailer

  def send_when_delete_reservation(user, reservation)
    @user = user
    @reservation = reservation
    mail to: @user.email, subject: "[スタジオ管理アプリ]予約削除のお知らせ" do |format|
      format.text
    end
  end

end
