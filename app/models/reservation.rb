class Reservation < ApplicationRecord
  belongs_to :user
  has_many :mylists, dependent: :destroy
  default_scope -> {
    where('start_date >= ?', Time.current.beginning_of_day) 
  }

  validates :name, presence: true
  validates :start_date, presence: true, uniqueness: true
  validates :user_id, presence: true
  
end
