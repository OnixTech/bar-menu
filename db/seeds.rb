# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

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

if Role.count < 1
  roles.each do |role|
    Role.create(role)
  end
end

if User.count < 1
  master = User.new(
    email: "a@mail.com",
    password: "a@mail.com",
    active: true,
    role_id: 1
  )
  master.save!

  pfe = User.new(
    email: "info@schankhalle-pfefferberg.de",
    password: "123456",
    active: true,
    role_id: 2
  )
  pfe.save!

  manager = User.new(
    email: "b@mail.com",
    password: "b@mail.com",
    role_id: 2
  )
  manager.save!
end

if Company.count < 1
  company = Company.new(
    name: "Loco Loco",
    city: Faker::Address.city,
    suburb: Faker::Address.community,
    street: Faker::Address.street_name,
    number: Faker::Address.building_number.to_i,
    post: Faker::Address.zip_code.to_i,
    basket: true,
    user_id: 1
  )
  company.save!

  restaurant = Company.new(
    name: "Pfefferberg",
    city: " Berlin",
    suburb: "Prenzlauer Berg",
    street: "Schönhauser Allee",
    number: "176",
    post: "10119",
    basket: true,
    user_id: 2
  )
  restaurant.save!
end

if Station.count < 1
  station = Station.new(
    name: "Bar",
    company_id: 1
  )
  station.save!

  station = Station.new(
    name: "Kitchen",
    company_id: 1
  )
  station.save!

  station = Station.new(
    name: "Main station",
    company_id: 2
  )
  station.save!
end

if Menu.count < 1
  menu = Menu.new(
    title: "Menu",
    subtitle: "Beers",
    company_id: 1,
    position: 1
  )
  menu.save!

  menu2 = Menu.new(
    title: "Menu",
    subtitle: "Snacks",
    company_id: 1,
    position: 2
  )
  menu2.save!

  menu3 = Menu.new(
    title: "Menu",
    subtitle: "Food",
    company_id: 1,
    position: 3
  )
  menu3.save!

  seasonal = Menu.new(
    title: "Saisonale Speisekarte",
    subtitle: "Saisonale Speisekarte",
    company_id: 2,
    position: 1
  )
  seasonal.save!

  bier = Menu.new(
    title: "Craft-Bier",
    subtitle: "Craft-Bier",
    company_id: 2,
    position: 2
  )
  bier.save!

  regular = Menu.new(
    title: "Hauptmenü",
    subtitle: "Hauptmenü",
    company_id: 2,
    position: 0
  )
  regular.save!
end

puts "Charging items to menu Food"

7.times do
  item = Item.new(name: Faker::Food.dish, description: Faker::Food.description,
                  price: format('%.2f', Faker::Number.between(from: 7.0, to: 17.5)),
                  position: Faker::Number.between(from: 1, to: 7), menu_id: 3)
  puts "#{item.name} created!" if item.save!
end

12.times do
  item = Item.new(name: Faker::Beer.name, description: Faker::Dessert.flavor,
                  price: format('%.2f', Faker::Number.between(from: 5.0, to: 8.5)),
                  position: Faker::Number.between(from: 1, to: 12), menu_id: 1)
  puts "#{item.name} created!" if item.save!
  subitem = Subitem.new(name: "small", description: "0.3l",
                        price: 3.80, sumitem: false, item_id: item.id)
  puts "#{subitem.name} created!" if subitem.save!
end

4.times do
  item = Item.new(name: Faker::Dessert.topping, description: Faker::Dessert.flavor,
                  price: format('%.2f', Faker::Number.between(from: 1.0, to: 4)),
                  position: Faker::Number.between(from: 1, to: 4), menu_id: 2)
  puts "#{item.name} created!" if item.save!
end

items = [{ name: "Gemüsegarten", description: "Lauwarmer Salat | Roastbeef | Weichkäse",
           price: 16, position: 1, menu_id: 4 },
         { name: "Pastinake", description: "Crèmesüppchen | Roter Pfeffer",
           price: 9, position: 2, menu_id: 4 },
         { name: "Malzrisotto", description: "Kräuterseitlinge | Rosenkohl",
           price: 15, position: 3, menu_id: 4 },
         { name: "Lammhaxe", description: "Wurzelgemüse | Branderburger Kartoffeln",
           price: 24, position: 4, menu_id: 4 },
         { name: "Apfelstrudel", description: "Vanilleeis",
           price: 12, position: 5, menu_id: 4 }]

items.each do |item|
  item = Item.new(name: item[:name], description: item[:description],
                  price: item[:price], position: item[:position], menu_id: 4)
  puts "#{item.name} created!" if item.save!
end

items2 = [{ name: "Pfefferberg Pils", description: "% 0,3l €3.80",
            price: 5.5, position: 1, menu_id: 5 },
          { name: "Berliner Schnauze", description: "% 0,3l €3.80",
            price: 5.5, position: 2, menu_id: 5 },
          { name: "Flower Power", description: "% 0,3l €3.80",
            price: 5.5, position: 3, menu_id: 5 },
          { name: "Bier der Woche", description: "% 0,3l €3.80",
            price: 5.5, position: 4, menu_id: 5 },
          { name: "Apfelstrudel", description: "% 0,3l €3.80",
            price: 5.5, position: 5, menu_id: 5 }]

items2.each do |item|
  item = Item.new(name: item[:name], description: item[:description],
                  price: item[:price], position: item[:position], menu_id: 5)
  puts "#{item.name} created!" if item.save!
end

items3 = [{ name: "Schankhalle Pfefferberg", description: "Bunte Blattsalate | Eingelegtes Geüse | Geröstete Weißbrotwürfel | Petersiliendressing",
            price: 12.00, position: 1, menu_id: 6 },
          { name: "Matjes", description: "Salat | Äpfel | Schalotten | Gurken | Senfsaat Meerrettichschaum.",
            price: 16.00, position: 3, menu_id: 6 },
          { name: "Ziegenkäse", description: "Geftammt | Thymian | Honig | Balsamico-Feigen | Wildkräutersalat.",
            price: 16.00, position: 2, menu_id: 6 },
          { name: "Tomate", description: "Weißes Crèmesüppchen | Basilikumschaum",
            price: 9.00, position: 4, menu_id: 6 },
          { name: "Brauhauspfanne", description: "Krosse Blutwurst | Karameilisierte Zwiebeln",
            price: 12.00, position: 5, menu_id: 6 },
          { name: "Halbes Brandenburger Grillhähnchen", description: "Würzig Mariniert | Paprika-Dip | Schankchips",
            price: 18.00, position: 6, menu_id: 6 },
          { name: "Currywurst", description: "Havelländer Apfelschwein | Treberbrot",
            price: 9.00, position: 7, menu_id: 6 },
          { name: "Treberstullen", description: "• Matjestatar | Äpfel | Spreewälder Gurke €9.00\r\n• Blutwurstgröstl | Karamellisierte Zwiebeln €9.00\r\n• Gemüse-Relish | Auberginen | Paprika | Champignons Kapernapfel €8.00",
            price: 9.00, position: 8, menu_id: 6 },
          { name: "Kalb", description: "Brauhaus Schnitzel | Treberbrotmantel | Kartoffel-Gurkensalat\r\n Preiselbeerkompott\r\n\r\n• Kross gebratene Leber | Apfel | Schmelzzwiebeln\r\nMalzbiersauce | Kartoffelpüree €22.00",
            price: 24.00, position: 9, menu_id: 6 },
          { name: "Rind", description: "Entrecote vom Grill, 250g | rosmarin-Rotweinsauce\r\nromaneso | Kartoffel-Baumkuchen",
            price: 29.00, position: 10, menu_id: 6 },
          { name: "Seesaibling", description: "Gebralemes Filet | Estragon-buttersauce | Zucherscholen |\r\nTomatisierte Perigraupen",
            price: 24.00, position: 11, menu_id: 6 },
          { name: "Maultaschen", description: "Gefüllt mit Spinat & Frischkäse\r\nRöschen & Puree vom Blumenkohl | Belper Kriolle",
            price: 16.00, position: 12, menu_id: 6 },
          { name: "Spitzkohl-Perlgraupenroulade", description: "Feine Gemüsestreifen | Kräuterrahmsauce",
            price: 25.00, position: 13, menu_id: 6 },
          { name: "Käseteller", description: "Affineur Kober | Feigensenf | Treberbrot\r\n3 Stück €13.00\r\n 5 Stück €17.00",
            price: 13.00, position: 14, menu_id: 6 },
          { name: "Apfelstrudel", description: "Vanillesauce | Vanilleeis",
            price: 10.00, position: 15, menu_id: 6 },
          { name: "Käsekuchen", description: "Erdbeersorbet | Marinierte Erdbeeren",
            price: 10.00, position: 16, menu_id: 6 }]

items3.each do |item|
  item = Item.new(name: item[:name], description: item[:description],
                  price: item[:price], position: item[:position], menu_id: 6)
  puts "#{item.name} created!" if item.save!
end
