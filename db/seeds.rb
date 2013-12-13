require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



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
  title = page.xpath("//book//work//original_title")[0].content().strip
  title2 = page.xpath("//book//work//original_title")[0].content().strip
  book_title = nil
  if !title.empty?
    book_title = title
  elsif !title2.empty?
    book_title = title
  else
    next
  end
  pic = page.xpath("//book//image_url")[0].content().strip
  author = page.xpath("//book//authors//name")[0].content().strip
  Book.create(title: book_title, author: author, pic: pic, isbn: isbn) unless book_title.nil?
end


User.create(email: "k", name: "Admin", password: "k", admin: 2)

[-1,0,1,2].each do |admin_num|

  (5-admin_num).times do
    username = Faker::Internet.email
    User.create(
      email: username,
      name: Faker::Name.name ,
      password: username,
      admin: admin_num
    )
  end
end

book_id = 1
User.valid_users.each do |user|
  user.reviews.create(
    title:Faker::Lorem.word,
    body:Faker::Lorem.sentence,
    book_id: (book_id % 4)
  )
  book_id = book_id + 1
end


User.valid_users.shuffle[0...4].each do |user|
  user.created_clubs.create(
    title:Faker::Lorem.word
  )
end

book_id = 1
User.valid_users.each do |user|
  [4,5,6,7].each do |id|
    user.reviews.create(
      title:Faker::Lorem.word,
      body:Faker::Lorem.sentence,
      book_id: (id)
    )
  end
end


Club.all.each do |club|
  id = rand(8) + 1
  club.book_pairings.create(book_id: id)
  club.book_pairings.create(book_id: (id + 1) % 8)
end



book_id = 1
User.valid_users.shuffle.each do |user|

  3.times do |t|
    club = Club.all.shuffle[0]
    user.posts.create(
      title:Faker::Lorem.word,
      body:Faker::Lorem.sentence,
      book_id: club.books.shuffle[0].id,
      club_id: club.id
    )
  end
end

book_id = 4
User.valid_users.each do |user|

    user.tastes.create(
      book_id: (book_id % 8) + 1,
      taste: -1
    )
    user.tastes.create(
      book_id: ((book_id + 1) % 8) + 1,
      taste: 0
    )
    user.tastes.create(
      book_id: ((book_id + 2) % 8) + 1,
      taste: 1
    )

    book_id = book_id + 1
end




#
# b1 = Book.create(title:"Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"0439554934")
# b2 = Book.create(title:"Harry Popper", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"022222")
# b3 = Book.create(title:"Mary Poppin", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"033333")
#
#
# b1=Book.first
# b2 = Book.all[1]
# b3=Book.all[2]
# User.create(email: "k", name: "k nar", password: "k", admin: 2)
# u1 = User.create(email: "kim@berly", name: "kimberly narine", password: "password", admin: 0)
# u2 = User.create(email: "kim", name: "kim nar", password: "password", admin: 1)
# u3 = User.create(email: "test", name: "be blank",  password: "")
#
# p1 = u1.reviews.create(title:"u1", body:"post 1", book_id: b1.id)
# p2 = u1.reviews.create(title:"u1", body:"post 2", book_id: b2.id)
# p3 = u2.reviews.create(title:"u2", body:"post 1", book_id: b1.id)
#
#
# c1 = u1.created_clubs.create(title: "First Club")
# u1.created_clubs.create(title: "Second Club")
# u2.created_clubs.create(title: "My First Club")
#
# Club.first.book_pairings.create(book_id: b1.id)
# Club.first.book_pairings.create(book_id: b3.id)
