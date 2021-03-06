class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @userReservations = @user.reservations.all.order(:start_date)
    @mylistReservations = @user.mylist_reservations.all.order(:start_date)
    @reservations =  (@userReservations + @mylistReservations).sort_by { |item| item[:start_date] }
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザー登録に成功しました！"
      redirect_to "/reservations/table/1"
    else
      render "users/new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "ユーザー情報の更新に成功しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "アカウントを削除しました"
      redirect_to root_url
    else
      render 'edit'
    end
  end

  private

    # 送信されたユーザ情報を制限して返す
    def user_params
      return params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    # ----------beforeアクション----------

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      if current_user?(@user) == false
        redirect_to(root_url)
      end
    end

end
