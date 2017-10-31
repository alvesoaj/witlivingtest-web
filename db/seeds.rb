# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: 'João Semnome', email: 'joao@email.com', password: '123456789')
User.create!(name: 'Diogo Connome', email: 'diogo@email.com', password: '123456789')


Product.create!(name: 'Learn RoR - Beginner', price: 24.99, quantity: 50)
Product.create!(name: 'Mastering RoR - Level over 9000', price: 9001.00, quantity: 5)