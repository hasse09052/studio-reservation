class MylistsController < ApplicationController

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @mylist = Mylist.new(user_id: current_user.id, reservation_id: params[:reservation_id])
    @mylist.save
    redirect_to @reservation
  end

  def destroy
    @reservation = Reservation.find(params[:reservation_id])
    @mylist = Mylist.find_by(user_id: current_user.id, reservation_id: params[:reservation_id])
    @mylist.destroy
    redirect_to @reservation
  end

end
