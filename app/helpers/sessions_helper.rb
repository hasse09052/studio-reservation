module SessionsHelper

  # 渡されたユーザーでログインする
  def log_in(user)
    session[:user_id] = user.id
  end

  # セッションIDかクッキーに基づくユーザを返す
  def current_user
    if session[:user_id]
      return @current_user ||= User.find_by(id: session[:user_id])
    elsif cookies.signed[:user_id]
      @user = User.find_by(id: cookies.signed[:user_id])
      if @user && @user.authenticated?(cookies[:remember_token])
        session[:user_id] = @user.id
        return @current_user
      end
    end
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    return !current_user.nil?
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

end
