class Mylist < ApplicationRecord
  belongs_to :user
  belongs_to :reservation

  validates :user_id,  presence: true
  validates :reservation_id,  presence: true
end
