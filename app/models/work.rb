class Work < ApplicationRecord
  belongs_to :user
  has_many :schedules, dependent: :destroy
  
  validates :name, presence: true, length: {in: 1..25}
  validates :wage, presence: true, numericality: {only_integer: true, greater_than: 1}, length: {maximum: 9}
  validates :wage_type, presence: true
  enum wage_type: {wage_hourly: 0, wage_daily: 1}
  validates :carfare, presence: true, numericality: {only_integer: true, greater_than_equal_to: 0}, length: {maximum: 7}
  validates :carfare_type, presence: true
  enum carfare_type: {carfare_daily: 0, carfare_monthly: 1}
  validates :user_id, presence: true 
end
