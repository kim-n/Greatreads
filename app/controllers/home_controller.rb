class HomeController < ApplicationController

  before_filter :require_current_user!, only: [:index]

  def index
    @books = Book.all
    @clubs = Club.all
  end

  def setupdb
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
      sleep(2)
      page =Nokogiri::HTML(open("https://www.goodreads.com/book/isbn?isbn=#{isbn}&key=1yXOk25Y6vrdXcvdZmVOtA") )
      title = page.xpath("//book//title")[0].content().strip
      pic = page.xpath("//book//image_url")[0].content().strip
      author = page.xpath("//book//authors//name")[0].content().strip

      Book.create(title: title, author: author, pic: pic, isbn: isbn)
    end
    @fin = "Finished"
  end
end
