class ReservationsController < ApplicationController

  def index
    startDate = Time.current
    @startDate = Time.zone.local(startDate.year, startDate.month, startDate.day, 9, 00, 00)
    @reservations = Reservation.all
  end

  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.all
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
      redirect_to reservations_url
    else
      render "reservations/new"
    end
  end

end
