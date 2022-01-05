class ToppagesController < ApplicationController
  before_action :set_beginning_of_week

  def index #ログインしていたら予定を表示
    @schedules = current_user.schedules.all if logged_in?
  end
  
  private
  
  def set_beginning_of_week
    Date.beginning_of_week = :sunday
  end
end
