class ToppagesController < ApplicationController
  def index #ログインしていたら予定を表示
    @schedules = current_user.schedules.all if logged_in?
  end
end
