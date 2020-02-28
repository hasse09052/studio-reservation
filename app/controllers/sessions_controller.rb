class SessionsController < ApplicationController
  
  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user && @user.authenticate(params[:password])
      # 永続セッションのためにハッシュ化したトークンをデータベースに記憶する
      @user.remember

      log_in @user 
      cookies.permanent.signed[:user_id] = @user.id
      cookies.permanent[:remember_token] = @user.remember_token
      
      redirect_back_or @user
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
