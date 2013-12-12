require 'nokogiri'
require 'open-uri'


isbns = []

5.times do |t|
  page = Nokogiri::HTML(open("http://www.amazon.com/gp/bestsellers/books/ref=sv_b_2##{t+1}") )
  page.css("div.zg_title").css("a").each do |link|
    book_link = link.attributes()["href"].value.strip
    book_isbn = book_link.match(/\/dp\/(.*)/i).captures
    isbns += book_isbn


  end

end

isbns.each do |isbn|
  page =Nokogiri::HTML(open("https://www.goodreads.com/book/isbn?isbn=0441172717&key=1yXOk25Y6vrdXcvdZmVOtA") )
  title = page.xpath("//book//title")[0].content().strip
  pic = page.xpath("//book//image_url")[0].content().strip
  author = page.xpath("//book//authors//name")[0].content().strip

  Book.create(title: title, author: author, pic: pic, isbn: isbn)
end


