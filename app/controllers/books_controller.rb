class BooksController < ApplicationController

  before_filter :require_current_user!

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])
    @book_rating = Like.find_rating(current_user.id, @book.id)

    
    @posts = @book.reviews.select("reviews.*, users.name AS username, users.id AS userid").joins("INNER JOIN users ON reviews.user_id=users.id")
    
    @like_count = @book.likes.count
    @dislike_count = @book.dislikes.count
    render :show
  end
end

