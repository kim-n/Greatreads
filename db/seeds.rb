require 'open-uri'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)





# 
# 1.times do |t|
#   page = Nokogiri::HTML(open("http://www.amazon.com/gp/bestsellers/books/ref=sv_b_2##{t+1}") )
#   page.css("div.zg_title").css("a").each do |link|
#     book_link = link.attributes()["href"].value.strip
#     book_isbn = book_link.match(/\/dp\/(.*)/i).captures
#     isbns += book_isbn
#   end
# end
# # 




isbns = ['0061120081', '0451524934', '0679783261', '0452284244', '0316769177', '0156012197', '0743273567', '0439554934', '0743477111', '0142437204']

isbns.each do |isbn|
  sleep(1)
  page =Nokogiri::XML(open("https://www.goodreads.com/book/isbn?isbn=#{isbn}&key=#{ENV["GOODREADS_DEV_KEY"]}") )
  title = page.xpath("//book//title")[0].text.strip
  pic = page.xpath("//book//image_url")[0].text.strip
  author = page.xpath("//book//authors//name")[0].text.strip
  description = page.xpath("//book//description")[0].text.strip
  pic.gsub!(/m\//,'l/') unless pic.index("goodreads")
  next if description.include?("https://www.goodreads.com/") || description.nil?
  next if title.length > 36 || title.nil?
  Book.create(title: title, author: author, pic: pic, isbn: isbn, description: description) 
end

image = "https://identicons.github.com/FliPPeh.png"

clone_image = "https://identicons.github.com/807d5a1c7facea5fca0692a25dc6d238.png"

images = ["https://identicons.github.com/glimberg.png",
"https://identicons.github.com/GrantSolar.png"]

images2 = ["https://identicons.github.com/glimberg.png",
"https://identicons.github.com/GrantSolar.png"]


User.create(email: "librarian@greatreads.com", name: "Librarian", password: "password",
admin: 2, image: image)

User.create(email: "guest@greatreads.com", name: "Guest", password: "password",
 admin: 0, image: clone_image)

User.create(email: "love@everything.com", name: "loves_everthing", password: "password",
admin: 0, image: images[0])

User.create(email: "hate@everything.com", name: "hates_everythin", password: "password",
 admin: 0, image: images[1])


User.create(email: "ken@me.com", name: "Jen", password: "password",
admin: 0, image: images2[0])

User.create(email: "ben@me.com", name: "Ben", password: "password",
 admin: 0, image: images2[1])
 
 
 book_lover = User.all[2]
 book_hater = User.all[3]
 
 book_lover.created_clubs.create(title: "Most Loved Books")
 book_hater.created_clubs.create(title: "Most Hated Books")
 
 
 Club.all.each do |club|
   Book.all.each do |book|
     club.book_pairings.create(book_id: book.id)
   end
 end
 
# 
# # create clones
# 3.times do |t|
#  User.create(
#    email: "good_clone#{t}@drone.com",
#    name: "Book_Lover#{t}" ,
#    password: "password",
#    admin: 0,
#    image: clone_image
#    )
# end
# 
# # create clones
# 3.times do |t|
#  User.create(
#    email: "bad_clone#{t}@drone.com",
#    name: "Book_Hater#{t}" ,
#    password: "password",
#    admin: 0,
#    image: clone_image
#    )
# end
# 
# 
# 
# User.all[2..4].each do |user|
#   Book.all.each do |book|
#     user.posts.create(
#       title: "Amazing!",
#       body: "Great book! I really enjoyed it. I recommended it to all my friends.",
#       book_id: book.id
#       )
#   end
# end
# 
# User.all[5..7].each do |user|
#   Book.all.each do |book|
#     user.posts.create(
#       title: "Ugh!",
#       body: "Terrible book! I did not enjoyed it. I recommended it to all my enemies.",
#       book_id: book.id
#       )
#   end
# end
# 
# User.all[2..4].each do |user|
#   Book.all.each do |book|
#     user.tastes.create(
#       book_id: book.id,
#       taste: 1
#     )
#   end
# end
# 
# User.all[5..7].each do |user|
#   Book.all.each do |book|
#     user.tastes.create(
#       book_id: book.id,
#       taste: -1
#     )
#   end
# end
# 
# 
# book_lover = User.all[2]
# book_hater = User.all[5]
# 
# book_lover.created_clubs.create(title: "Most Loved Books")
# book_hater.created_clubs.create(title: "Most Hated Books")
# 
# Club.all.each do |club|
#   id = rand(Book.count) + 1
#   club.book_pairings.create(book_id: id)
#   club.book_pairings.create(book_id: (id + 1) % 8)
#   club.book_pairings.create(book_id: (id + 2) % 8)
# end




#
# User.valid_users.shuffle[0...4].each do |user|
#   user.created_clubs.create(
#     title:Faker::Lorem.word
#   )
# end
#
# book_id = 1
# User.valid_users.each do |user|
#   [4,5,6,7].each do |id|
#     user.reviews.create(
#       title:Faker::Lorem.word,
#       body:Faker::Lorem.sentence,
#       book_id: (id)
#     )
#   end
# end
#
#
# Club.all.each do |club|
#   id = rand(8) + 1
#   club.book_pairings.create(book_id: id)
#   club.book_pairings.create(book_id: (id + 1) % 8)
# end
#
#
#
# book_id = 1
# User.valid_users.shuffle.each do |user|
#
#   3.times do |t|
#     club = Club.all.shuffle[0]
#     user.posts.create(
#       title:Faker::Lorem.word,
#       body:Faker::Lorem.sentence,
#       book_id: club.books.shuffle[0].id,
#       club_id: club.id
#     )
#   end
# end
#
# book_id = 4
# User.valid_users.each do |user|
#
#     user.tastes.create(
#       book_id: (book_id % 7) + 1,
#       taste: -1
#     )
#     user.tastes.create(
#       book_id: ((book_id + 1) % 7) + 1,
#       taste: 0
#     )
#     user.tastes.create(
#       book_id: ((book_id + 2) % 7) + 1,
#       taste: 1
#     )
#
#     book_id = book_id + 1
# end
#


#
# b1 = Book.create(title:"Harry Potter and the Sorcerer's Stone", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"0439554934", description: "YHHSJBdj")
# b2 = Book.create(title:"Harry Popper", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"022222", description: "fsdfsd")
# b3 = Book.create(title:"Mary Poppin", author: "J.K. Rowling", pic: "https://d202m5krfqbpi5.cloudfront.net/books/1361572757l/3.jpg", isbn:"033333", description: "fdsfsd")
#
#
# b1=Book.first
# b2 = Book.all[1]
# b3=Book.all[2]
# User.create(email: "k", name: "k nar", password: "k", admin: 2, image: "https://identicons.github.com/glimberg.png")
# u1 = User.create(email: "kim@berly", name: "kimberly narine", password: "password", admin: 0, image: "https://identicons.github.com/glimberg.png")
# u2 = User.create(email: "kim", name: "kim nar", password: "password", admin: 1,
# image: "https://identicons.github.com/glimberg.png")
# u3 = User.create(email: "test", name: "be blank",  password: "",
# image: "https://identicons.github.com/glimberg.png")
#
# c1 = u1.created_clubs.create(title: "First Club")
# u1.created_clubs.create(title: "Second Club")
# u2.created_clubs.create(title: "My First Club")
#
# Club.first.book_pairings.create(book_id: b1.id)
# Club.first.book_pairings.create(book_id: b3.id)
