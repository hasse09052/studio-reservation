class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      # 永続セッションのためにハッシュ化したトークンをデータベースに記憶する
      @user.remember

      log_in @user 
      
      redirect_back_or "/reservations/table/1"
    else
      flash.now[:danger] = 'メールアドレスかパスワードが間違っています'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

end
