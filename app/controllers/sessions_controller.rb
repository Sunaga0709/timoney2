class SessionsController < ApplicationController
  before_action :require_user_login, only: [:destroy]
  
  def new
    if logged_in? #ログインしていたらトップページへ
      redirect_to root_url
    end
  end
  
  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash.now[:danger] = 'ログインできませんでした'
      render :new
    end
  end
  
  def destroy
    session.delete(:user_id) 
    @current_user = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  def trial_login #お試しユーザのログイン
    user = User.find_by(id: 999)
    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      flash[:danger] = '現在、お試しログインはご利用いただけません'
      redirect_to root_url
    end
  end
  
  private
  
  def session_params
    params.require(:session).permit(:email, :password)
  end
end
