# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

b1 = Book.create(title:"Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"0439554934")
b2 = Book.create(title:"Harry Popper", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"022222")
b3 = Book.create(title:"Mary Poppin", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"033333")
u1 = User.create(email: "kim@berly", name: "kimberly narine", password: "password")
u2 = User.create(email: "k", name: "kim nar", password: "password")

p1 = u1.reviews.create(title:"u1", body:"post 1", book_id: b1.id)
p2 = u1.reviews.create(title:"u1", body:"post 2", book_id: b2.id)
p3 = u2.reviews.create(title:"u2", body:"post 1", book_id: b1.id)


c1 = u1.created_clubs.create(title: "First Club")
u1.created_clubs.create(title: "Second Club")
u2.created_clubs.create(title: "My First Club")

Club.first.book_pairings.create(book_id: b1.id)
Club.first.book_pairings.create(book_id: b3.id)