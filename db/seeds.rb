# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Using Faker to put data in table

10.times do
  Product.create({
      name: Faker::Superhero.name,
      description: Faker::Superhero.power,
      item_id: Faker::Number.number(7),
      price: Faker::Number.decimal(2, 2),
      quantity: Faker::Number.number(2)
                 })
end