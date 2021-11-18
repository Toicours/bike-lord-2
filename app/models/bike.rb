require 'date'

class Bike < ApplicationRecord
  belongs_to :user
  has_many :rentals, dependent: :destroy
  validates :price, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 6 }
  validates :category, presence: true, inclusion: { in: ['Bike', 'Electric Bike', 'Scooter', 'Moto', 'Monocycle'],
                                                    message: "%{ value } is not a valid category." }
  has_one_attached :image
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_name_description_category,
    against: [ :name, :description, :category ],
    using: {
      tsearch: { prefix: true }
    }


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
