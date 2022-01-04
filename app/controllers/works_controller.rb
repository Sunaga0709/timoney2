class WorksController < ApplicationController
  before_action :require_user_login 
  before_action :find_work, only: [:show, :edit, :update, :destroy]
  
  def index 
    @works = current_user.works.all
  end
  
  def show
  end

  def new
    @work = current_user.works.build
  end
  
  def create
    @work = current_user.works.build(work_params)
    if @work.save
      redirect_to works_url
    else
      render :new
    end 
  end 

  def edit
  end
  
  def update
    if @work.update(work_params)
      redirect_to work_url(@work)
    else
      render :edit
    end
  end 
  
  def destroy
    @work.destroy
    flash[:success] = '勤務先を削除しました'
    redirect_to works_url
  end
  
  private
  
  def work_params
    params.require(:work).permit(:name, :wage, :wage_type, :carfare, :carfare_type)
  end 
  
  def find_work
    @work = current_user.works.find_by(id: params[:id])
    other_users_data(@work)
  end 
end
