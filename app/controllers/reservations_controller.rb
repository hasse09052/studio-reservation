class ReservationsController < ApplicationController
  require 'line/bot'

  # ログイン済みユーザーかどうか確認
  before_action :logged_in_user
  # ログインユーザの予約かどうか確認
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @limitStartWeek = 1
    @limitEndWeek = 3
    if params[:week].to_i < @limitStartWeek || params[:week].to_i > @limitEndWeek
      redirect_to "/reservations/table/1"
    end
    afterWeek = params[:week].to_i - 1
    startDate = Time.current.weeks_since(afterWeek)
    @startDate = Time.zone.local(startDate.year, startDate.month, startDate.day, 9, 00, 00)
    @reservations = Reservation.all
    @mylistReservations = current_user.mylist_reservations.all.order(:start_date)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @user = @reservation.user
    @mylistUsers = @reservation.mylist_users.all
  end

  def new
    @reservation = Reservation.new
    @reservation_time = Time.zone.local(params[:year], params[:month],
                                        params[:day], params[:hour], params[:minute], 00)
  end

  def create
    @user = current_user
    @reservation_time = Time.zone.local(params[:year], params[:month],
                                        params[:day], params[:hour], params[:minute], 00)
    @reservation =  @user.reservations.new(name: params[:name], start_date: @reservation_time)

    if @reservation.save
      flash[:success] = "予約に成功しました！"
      redirect_to reservationTablePath(@reservation)
    else
      render "reservations/new"
    end
  end

  def edit
    
  end

  def update
    if @reservation.update(name: params[:reservation][:name])
      flash[:success] = "予約の更新に成功しました"
      redirect_to reservationTablePath(@reservation)
    else
      render 'edit'
    end
  end

  def destroy
    # Line Botで削除通知
    date = @reservation.start_date.strftime("%Y年%m月%d日(#{%w(日 月 火 水 木 金 土)[@reservation.start_date.wday]})")
    time = @reservation.start_date.strftime("%H時%M分〜")
    name = @reservation.name
    url = "https://box-reservation-app.herokuapp.com/reservations/new/" + @reservation.start_date.strftime("%Y/%m/%d/%H/%M")
    message = {
      type: 'text',
      text: "予約が削除されました。\n  日付:#{date}\n  時間:#{time}\n  名前:#{name}\n\n予約される方は、以下URLからお願いします。\n#{url}"
    }
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
    client.push_message(ENV["LINE_GROUP_ID"], message)

    @reservation.destroy
    flash[:success] = "予約を削除しました"
    redirect_to reservationTablePath(@reservation)
  end

  private

    # ログインユーザの予約かどうか確認
    def correct_user
      @reservation = current_user.reservations.find_by(id: params[:id])
      if @reservation.nil?
        flash[:danger] = "あなたの予約ではありません"
        redirect_to "/reservations/table/1"
      end
    end

end
