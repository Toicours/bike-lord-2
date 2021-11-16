require 'open-uri'
require 'json'

puts 'Cleaning DB.....'

Rental.destroy_all
Bike.destroy_all
User.destroy_all

puts 'seeding ....'

@categories = ['Bike', 'Electric Bike', 'Scooter', 'Moto', 'Monocycle']
@messages = ["It's a wonderful bike!", "What a bike to ride!", "My ass remembers the smoothness of the saddle!"]

@user1 = User.create!(email: "paulo@gmail.com", is_owner: true, first_name: "Paul", last_name: "Predo", address: "5 rue des Flaques", phone_number: "O611223344", password: "123456")

api_url = "https://bikeindex.org/api/v3/search"
bikes = JSON.parse(URI.open(api_url).read)["bikes"]
p bikes.size
p "vélos ....."

path = "https://res.cloudinary.com/dn0driagi/image/upload/v1637080266/development/bike_placeholder_cp9tap.png"

bikes.each do |bike|
  if bike["description"].nil? || bike["description"].size < 6
    description = "#{bike["title"]} #{@messages.sample}"
  else
    description = bike["description"]
  end
  if bike["large_img"].nil?
    image = path
  else
    image = bike["large_img"]
  end

  bike = Bike.create!(
    name: bike["manufacturer_name"],
    description: description,
    category: @categories.sample,
    available: true,
    price: rand(0.100),
    user: User.first
  )

  file = URI.open(image)
  bike.image.attach(io: file, filename: bike.name, content_type: 'image/png')
end
