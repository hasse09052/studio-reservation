module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # セッションIDかクッキーに基づくユーザを返す
  def current_user
    if session[:user_id]
      return @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      @user = User.find_by(id: cookies.signed[:user_id])
      if @user && @user.authenticated?(cookies[:remember_token])
        session[:user_id] = @user.id
        @current_user = @user
        return @current_user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    return !current_user.nil?
  end

  # 渡されたユーザーがログイン済みユーザーであればtrue、違うならfalseを返す
  def current_user?(user)
    if user == current_user
      return true
    else
      return false
    end
  end

  # クッキーとデータベースのユーザ情報を削除
  def forget(user)
    # データベース上のトークン削除
    user.forget

    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # ログイン中のユーザをログアウトする
  def log_out
    forget(current_user)
    @current_user = nil
    session.delete(:user_id)
  end

  # 記憶したURL (もしくはデフォルト値) にリダイレクト
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # アクセスしようとしたURLをセッションに記憶
  def store_location
    if request.get?
      session[:forwarding_url] = request.original_url
    end
  end

end
