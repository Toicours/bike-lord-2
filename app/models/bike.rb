class Bike < ApplicationRecord
  belongs_to :user
  validates :price, presence: true
  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 6 }
  validates :category, presence: true
end