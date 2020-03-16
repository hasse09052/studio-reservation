class ReservationsController < ApplicationController
  # ログイン済みユーザーかどうか確認
  before_action :logged_in_user, only: [:index, :edit, :update, :create, :destroy]
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
      redirect_to "/reservations/table/1"
    else
      render "reservations/new"
    end
  end

  def edit
    
  end

  def update
    if @reservation.update(name: params[:reservation][:name])
      flash[:success] = "予約の更新に成功しました"
      redirect_to "/reservations/table/1"
    else
      render 'edit'
    end
  end

  def destroy
    @reservation.destroy
    flash[:success] = "予約を削除しました"
    redirect_to "/reservations/table/1"
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
