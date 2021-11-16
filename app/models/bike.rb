class Bike < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  validates :price, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 6 }
  validates :category, presence: true
  has_one_attached :image

require 'date'

  def availability?(start_date_user, end_date_user)

    user_dates = (start_date_user..end_date_user).map(&:to_s)
    p rentals
    all_booked_dates = rentals.map do |rental|
      rental.rental_dates
    end
    all_booked_dates = all_booked_dates.flatten
    (all_booked_dates & user_dates).length > 0 ? false : true
  end
end
