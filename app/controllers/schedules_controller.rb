class SchedulesController < ApplicationController
  before_action :require_user_login
  before_action :find_schedule, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
    @schedule = current_user.schedules.build
  end
  
  def create
    @schedule = current_user.schedules.build(schedule_params)
    if @schedule.save
      redirect_to root_url
      
      #給料登録、更新
      # Expense.calc_wage(@schedule.start_at, current_user) 
    else
      render :new
    end
  end 

  def edit
  end
  
  def update
    if @schedule.update(schedule_params)
      redirect_to schedule_url(@schedule)
      
      #給料登録、更新
      # Expense.calc_wage(@schedule.start_at, current_user) 
    else
      render :edit
    end
  end 
  
  def destroy
    @schedule.destroy
    flash[:success] = '予定を削除しました'
    redirect_to root_url
  end
  
  private
  
  def schedule_params
    params.require(:schedule).permit(:name, :start_at, :end_at, :memo, :work_id)
  end 
  
  def find_schedule
    @schedule = current_user.schedules.find_by(id: params[:id])
    other_users_data(@schedule)
  end 
end
