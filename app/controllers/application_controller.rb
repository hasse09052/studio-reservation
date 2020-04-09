class ApplicationController < ActionController::Base

  include SessionsHelper
  include ReservationsHelper

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインして下さい"
      redirect_to login_url
    end
  end

end
