class BooksController < ApplicationController

  before_filter :require_current_user!
  before_filter :require_admin_status!, only: [:create, :new]

  def index
    @books = Book.all
    render :index
  end

  def show
    @book = Book.find_by_isbn(params[:id])
    @book_rating = Like.find_rating(current_user.id, @book.id)


    @posts = @book.reviews.select("reviews.*, users.name AS username, users.id AS userid").joins("INNER JOIN users ON reviews.user_id=users.id")
    @current_user_review = Review.where("user_id = ? AND book_id = ?", current_user.id, @book.id)[0]

    @like_count = @book.likes.count
    @dislike_count = @book.dislikes.count
    render :show
  end
end

