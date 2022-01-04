module SessionsHelper
  #ログインユーザを取得
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  #ログイン判定
  def logged_in?
    !!current_user
  end
end
