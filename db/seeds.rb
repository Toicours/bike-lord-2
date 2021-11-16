require 'open-uri'
require 'json'

puts 'Cleaning DB.....'

Rental.destroy_all
Bike.destroy_all
User.destroy_all

puts 'seeding ....'


@categories = ["Bike", "Scooter", "Moto"]
@messages = ["It's a wonderful bike!", "What a bike to ride!", "My ass remembers the smoothness of the saddle!"]

@user1 = User.create!(email: "paulo@gmail.com", is_owner: true, first_name: "Paul", last_name: "Predo", address: "5 rue des Flaques", phone_number: "O611223344", password: "123456")

api_url = "https://bikeindex.org/api/v3/search"
bikes = JSON.parse(URI.open(api_url).read)["bikes"]
p bikes.size
p "vélos ....."
path = "app/assets/images/bike_placeholder.png"

bikes.each do |bike|
  if bike["description"].nil? ||  bike["description"].size < 6
    description = "#{bike["title"]} #{@messages.sample}"
  else
    description = bike["description"]
  end
  if bike["large_img"].nil?
    image = path
  else
    image = bike["large_img"]
  end
  Bike.create!(
    name: bike["manufacturer_name"],
    description: description,
    image: image,
    category: @categories.sample,
    available: true,
    price: rand(0.100),
    user: User.first
  )
end
