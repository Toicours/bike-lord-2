require 'open-uri'
require 'json'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@categories = ["Bike", "Scooter", "Moto"]
@user1 = User.create!(email: "paul@gmail.com", is_owner: true, first_name: "Paul", last_name: "Predo", address: "5 rue des Flaques", phone_number: "O611223344", password: "123456")

api_url = "https://bikeindex.org/api/v3/search"
bikes = JSON.parse(URI.open(api_url).read)["bikes"]

bikes.each do |bike|
  if bike["description"].nil?
    description = bike["title"]
  else
    description = bike["description"]
  end
  Bike.create(
    name: bike["manufacturer_name"],
    description: bike["title"],
    category: @categories.sample,
    available: true,
    price: rand(0.100),
    user: User.first
  )
end
