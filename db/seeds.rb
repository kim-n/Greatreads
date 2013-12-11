# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Book.create(title:"Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"0439554934")
User.create(email: "kim@berly", name: "kimberly narine", password: "password")
u2 = User.new(email: "k", name: "kim nar", password: "password")
u2.save