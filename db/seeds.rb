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
    :role_id => 2
  )
  master.save!
end

if Company.count < 1
  company = Company.new(
    :name => "La Pocilga",
    :city => "Berlin",
    :suburb => "Weddin",
    :street => "Koloniestrasse",
    :number => "78",
    :post => "13359",
    :user_id => 1
  )
  company.save!
end

if Menu.count < 1
  menu = Menu.new(
    :title => "Menu",
    :subtitle => "Drinks",
    :company_id => 1
  )
  menu.save!
end

item = Item.new(
  :name => "Cuba Libre",
  :description => "coca cola, run",
  :price => 6,
  :menu_id => 1
)
item.save!
