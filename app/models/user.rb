class User < ApplicationRecord
  has_many :expenses, dependent: :destroy
  has_many :schedules, dependent: :destroy
  has_many :works, dependent: :destroy
  
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: {in: 1..15}
  validates :email, presence: true, length: {in: 1..30},
            uniqueness: true, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i}
  validates :password_digest, presence: true
  validates :password, confirmation: true, presence: true, length: {in: 4..10}
  validates :password_confirmation, presence: true, length: {in: 4..10}
  
  has_secure_password
end
