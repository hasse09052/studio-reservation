class ReservationsController < ApplicationController

  def index
    startDate = Time.current
    #@startDate = Time.zone.local(startDate.year, startDate.month, startDate.day, 9, 00, 00)
    @startDate = Time.zone.local(2020, 2, 28, 9, 00, 00)
    @reservations = Reservation.all
  end

  def show
    @user = User.find(params[:id])
    @reservations = @user.reservations.all
  end

  def new
    @reservation = Reservation.new
    @time = Time.zone.local(params[:year], params[:month],
                            params[:day], params[:time], 00, 00)
  end

end
