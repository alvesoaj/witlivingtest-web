# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts '### Creating Users'
User.create!(name: 'João Semnome', email: 'joao@email.com', password: '123456789')
User.create!(name: 'Diogo Connome', email: 'diogo@email.com', password: '123456789')

puts '### Creating Products'
Product.create!({
    photo: File.open('db/seeds/files/ror-ecom.jpg'),
    name: 'Learn RoR - Beginner',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 24.99,
    quantity: 50
})
Product.create!({
    photo: File.open('db/seeds/files/ror-bible.jpg'),
    name: 'Mastering RoR - Level over 9000',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 9001.0,
    quantity: 5
})
Product.create!({
    photo: File.open('db/seeds/files/mod-rails.jpg'),
    name: 'Modular Rails',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 34.7,
    quantity: 10
})
Product.create!({
    photo: File.open('db/seeds/files/pratical-ror-projs.jpg'),
    name: 'Pratical Rails Projects',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 14.0,
    quantity: 29
})
Product.create!({
    photo: File.open('db/seeds/files/rest-rails.jpg'),
    name: 'Restfull Rails Development',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 95.2,
    quantity: 200
})
Product.create!({
    photo: File.open('db/seeds/files/ror-agile.jpeg'),
    name: 'Agile Web Development with Rails 5',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 29.1,
    quantity: 7
})
Product.create!({
    photo: File.open('db/seeds/files/ror-auto.jpeg'),
    name: 'Ruby on Rails 5.0 for Autodidacts',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 19.0,
    quantity: 18
})
Product.create!({
    photo: File.open('db/seeds/files/ror-dev.png'),
    name: 'Ruby on Rails Development',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 99.0,
    quantity: 22
})
Product.create!({
    photo: File.open('db/seeds/files/ror-tut.png'),
    name: 'The Ruby on Rails Tutorial',
    description: 'An Amazing book to learn everything to build the world in Ruby.',
    price: 24.99,
    quantity: 50
})