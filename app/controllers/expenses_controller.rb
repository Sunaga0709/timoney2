class ExpensesController < ApplicationController
  include Pagy::Backend
  
  before_action :require_user_login
  before_action :find_expense, only: [:show, :edit, :update, :destroy]
  before_action :set_date, only: [:index]

  def index
    #dataがなかったら現在の月を入れる
    if params[:date].blank? 
      expenses = get_expenses(@current_date)
    else 
      @current_date = params[:date].to_date
      expenses = get_expenses(@current_date)
    end
    
    #ページネーションとソート
    @q = expenses.ransack(params[:q])
    @pagy, @expenses = pagy(@q.result(distinct: true), items: 10)
    
    @total_income, @total_outgo, @diff_expense = Expense.total_expense(expenses)
  end

  def show
  end

  def new
    @expense = current_user.expenses.build
  end
  
  def create
    @expense = current_user.expenses.build(expense_params)
    if @expense.save
      redirect_to expenses_url
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @expense.update(expense_params)
      redirect_to expense_url(@expense)
    else
      render :edit
    end
  end 
  
  def destroy
    @expense.destroy
    flash[:success] = '収支情報を削除しました'
    redirect_to expenses_url
  end

  private
  
  def expense_params
    params.require(:expense).permit(:name, :amount, :date, :memo, :expense_type)
  end 
  
  def find_expense
    @expense = current_user.expenses.find_by(id: params[:id])
    other_users_data(@expense)
  end 
  
  #current_dateがなかったら現在の日付を入れる
  def set_date 
    unless @current_date
      @current_date = Date.current
    end
  end 
  
  #指定の月の収支情報を取得
  def get_expenses(current_date) 
    current_user.expenses.monthly(current_date)
  end
end
