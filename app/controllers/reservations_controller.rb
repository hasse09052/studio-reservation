class ReservationsController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :create, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    startDate = Time.current
    @startDate = Time.zone.local(startDate.year, startDate.month, startDate.day, 9, 00, 00)
    @reservations = Reservation.all
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
      redirect_to reservations_url
    else
      render "reservations/new"
    end
  end

  def edit
    
  end

  def update
    if @reservation.update(name: params[:reservation][:name])
      flash[:success] = "予約の更新に成功しました"
      redirect_to reservations_url
    else
      render 'edit'
    end
  end

  def destroy
    @reservation.destroy
    flash[:success] = "予約を削除しました"
    redirect_to reservations_url
  end

  private

    # ログインユーザの予約かどうか確認
    def correct_user
      @reservation = current_user.reservations.find_by(id: params[:id])
      if @reservation.nil?
        flash[:denger] = "あなたの予約ではありません"
        redirect_to reservations_url
      end
    end


end
