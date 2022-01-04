class Expense < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length:{in: 1..15}
  validates :amount, presence: true, numericality: {only_integer: true, greater_than: 1}, length: {maximum: 9}
  validates :date, presence: true
  validates :memo, length: {maximum: 255}
  validates :expense_type, presence: true
  enum expense_type: {outgo: 0, income: 1}
  
  scope :monthly, -> (current_date) { where(date: current_date.beginning_of_month..current_date.end_of_month) }
  
  def self.total_expense(expenses)
    #合計金額の初期化
    total_income = 0
    total_outgo = 0
    diff_expense = 0
    
    expenses.each do |expense|
      if expense.expense_type == 'outgo'
        total_outgo += expense.amount
      elsif expense.expense_type = 'income'
        total_income += expense.amount
      end
    end
    diff_expense = total_income - total_outgo
    
    return total_income, total_outgo, diff_expense
  end
end
