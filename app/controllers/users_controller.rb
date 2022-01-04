class UsersController < ApplicationController
  before_action :require_user_login, only: [:show, :edit, :update, :destroy]
  before_action :trial_user?, only: [:show, :edit, :update, :destroy] 
  before_action :find_user, only: [:show, :edit, :update, :destroy] 

  def show
  end

  def new
    if logged_in?
      flash[:danger] = '既にログインしています'
      redirect_to root_url
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}さんの情報を削除しました"
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def find_user
    @user = User.find_by(id: params[:id])
    other_users_data(@user)
  end
  
  #お試しユーザか判定し、お試しユーザだったらトップページへ
  def trial_user?
    if current_user.id == 1
      redirect_to root_url
    end 
  end
end
