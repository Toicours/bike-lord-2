class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  regex_email = /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i
  validates :email, uniqueness: { case_sensitive: false }, format: { with: regex_email }, presence: true
  validates :phone_number, uniqueness: { case_sensitive: false }, presence: true
  validates :address, length: { minimum: 5 }, presence: true
  validates :first_name, :last_name, presence: true
  has_many :rentals
  has_many :bikes, through: :rentals
end
