class BooksController < ApplicationController

  before_filter :require_current_user!, except: [:index, :show]
  before_filter :require_admin_status!, only: [:create, :new]

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])


    @posts = @book.reviews.select("reviews.*, users.name AS username").joins("INNER JOIN users ON reviews.user_id=users.id")
    if current_user
      @book_rating = Like.find_rating(current_user.id, @book.id)
      @current_user_review = Review.where("user_id = ? AND book_id = ?", current_user.id, @book.id)[0]
    end
    
    @like_count = @book.likes.count
    @dislike_count = @book.dislikes.count
    render :show
  end
end

