# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
roles = [
  {
    name: "master",
    description: "App owner"
  },
  {
    name: "manager",
    description: "Manager of the bar or restaurant who is allow to make changes on the menu"
  }
]

if Role.count  < 1
  roles.each do |role|
    Role.create(role)
  end
end

if User.count < 1
  master = User.new(
    :email => "a@mail.com",
    :password => "a@mail.com",
    :active => true,
    :role_id => 1
  )
  master.save!
  
  manager = User.new(
    :email => "b@mail.com",
    :password => "b@mail.com",
    :role_id => 2
  )
  manager.save!
end

if Company.count < 1
  company = Company.new(
    :name => Faker::Restaurant.name,
    :city => Faker::Address.city,
    :suburb => Faker::Address.community,
    :street => Faker::Address.street_name,
    :number => Faker::Address.building_number.to_i,
    :post => Faker::Address.zip_code.to_i,
    :user_id => 1
  )
  company.save!
end

if Menu.count < 1
  menu = Menu.new(
    :title => "Menu",
    :subtitle => "Beers",
    :company_id => 1
  )
  menu.save!

  menu2 = Menu.new(
    :title => "Menu",
    :subtitle => "Snacks",
    :company_id => 1
  )
  menu2.save!

  menu3 = Menu.new(
    :title => "Menu",
    :subtitle => "Food",
    :company_id => 1
  )
  menu3.save!
end

puts "Charging items to menu Food"

7.times do 
  item = Item.new(name: Faker::Food.dish, description: Faker::Food.description, price: Faker::Number.between(from: 7.0, to: 17.5), menu_id:3 )
  if item.save!
    puts "#{item.name} created!"
  end
end

12.times do 
  item = Item.new(name: Faker::Beer.name, description: Faker::Dessert.flavor, price: Faker::Number.between(from: 5.0, to: 8.5), menu_id:1 )
  if item.save!
    puts "#{item.name} created!"
  end
end

4.times do 
  item = Item.new(name: Faker::Dessert.topping, description: Faker::Dessert.flavor, price: Faker::Number.between(from: 1.0, to: 12.5), menu_id:2 )
  if item.save!
    puts "#{item.name} created!"
  end
end