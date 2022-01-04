class ApplicationController < ActionController::Base
  include SessionsHelper
  
  # 未ログインの場合、ログイン画面へ
  def require_user_login 
    unless logged_in?
      flash[:danger] = 'ログイン、もしくはユーザ登録してください'
      redirect_to root_url 
    end 
  end
  
  # ログインユーザのデータか判定し、違う場合トップページへ
  def other_users_data(object)  
    unless object
      flash[:danger] = 'あなた以外の情報の閲覧、編集はできません'
      redirect_to root_url
    end 
  end
  
  def after_sign_in_path_for(resource)
    case resource
    when AdminUser
      stored_location_for(resource) ||
      if resource.is_a?(AdminUser)
        admin_admin_users_path
      else
        super
      end
    end
  end
end
