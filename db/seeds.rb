require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# b1 = Book.create(title:"Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"0439554934")
# b2 = Book.create(title:"Harry Popper", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"022222")
# b3 = Book.create(title:"Mary Poppin", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"033333")


isbns = []

1.times do |t|
  page = Nokogiri::HTML(open("http://www.amazon.com/gp/bestsellers/books/ref=sv_b_2##{t+1}") )
  page.css("div.zg_title").css("a").each do |link|
    book_link = link.attributes()["href"].value.strip
    book_isbn = book_link.match(/\/dp\/(.*)/i).captures
    isbns += book_isbn
  end
end

isbns.each do |isbn|
  sleep(2)
  page =Nokogiri::HTML(open("https://www.goodreads.com/book/isbn?isbn=#{isbn}&key=1yXOk25Y6vrdXcvdZmVOtA") )
  title = page.xpath("//book//title")[0].content().strip
  pic = page.xpath("//book//image_url")[0].content().strip
  author = page.xpath("//book//authors//name")[0].content().strip

  Book.create(title: title, author: author, pic: pic, isbn: isbn)
end

b1=Book.first
b2 = Book.all[1]
b3=Book.all[2]
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
