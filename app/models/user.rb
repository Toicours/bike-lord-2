class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  regex_email = /(\A$)|(^(http|https):\/\/[a-z0-9]+([\-.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?\z)/ix
  regex_phone_number = /\A(?:(?:\+|00)33[\s.-]{0,3}(?:\(0\)[\s.-]{0,3})?|0)[1-9](?:(?:[\s.-]?\d{2}){4}|\d{2}(?:[\s.-]?\d{3}){2})\z/ix
  validates :email, uniqueness: { case_sensitive: false }, format: { with: regex_email }, presence: true
  validates :phone_number, format: { with: regex_phone_number }, uniqueness: { case_sensitive: false }, presence: true
  validates :address, length: { minimum: 5 }, presence: true
  validates :first_name, :last_name, presence: true
  has_many :rentals
  has_many :bikes, through: :rentals

end
