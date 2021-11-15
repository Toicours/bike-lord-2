class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :bike
  validates :total_price, presence: true
  validates :user_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
