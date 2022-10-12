# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
if Role.count  < 1
  Role.create([
    {
      name:"master",
      description:"App owner"
    },
    {
      name:"manager",
      description:"Manager of the bar or restaurant who is allow to make changes on the menu"
    }
  ])
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