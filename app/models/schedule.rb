class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :work, optional: true
  
  validates :name, presence: true, length: {in: 1..20}
  validates :start_at, presence: true
  validates :end_at, presence: true
  validates :memo, length: {maximum: 255}
  validates :user_id, presence: true 
  validate :start_end_check
  
  def start_end_check
    if start_at.present? && end_at.present?
      errors.add(:end_at, "を正しく入力して下さい。") if start_at > end_at
    end
  end 
  
  def start_time
    start_at
  end

  def end_time
    end_at
  end
end
