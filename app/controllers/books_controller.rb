require 'open-uri'

class BooksController < ApplicationController

  before_filter :require_current_user!, except: [:index, :show, :create]

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])


    @posts = @book.reviews

    if current_user
      @book_rating = Like.find_rating(current_user.id, @book.id)
      @current_user_review = Post.review_for(current_user.id, @book.id)
    end

    @like_count = @book.likes.count
    @dislike_count = @book.dislikes.count
    render :show
  end

  def create

    book = Book.find_by_isbn(params[:isbn])

    unless book


      url = "https://www.goodreads.com/book/isbn?isbn=#{params[:isbn]}&key=#{ENV["GOODREADS_DEV_KEY"]}"
      begin
        file = open(url)
        page = Nokogiri::XML(file)

        title = page.xpath("//book//title")[0].text.strip
        pic = page.xpath("//book//image_url")[0].text.strip
        author = page.xpath("//book//authors//name")[0].text.strip
        description = page.xpath("//book//description")[0].text.strip

        pic.gsub!(/m\//,'l/') unless pic.index("goodreads")

        book = Book.new(title: title, author: author, pic: pic, isbn: params[:isbn], description: description)

        if book.save
          redirect_to book_url(book.isbn)
        else
          redirect_to books_url
        end

      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          flash[:errors] = ["Book not found"]
          redirect_to books_url
        else
          raise e
        end
      end

    else
      redirect_to book_url(book.isbn)
    end
  end

end

