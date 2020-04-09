class MylistsController < ApplicationController

  def create
    @reservation = Reservation.find(params[:reservation_id])
    @mylist = Mylist.new(user_id: current_user.id, reservation_id: params[:reservation_id])
    diffWeek = todayDiffWeek(@reservation.start_date) + 1

    if @mylist.save
      flash[:success] = "マイリストに追加しました"
      redirect_to "/reservations/table/#{diffWeek}"
    else
      flash[:danger] = "マイリストの追加に失敗しました"
      redirect_to @reservation
    end
  end

  def destroy
    @reservation = Reservation.find(params[:reservation_id])
    diffWeek = todayDiffWeek(@reservation.start_date) + 1
    @mylist = Mylist.find_by(user_id: current_user.id, reservation_id: params[:reservation_id])
    @mylist.destroy

    if @mylist.destroy
      flash[:success] = "マイリストから解除しました"
      redirect_to "/reservations/table/#{diffWeek}"
    else
      flash[:danger] = "マイリストの解除に失敗しました"
      redirect_to @reservation
    end
  end

end
